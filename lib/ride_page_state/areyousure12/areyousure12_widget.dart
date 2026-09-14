import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'areyousure12_model.dart';
export 'areyousure12_model.dart';

class Areyousure12Widget extends StatefulWidget {
  const Areyousure12Widget({super.key});

  static String routeName = 'Areyousure12';
  static String routePath = '/areyousure12';

  @override
  State<Areyousure12Widget> createState() => _Areyousure12WidgetState();
}

class _Areyousure12WidgetState extends State<Areyousure12Widget> {
  late Areyousure12Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isPublishing = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Areyousure12Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _discardAndExit() async {
    FFAppState().RideStartLocaction = '';
    FFAppState().RideEndLocaction = '';
    FFAppState().pickupTime = null;
    FFAppState().DropTime = null;
    FFAppState().isPredefinedItems = false;
    FFAppState().isPassengers = '';
    FFAppState().numPassengers = 0;
    FFAppState().pricePerPassengers = 0;
    FFAppState().numBagAllowed = 0;
    FFAppState().isRiderulesAccepted = false;
    FFAppState().isTermAccepted = false;
    FFAppState().rideRule1 = '';
    FFAppState().rideRule2 = '';
    FFAppState().rideRule3 = '';
    FFAppState().rideRule4 = '';
    FFAppState().rideRule5 = '';
    FFAppState().rideRule6 = '';
    FFAppState().rideRule7 = '';
    FFAppState().rideRule8 = '';
    FFAppState().modeOfTransport = '';
    FFAppState().travelTime = '';
    FFAppState().vehicleNumber = '';
    FFAppState().totalDelvieryCost = '';
    FFAppState().DriverNumber = '';
    safeSetState(() {});

    context.pushNamed(HomeWidget.routeName);
  }

  Future<void> _showSuccessDialog({
    required String startLocation,
    required String endLocation,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 28.0,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Glowing Checkmark Badge
                Container(
                  width: 86.0,
                  height: 86.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF7F2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD1FAE5),
                      width: 5.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A10B981),
                        blurRadius: 20.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF10B981),
                      size: 52.0,
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 550.ms, curve: Curves.elasticOut)
                    .shimmer(duration: 900.ms, color: const Color(0x3310B981)),

                const SizedBox(height: 20.0),

                // Animated Title
                Text(
                  'Ride Published! 🎉',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.25, end: 0.0),

                const SizedBox(height: 10.0),

                // Subtitle
                Text(
                  'Your trip is posted successfully. Once safety verified by Travia, it will go live for travellers to discover.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.45,
                  ),
                ).animate().fadeIn(delay: 120.ms, duration: 400.ms),

                const SizedBox(height: 18.0),

                // Route summary badge
                if (startLocation.isNotEmpty && endLocation.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.trip_origin_rounded,
                          size: 15.0,
                          color: Color(0xFF10B981),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            startLocation.split(',').first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 14.0,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const Icon(
                          Icons.location_on_rounded,
                          size: 15.0,
                          color: Color(0xFFEE7B4D),
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            endLocation.split(',').first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.15, end: 0.0),

                const SizedBox(height: 24.0),

                // Action Button
                InkWell(
                  onTap: () {
                    Navigator.pop(dialogContext);
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 52.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33EE7B4D),
                          blurRadius: 14.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View My Published Rides',
                          style: GoogleFonts.inter(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ).animate().scale(delay: 300.ms, duration: 400.ms, curve: Curves.easeOutBack),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _publishRide(AdminApprovalOnRidesRecord? adminApprovalRecord) async {
    if (_isPublishing) return;
    setState(() => _isPublishing = true);

    try {
      await RidesNewRecord.collection.doc().set({
        ...createRidesNewRecordData(
          rideStartLocation: FFAppState().RideStartLocaction,
          rideEndLocation: FFAppState().RideEndLocaction,
          pickupTime: FFAppState().pickupTime,
          dropTime: FFAppState().DropTime,
          isPredefinedItems: FFAppState().isPredefinedItems,
          numPassengers: FFAppState().numPassengers,
          pricePerPassengers: FFAppState().pricePerPassengers,
          numBagAllowed: FFAppState().numBagAllowed,
          rideRule1: FFAppState().rideRule1,
          rideRule2: FFAppState().rideRule2,
          rideRule3: FFAppState().rideRule3,
          rideRule4: FFAppState().rideRule4,
          rideRule5: FFAppState().rideRule5,
          rideRule6: FFAppState().rideRule6,
          isTermAccepted: FFAppState().isRiderulesAccepted,
          modeOfTransport: FFAppState().modeOfTransport,
          travelTime: FFAppState().travelTime,
          vehicleNumber: FFAppState().vehicleNumber,
          totalDeliveryCost: FFAppState().totalDelvieryCost,
          driverNumber: FFAppState().DriverNumber,
          creatorID: currentUserReference,
          isRideApproved: false,
          createdTime: getCurrentTimestamp,
          rideID: random_data.randomInteger(2, 10).toString(),
          rideStatus: adminApprovalRecord?.isDirectApproved,
          isPassangerAllowedinCar: FFAppState().isPassengers,
          isRideRulesAccepted: FFAppState().isRiderulesAccepted,
          rideStartLocationGoogle: FFAppState().rideStartLocationGoogle,
          rideEndLocationGoogle: FFAppState().rideEndLocationGoogle,
          rideCost: FFAppState().pricePerPassengers.toDouble(),
          googleStartAddress: FFAppState().GoogleStartAddress,
          googleEndAddress: FFAppState().GoogleEndAddress,
        ),
        ...mapToFirestore({
          'caryyItems': FFAppState().carryItemNormalRides,
          'stoppages': FFAppState().stoppageNormalParcaleRide,
        }),
      });

      if (mounted) {
        await _showSuccessDialog(
          startLocation: FFAppState().RideStartLocaction,
          endLocation: FFAppState().RideEndLocaction,
        );

        // Reset state
        FFAppState().pickupTime = null;
        FFAppState().DropTime = null;
        FFAppState().isPredefinedItems = false;
        FFAppState().isPassengers = '';
        FFAppState().numPassengers = 0;
        FFAppState().isRiderulesAccepted = false;
        FFAppState().isTermAccepted = false;
        FFAppState().travelTime = '';
        safeSetState(() {});

        context.goNamed(
          HomeWidget.routeName,
          queryParameters: {
            'tabNumberRef': serializeParam(2, ParamType.int),
          }.withoutNulls,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error publishing ride: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPublishing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    final start = FFAppState().RideStartLocaction;
    final end = FFAppState().RideEndLocaction;
    final startTime = FFAppState().pickupTime;
    final endTime = FFAppState().DropTime;
    final mode = FFAppState().modeOfTransport.isNotEmpty ? FFAppState().modeOfTransport : 'Car';
    final vehicleNo = FFAppState().vehicleNumber;
    final driverContact = FFAppState().DriverNumber;
    final deliveryCost = FFAppState().totalDelvieryCost;
    final carryItems = FFAppState().carryItemNormalRides;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 48.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1F2937),
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Publish Ride',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step Progress Header
                      const PublishRideProgressHeader(
                        currentStep: 8,
                        totalSteps: 8,
                        title: 'Review & Publish',
                        subtitle: 'Verify all trip parameters before submitting for verification.',
                        badgeText: 'FINAL STEP',
                      ),

                      // Comprehensive Ride Recap Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFEAECEF)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0A000000),
                              blurRadius: 16.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header badge
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF6EE),
                                        borderRadius: BorderRadius.circular(20.0),
                                        border: Border.all(color: const Color(0xFFFFD9C2)),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.directions_car_rounded,
                                            size: 14.0,
                                            color: Color(0xFFEE7B4D),
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            mode.toUpperCase(),
                                            style: GoogleFonts.inter(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFFEE7B4D),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (vehicleNo.isNotEmpty) ...[
                                      const SizedBox(width: 8.0),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F4F6),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Text(
                                          vehicleNo,
                                          style: GoogleFonts.inter(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF374151),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                if (deliveryCost.isNotEmpty)
                                  Text(
                                    '₹$deliveryCost',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF10B981),
                                    ),
                                  ),
                              ],
                            ),

                            const Divider(height: 24.0, color: Color(0xFFF1F5F9)),

                            // Route Origin & Destination
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      width: 2.0,
                                      height: 36.0,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEE7B4D),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        start.isNotEmpty ? start : 'Origin not set',
                                        style: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF111827),
                                        ),
                                      ),
                                      if (startTime != null)
                                        Text(
                                          '${dateTimeFormat("yMMMd", startTime)} at ${dateTimeFormat("jm", startTime)}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11.5,
                                            color: const Color(0xFF6B7280),
                                          ),
                                        ),
                                      const SizedBox(height: 18.0),
                                      Text(
                                        end.isNotEmpty ? end : 'Destination not set',
                                        style: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF111827),
                                        ),
                                      ),
                                      if (endTime != null)
                                        Text(
                                          '${dateTimeFormat("yMMMd", endTime)} at ${dateTimeFormat("jm", endTime)}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11.5,
                                            color: const Color(0xFF6B7280),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            if (carryItems.isNotEmpty) ...[
                              const Divider(height: 24.0, color: Color(0xFFF1F5F9)),
                              Text(
                                'Carry Items & Stoppages',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                children: carryItems.map((it) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0ECFD),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      it,
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF6C4DF6),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],

                            if (driverContact.isNotEmpty) ...[
                              const Divider(height: 24.0, color: Color(0xFFF1F5F9)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone_rounded,
                                    size: 16.0,
                                    color: Color(0xFF6B7280),
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Driver Contact: $driverContact',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF374151),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Verification Notice Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF7F2),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFD6EFE1)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFD6EFE1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified_rounded,
                                color: Color(0xFF10B981),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Once submitted, your listing will undergo swift safety verification by Travia and go live immediately after approval.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF065F46),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Actions Container (StreamBuilder for Admin Approval Record)
              StreamBuilder<List<AdminApprovalOnRidesRecord>>(
                stream: queryAdminApprovalOnRidesRecord(singleRecord: true),
                builder: (context, snapshot) {
                  final adminRecords = snapshot.data ?? [];
                  final adminRecord = adminRecords.isNotEmpty ? adminRecords.first : null;

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFF1F5F9),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Primary Publish Button
                        InkWell(
                          onTap: _isPublishing ? null : () => _publishRide(adminRecord),
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            width: double.infinity,
                            height: 52.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEE7B4D),
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33EE7B4D),
                                  blurRadius: 12.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isPublishing) ...[
                                  const SizedBox(
                                    width: 18.0,
                                    height: 18.0,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Publishing Ride...',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    'Publish Ride',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(
                                    Icons.rocket_launch_rounded,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8.0),

                        // Discard and Cancel
                        TextButton(
                          onPressed: _discardAndExit,
                          child: Text(
                            'Discard & Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
