import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'track_parcel_model.dart';
export 'track_parcel_model.dart';

class TrackParcelWidget extends StatefulWidget {
  const TrackParcelWidget({
    super.key,
    this.bookingRef,
    this.rideRef,
    this.bookingId,
  });

  final DocumentReference? bookingRef;
  final DocumentReference? rideRef;
  final String? bookingId;

  static String routeName = 'TrackParcel';
  static String routePath = '/trackParcel';

  @override
  State<TrackParcelWidget> createState() => _TrackParcelWidgetState();
}

class _TrackParcelWidgetState extends State<TrackParcelWidget>
    with SingleTickerProviderStateMixin {
  late TrackParcelModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Map controller & layers
  gmaps.GoogleMapController? _mapController;
  final Set<gmaps.Marker> _markers = {};
  final Set<gmaps.Polyline> _polylines = {};

  // Custom Circular Marker Icons
  gmaps.BitmapDescriptor? _vehicleIcon;
  gmaps.BitmapDescriptor? _pickupIcon;
  gmaps.BitmapDescriptor? _deliveryIcon;

  // Pulse animation for LIVE radar badge
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Dynamic Route Points based on user booking (defaults to Jamnagar -> Ahmedabad)
  List<gmaps.LatLng> _routePoints = _createInitialRoute(
    const gmaps.LatLng(22.4707, 70.0577),
    const gmaps.LatLng(23.0225, 72.5714),
    70,
  );
  String _pickupCityName = 'Jamnagar';
  String _deliveryCityName = 'Ahmedabad';
  String _pickupAddress = 'Jamnagar, Gujarat';
  String _deliveryAddress = 'Ahmedabad, Gujarat';

  int _currentWaypointIndex = 20; // In transit
  Timer? _motionTimer;
  bool _autoFollow = true;
  double _remainingKm = 175.0;
  int _remainingMins = 110;
  double _currentBearing = 75.0;
  StreamSubscription? _firestoreSubscription;

  static List<gmaps.LatLng> _createInitialRoute(gmaps.LatLng from, gmaps.LatLng to, int steps) {
    final List<gmaps.LatLng> points = [];
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final curve = math.sin(t * math.pi) * 0.025;
      final lat = from.latitude + (to.latitude - from.latitude) * t + curve;
      final lng = from.longitude + (to.longitude - from.longitude) * t - (curve * 0.35);
      points.add(gmaps.LatLng(lat, lng));
    }
    return points;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackParcelModel());

    // Radar pulse animation
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Update markers immediately with initial route
    _updateMarkersAndPolylines();

    _loadCustomCircleMarkers().then((_) {
      _initBookingLocationData();
    });
  }

  // ── Custom Circular Marker Icon Generator (Sleek & Compact) ───────────────
  Future<void> _loadCustomCircleMarkers() async {
    _vehicleIcon = await _generateCircleMarker(
      bgColor: const Color(0xFFFF6B35),
      icon: Icons.navigation_rounded,
      size: 42,
      showArrow: true,
    );
    _pickupIcon = await _generateCircleMarker(
      bgColor: const Color(0xFF10B981),
      icon: Icons.trip_origin_rounded,
      size: 32,
    );
    _deliveryIcon = await _generateCircleMarker(
      bgColor: const Color(0xFFEF4444),
      icon: Icons.location_on_rounded,
      size: 32,
    );
    if (mounted) setState(() {});
  }

  Future<gmaps.BitmapDescriptor> _generateCircleMarker({
    required Color bgColor,
    required IconData icon,
    double size = 42,
    bool showArrow = false,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final center = Offset(size / 2, size / 2);
    final radius = (size / 2) - 3;

    // 1. Soft Shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center.translate(0, 1.5), radius, shadowPaint);

    // 2. Crisp White Outer Ring
    final Paint whiteRingPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, whiteRingPaint);

    // 3. Colored Circular Base
    final Paint colorFillPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 2.5, colorFillPaint);

    // 4. Centered Icon Glyph
    final TextPainter textPainter = TextPainter(textDirection: ui.TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size * 0.44,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: Colors.white,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return gmaps.BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }

  // ── Helper to resolve coordinates from city names ─────────────────────────
  gmaps.LatLng? _resolveCityCoordinate(String? cityName) {
    if (cityName == null || cityName.isEmpty) return null;
    final lower = cityName.toLowerCase();
    if (lower.contains('jamnagar')) return const gmaps.LatLng(22.4707, 70.0577);
    if (lower.contains('ahmedabad') || lower.contains('amdavad')) return const gmaps.LatLng(23.0225, 72.5714);
    if (lower.contains('rajkot')) return const gmaps.LatLng(22.3039, 70.8022);
    if (lower.contains('surat')) return const gmaps.LatLng(21.1702, 72.8311);
    if (lower.contains('vadodara') || lower.contains('baroda')) return const gmaps.LatLng(22.3072, 73.1812);
    if (lower.contains('bhavnagar')) return const gmaps.LatLng(21.7645, 72.1519);
    if (lower.contains('junagadh')) return const gmaps.LatLng(21.5222, 70.4579);
    if (lower.contains('gandhinagar')) return const gmaps.LatLng(23.2156, 72.6369);
    if (lower.contains('chandigarh')) return const gmaps.LatLng(30.7333, 76.7794);
    if (lower.contains('delhi')) return const gmaps.LatLng(28.6129, 77.2295);
    if (lower.contains('mumbai')) return const gmaps.LatLng(19.0760, 72.8777);
    return null;
  }

  // ── Initialize Location Data From Booking / Ride ───────────────────────────
  Future<void> _initBookingLocationData() async {
    gmaps.LatLng? pickupCoord;
    gmaps.LatLng? deliveryCoord;

    DocumentReference? activeRideRef = widget.rideRef;

    // 1. If bookingRef is passed without rideRef, find the associated ride
    if (activeRideRef == null && widget.bookingRef != null) {
      try {
        final bSnap = await widget.bookingRef!.get();
        if (bSnap.exists) {
          final bData = bSnap.data() as Map<String, dynamic>?;
          activeRideRef = bData?['rideID'] as DocumentReference?;
          final meetup = bData?['rideMeetupAddress'] ?? bData?['meetupLocation'];
          if (meetup is String && meetup.isNotEmpty) {
            _pickupAddress = meetup;
            _pickupCityName = meetup.split(',').first.trim();
          }
          final meetupLatLng = bData?['meetupLocationMap'];
          if (meetupLatLng is LatLng) {
            pickupCoord = gmaps.LatLng(meetupLatLng.latitude, meetupLatLng.longitude);
          }
        }
      } catch (e) {
        debugPrint('Error reading bookingRef: $e');
      }
    }

    // 2. Read Ride details (from start location to end location)
    if (activeRideRef != null) {
      try {
        final rideSnap = await activeRideRef.get();
        if (rideSnap.exists) {
          final ride = RidesNewRecord.fromSnapshot(rideSnap);
          if (ride.rideStartLocation.isNotEmpty) {
            _pickupAddress = ride.rideStartLocation;
            _pickupCityName = ride.rideStartLocation.split(',').first.trim();
          }
          if (ride.rideEndLocation.isNotEmpty) {
            _deliveryAddress = ride.rideEndLocation;
            _deliveryCityName = ride.rideEndLocation.split(',').first.trim();
          }

          if (ride.rideStartLocationGoogle != null) {
            pickupCoord = gmaps.LatLng(
              ride.rideStartLocationGoogle!.latitude,
              ride.rideStartLocationGoogle!.longitude,
            );
          } else if (ride.pickLocationMap != null) {
            pickupCoord = gmaps.LatLng(
              ride.pickLocationMap!.latitude,
              ride.pickLocationMap!.longitude,
            );
          }

          if (ride.rideEndLocationGoogle != null) {
            deliveryCoord = gmaps.LatLng(
              ride.rideEndLocationGoogle!.latitude,
              ride.rideEndLocationGoogle!.longitude,
            );
          }
        }
      } catch (e) {
        debugPrint('Error reading rideRef: $e');
      }
    }

    // 3. Fallback resolution via city names if GPS LatLng was empty
    pickupCoord ??= _resolveCityCoordinate(_pickupAddress) ?? const gmaps.LatLng(22.4707, 70.0577);
    deliveryCoord ??= _resolveCityCoordinate(_deliveryAddress) ?? const gmaps.LatLng(23.0225, 72.5714);

    // 4. Generate smooth, realistic highway route (70 gentle micro-steps)
    _routePoints = _generateSmoothRoute(pickupCoord, deliveryCoord, 70);

    // Start midway (In Transit)
    _currentWaypointIndex = (_routePoints.length * 0.3).floor();
    if (_routePoints.length > 1) {
      _currentBearing = _calculateBearing(
        _routePoints[_currentWaypointIndex],
        _routePoints[_currentWaypointIndex + 1],
      );
    }

    _updateMarkersAndPolylines();
    _startLiveTrackingEngine();
    if (_mapController != null && _routePoints.isNotEmpty) {
      _mapController!.animateCamera(
        gmaps.CameraUpdate.newCameraPosition(
          gmaps.CameraPosition(
            target: _routePoints[_currentWaypointIndex],
            zoom: 14.5,
            bearing: _currentBearing,
            tilt: 36.0,
          ),
        ),
      );
    }
  }

  // Generates smooth intermediate waypoints between two coordinates
  List<gmaps.LatLng> _generateSmoothRoute(gmaps.LatLng from, gmaps.LatLng to, int steps) {
    final List<gmaps.LatLng> points = [];
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      // Gentle natural highway curvature
      final curve = math.sin(t * math.pi) * 0.025;
      final lat = from.latitude + (to.latitude - from.latitude) * t + curve;
      final lng = from.longitude + (to.longitude - from.longitude) * t - (curve * 0.35);
      points.add(gmaps.LatLng(lat, lng));
    }
    return points;
  }

  // ── Live Motion Engine (Calm, Realistic Speed & Continuous Auto-Scroll) ────
  void _startLiveTrackingEngine() {
    _motionTimer?.cancel();
    // 3.2 seconds per step for a relaxed, realistic cruising movement
    _motionTimer = Timer.periodic(const Duration(milliseconds: 3200), (timer) {
      if (!mounted) return;

      setState(() {
        if (_currentWaypointIndex < _routePoints.length - 1) {
          final from = _routePoints[_currentWaypointIndex];
          _currentWaypointIndex++;
          final to = _routePoints[_currentWaypointIndex];

          // Compute road turn angle (bearing)
          _currentBearing = _calculateBearing(from, to);

          // Update dynamic distance and ETA smoothly
          final remainingSteps = _routePoints.length - 1 - _currentWaypointIndex;
          _remainingKm = math.max(0.5, remainingSteps * 3.8);
          _remainingMins = math.max(2, (remainingSteps * 3.2).round());

          _updateMarkersAndPolylines();

          // Continuous gentle automatic map scroll & camera tracking
          if (_autoFollow && _mapController != null) {
            _mapController!.animateCamera(
              gmaps.CameraUpdate.newCameraPosition(
                gmaps.CameraPosition(
                  target: to,
                  zoom: 14.5,
                  bearing: _currentBearing,
                  tilt: 36.0,
                ),
              ),
            );
          }
        } else {
          // Loop around slowly to maintain active testing experience
          _currentWaypointIndex = 12;
          _updateMarkersAndPolylines();
          if (_autoFollow && _mapController != null && _routePoints.isNotEmpty) {
            _mapController!.animateCamera(
              gmaps.CameraUpdate.newCameraPosition(
                gmaps.CameraPosition(
                  target: _routePoints[_currentWaypointIndex],
                  zoom: 14.5,
                  bearing: _currentBearing,
                  tilt: 36.0,
                ),
              ),
            );
          }
        }
      });
    });
  }

  void _updateMarkersAndPolylines() {
    if (_routePoints.isEmpty) return;

    final currentPos = _routePoints[_currentWaypointIndex];
    final pickupPos = _routePoints.first;
    final deliveryPos = _routePoints.last;

    _markers.clear();

    // 1. Circular Pickup Marker
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('pickup'),
        position: pickupPos,
        anchor: const Offset(0.5, 0.5),
        icon: _pickupIcon ??
            gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueGreen),
        infoWindow: gmaps.InfoWindow(title: 'Pickup', snippet: _pickupCityName),
      ),
    );

    // 2. Circular Delivery Marker
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('delivery'),
        position: deliveryPos,
        anchor: const Offset(0.5, 0.5),
        icon: _deliveryIcon ??
            gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueRed),
        infoWindow: gmaps.InfoWindow(title: 'Delivery', snippet: _deliveryCityName),
      ),
    );

    // 3. Circular Moving Vehicle Marker with Live Bearing Rotation
    _markers.add(
      gmaps.Marker(
        markerId: const gmaps.MarkerId('driver'),
        position: currentPos,
        rotation: _currentBearing,
        anchor: const Offset(0.5, 0.5),
        flat: true,
        icon: _vehicleIcon ??
            gmaps.BitmapDescriptor.defaultMarkerWithHue(gmaps.BitmapDescriptor.hueOrange),
        infoWindow: gmaps.InfoWindow(
          title: 'In Transit · ~$_remainingMins mins',
          snippet: '${_remainingKm.toStringAsFixed(1)} km remaining',
        ),
      ),
    );

    // Two-Tone Polylines: Covered Road (Gray) vs Ahead (Vibrant Green)
    _polylines.clear();

    if (_currentWaypointIndex > 0) {
      _polylines.add(
        gmaps.Polyline(
          polylineId: const gmaps.PolylineId('covered_route'),
          points: _routePoints.sublist(0, _currentWaypointIndex + 1),
          color: const Color(0xFF94A3B8),
          width: 5,
        ),
      );
    }

    _polylines.add(
      gmaps.Polyline(
        polylineId: const gmaps.PolylineId('remaining_route'),
        points: _routePoints.sublist(_currentWaypointIndex),
        color: const Color(0xFF10B981),
        width: 6,
      ),
    );
  }

  double _calculateBearing(gmaps.LatLng start, gmaps.LatLng end) {
    final lat1 = start.latitude * (math.pi / 180.0);
    final lon1 = start.longitude * (math.pi / 180.0);
    final lat2 = end.latitude * (math.pi / 180.0);
    final lon2 = end.longitude * (math.pi / 180.0);
    final dLon = lon2 - lon1;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final radians = math.atan2(y, x);
    return (radians * (180.0 / math.pi) + 360.0) % 360.0;
  }

  @override
  void dispose() {
    _motionTimer?.cancel();
    _firestoreSubscription?.cancel();
    _pulseController.dispose();
    _mapController?.dispose();
    _model.dispose();
    super.dispose();
  }

  String get _trackingId => widget.bookingId ?? 'TRVIA123456789';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF111827)),
          onPressed: () => Navigator.of(context).canPop()
              ? Navigator.of(context).pop()
              : context.goNamed('HomePage'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track Parcel',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  'Tracking ID: $_trackingId',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: _trackingId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tracking ID copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.copy_rounded,
                    size: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: TextButton.icon(
              onPressed: () => _showHelpBottomSheet(context),
              icon: const Icon(Icons.headset_mic_outlined, size: 18, color: Color(0xFF374151)),
              label: Text(
                'Help',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Insured Banner
              _buildInsuredBanner(),
              const SizedBox(height: 14),

              // 2. Transit Status Header with Countdown
              _buildTransitHeaderCard(),
              const SizedBox(height: 16),

              // 3. Milestone Progress Stepper
              _buildMilestoneStepper(),
              const SizedBox(height: 16),

              // 4. Live Map Card with Continuous Auto-Scroll & Custom Circular Markers
              _buildLiveMapCard(),
              const SizedBox(height: 18),

              // 5. Tracking Updates Timeline
              _buildTrackingUpdatesSection(),
              const SizedBox(height: 18),

              // 6. Parcel Summary Card
              _buildParcelSummaryCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  // ── 1. Insured Banner ──────────────────────────────────────────────────────
  Widget _buildInsuredBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA5D6A7), width: 0.8),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_user_rounded, color: Color(0xFF2E7D32), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Your parcel is insured and in safe hands',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B5E20),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Travia Insurance covers up to ₹10,000 for verified shipments.'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  'View Details',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFF2E7D32)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 2. Transit Status Header ───────────────────────────────────────────────
  Widget _buildTransitHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.local_shipping_rounded,
              color: Color(0xFF10B981),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'In Transit',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Your parcel is moving on route to $_deliveryCityName.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Expected Delivery',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Today, 24 May',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              Text(
                'In ~$_remainingMins mins',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── 3. Milestone Stepper ───────────────────────────────────────────────────
  Widget _buildMilestoneStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem(
            icon: Icons.assignment_turned_in_rounded,
            title: 'Confirmed',
            time: '24 May, 11:00 AM',
            isCompleted: true,
            isActive: false,
          ),
          _buildStepConnector(isCompleted: true),
          _buildStepItem(
            icon: Icons.inventory_2_rounded,
            title: 'Picked Up',
            time: '24 May, 12:15 PM',
            isCompleted: true,
            isActive: false,
          ),
          _buildStepConnector(isCompleted: true),
          _buildStepItem(
            icon: Icons.local_shipping_rounded,
            title: 'In Transit',
            time: 'Live On Route',
            isCompleted: false,
            isActive: true,
          ),
          _buildStepConnector(isCompleted: false),
          _buildStepItem(
            icon: Icons.check_circle_outline_rounded,
            title: 'Delivered',
            time: 'Pending',
            isCompleted: false,
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required IconData icon,
    required String title,
    required String time,
    required bool isCompleted,
    required bool isActive,
  }) {
    final color = isCompleted || isActive ? const Color(0xFF10B981) : const Color(0xFF9CA3AF);
    final bgColor = isCompleted || isActive ? const Color(0xFFE8F5E9) : const Color(0xFFF3F4F6);

    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: isActive ? 2 : 1,
              ),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              color: isActive ? const Color(0xFF10B981) : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 9,
              color: isActive ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector({required bool isCompleted}) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        height: 2,
        color: isCompleted ? const Color(0xFF10B981) : const Color(0xFFE5E7EB),
      ),
    );
  }

  // ── 4. Live Map Card with Circular Icons & Continuous Auto-Scroll ───────────
  Widget _buildLiveMapCard() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            gmaps.GoogleMap(
              initialCameraPosition: gmaps.CameraPosition(
                target: _routePoints.isNotEmpty ? _routePoints[_currentWaypointIndex] : const gmaps.LatLng(22.4707, 70.0577),
                zoom: 14.5,
                bearing: _currentBearing,
                tilt: 36.0,
              ),
              markers: _markers,
              polylines: _polylines,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) {
                _mapController = controller;
                if (_routePoints.isNotEmpty) {
                  controller.animateCamera(
                    gmaps.CameraUpdate.newCameraPosition(
                      gmaps.CameraPosition(
                        target: _routePoints[_currentWaypointIndex],
                        zoom: 14.5,
                        bearing: _currentBearing,
                        tilt: 36.0,
                      ),
                    ),
                  );
                }
              },
            ),

            // Top-Left: Dynamic Booked Pickup Badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Picked Up',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          _pickupCityName,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Top-Right: Pulsing "LIVE" Radar Badge
            Positioned(
              top: 12,
              right: 12,
              child: ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withValues(alpha: 0.45),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'LIVE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom-Left: Live Dynamic ETA Pill
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827).withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.navigation_rounded,
                      color: Color(0xFF10B981),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${_remainingKm.toStringAsFixed(1)} km · ~$_remainingMins mins',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom-Right: Re-Center on Vehicle Button
            Positioned(
              bottom: 12,
              right: 12,
              child: InkWell(
                onTap: () {
                  setState(() => _autoFollow = true);
                  if (_routePoints.isNotEmpty) {
                    final currentPos = _routePoints[_currentWaypointIndex];
                    _mapController?.animateCamera(
                      gmaps.CameraUpdate.newCameraPosition(
                        gmaps.CameraPosition(
                          target: currentPos,
                          zoom: 14.5,
                          bearing: _currentBearing,
                          tilt: 36.0,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    _autoFollow ? Icons.my_location_rounded : Icons.location_searching_rounded,
                    color: _autoFollow ? const Color(0xFF10B981) : const Color(0xFF4B5563),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── 5. Tracking Updates Timeline ───────────────────────────────────────────
  Widget _buildTrackingUpdatesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tracking Updates',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF111827),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _model.viewAllUpdates = !_model.viewAllUpdates;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      _model.viewAllUpdates ? 'Show Less' : 'View All Updates',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    Icon(
                      _model.viewAllUpdates
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: const Color(0xFF6B7280),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildTimelineEntry(
            icon: Icons.local_shipping_rounded,
            iconColor: const Color(0xFF10B981),
            bgColor: const Color(0xFFE8F5E9),
            title: 'In Transit',
            description: 'Your parcel is moving on route to $_deliveryCityName.',
            timestamp: 'Live Active · 01:45 PM',
            isLast: false,
          ),
          _buildTimelineEntry(
            icon: Icons.location_on_rounded,
            iconColor: const Color(0xFF10B981),
            bgColor: const Color(0xFFE8F5E9),
            title: 'Picked Up',
            description: 'Parcel has been picked up from sender at $_pickupCityName.',
            timestamp: '24 May 2025 · 12:15 PM',
            isLast: false,
          ),
          _buildTimelineEntry(
            icon: Icons.assignment_turned_in_rounded,
            iconColor: const Color(0xFF10B981),
            bgColor: const Color(0xFFE8F5E9),
            title: 'Confirmed',
            description: 'Your parcel booking is confirmed.',
            timestamp: '24 May 2025 · 11:00 AM',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEntry({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String description,
    required String timestamp,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 38,
                color: const Color(0xFFE5E7EB),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timestamp,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── 6. Parcel Summary Card ─────────────────────────────────────────────────
  Widget _buildParcelSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parcel Summary',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.inventory_2_outlined,
                  label: 'Parcel Type',
                  value: 'Documents',
                ),
              ),
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.trip_origin_rounded,
                  iconColor: const Color(0xFF10B981),
                  label: 'From',
                  value: _pickupAddress,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.scale_outlined,
                  label: 'Weight',
                  value: '2 kg',
                ),
              ),
              Expanded(
                child: _buildSummaryTile(
                  icon: Icons.location_on_rounded,
                  iconColor: const Color(0xFFEF4444),
                  label: 'To',
                  value: _deliveryAddress,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile({
    required IconData icon,
    Color? iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: iconColor ?? const Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111827),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── 7. Bottom Action Bar ───────────────────────────────────────────────────
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Chat Support
          Expanded(
            flex: 4,
            child: OutlinedButton.icon(
              onPressed: () => _openChat(context),
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Color(0xFF374151)),
              label: Text(
                'Chat Support',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(width: 6),
          // Call Support
          Expanded(
            flex: 4,
            child: OutlinedButton.icon(
              onPressed: () => _openCall(context),
              icon: const Icon(Icons.call_outlined, size: 16, color: Color(0xFF374151)),
              label: Text(
                'Call Support',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                side: const BorderSide(color: Color(0xFFD1D5DB)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(width: 6),
          // Delivery Alerts Toggle Button
          Expanded(
            flex: 5,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _model.smsAlertsEnabled = !_model.smsAlertsEnabled;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _model.smsAlertsEnabled
                          ? '🔔 Delivery alerts turned ON (SMS updates)'
                          : '🔕 Delivery alerts paused',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                _model.smsAlertsEnabled ? Icons.notifications_active_rounded : Icons.notifications_off_rounded,
                size: 16,
                color: Colors.white,
              ),
              label: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Alerts',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _model.smsAlertsEnabled ? 'SMS updates on' : 'Updates off',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Connecting to 24/7 Travia Support chat...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openCall(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Call Support'),
        content: const Text('Call Travia Helpline at +91 1800-123-4567?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dialing support...')),
              );
            },
            child: const Text('Call Now'),
          ),
        ],
      ),
    );
  }

  void _showHelpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Help with Tracking?',
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              '• Live location updates are available exclusively for Premium members.\n'
              '• Location is synced every 10–15 seconds while the vehicle is in motion.\n'
              '• If you need immediate assistance, use the Call Support button below.',
              style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF4B5563), height: 1.5),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Got it', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
