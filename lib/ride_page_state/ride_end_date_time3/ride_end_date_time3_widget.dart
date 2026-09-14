import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ride_end_date_time3_model.dart';
export 'ride_end_date_time3_model.dart';

class RideEndDateTime3Widget extends StatefulWidget {
  const RideEndDateTime3Widget({super.key});

  static String routeName = 'RideEndDateTime3';
  static String routePath = '/rideEndDateTime3';

  @override
  State<RideEndDateTime3Widget> createState() => _RideEndDateTime3WidgetState();
}

class _RideEndDateTime3WidgetState extends State<RideEndDateTime3Widget> {
  late RideEndDateTime3Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideEndDateTime3Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _pickEndDateTime() async {
    final initialDate = FFAppState().pickupTime ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _model.datePicked ?? initialDate,
      firstDate: initialDate,
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFEE7B4D),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final initialTime = _model.datePicked != null
          ? TimeOfDay.fromDateTime(_model.datePicked!)
          : (FFAppState().pickupTime != null
              ? TimeOfDay.fromDateTime(FFAppState().pickupTime!)
              : TimeOfDay.now());

      final pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFEE7B4D),
                onPrimary: Colors.white,
                onSurface: Color(0xFF111827),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        safeSetState(() {
          _model.datePicked = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _proceedNext() async {
    if (_model.datePicked == null) {
      await showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          title: Text(
            'Select Arrival Time',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
            ),
          ),
          content: Text(
            'Please select estimated arrival date and time to continue, or tap Skip.',
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: const Color(0xFF4B5563),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: Text(
                'Ok',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    if (FFAppState().pickupTime != null && _model.datePicked!.isBefore(FFAppState().pickupTime!)) {
      await showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                'Invalid Schedule',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
          content: Text(
            'Estimated arrival date/time cannot be before your departure time (${dateTimeFormat("yMMMd jm", FFAppState().pickupTime)}).',
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: const Color(0xFF4B5563),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: Text(
                'Correct Time',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    FFAppState().DropTime = _model.datePicked;
    safeSetState(() {});
    context.pushNamed(TransportMode4Widget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final startLocation = FFAppState().RideStartLocaction;
    final endLocation = FFAppState().RideEndLocaction;
    final startTime = FFAppState().pickupTime;

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
          actions: [
            TextButton(
              onPressed: () async {
                context.pushNamed(TransportMode4Widget.routeName);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
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
                        currentStep: 3,
                        totalSteps: 8,
                        title: 'Arrival Schedule',
                        subtitle: 'When are you expected to arrive at the destination?',
                        badgeText: 'STEP 3 OF 8',
                      ),

                      // Departure Summary Card
                      if (startTime != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14.0),
                          margin: const EdgeInsets.only(bottom: 18.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF7F2),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: const Color(0xFFD6EFE1),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36.0,
                                height: 36.0,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.flight_takeoff_rounded,
                                  color: Color(0xFF10B981),
                                  size: 18.0,
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'DEPARTURE CONFIRMED',
                                      style: GoogleFonts.inter(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF047857),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      '${dateTimeFormat("yMMMd", startTime)} at ${dateTimeFormat("jm", startTime)}',
                                      style: GoogleFonts.inter(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF064E3B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Interactive Arrival Date & Time Card
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _pickEndDateTime,
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: _model.datePicked != null
                                    ? const Color(0xFFFFD9C2)
                                    : const Color(0xFFEAECEF),
                                width: _model.datePicked != null ? 1.5 : 1.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0A000000),
                                  blurRadius: 16.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 64.0,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                    color: _model.datePicked != null
                                        ? const Color(0xFFFFF6EE)
                                        : const Color(0xFFF3F4F6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.flag_rounded,
                                    color: _model.datePicked != null
                                        ? const Color(0xFFEE7B4D)
                                        : const Color(0xFF9CA3AF),
                                    size: 32.0,
                                  ),
                                ).animate(target: _model.datePicked != null ? 1 : 0)
                                 .scale(begin: const Offset(0.95, 0.95), end: const Offset(1.05, 1.05), duration: 300.ms),

                                const SizedBox(height: 16.0),

                                if (_model.datePicked != null) ...[
                                  Text(
                                    dateTimeFormat("EEEE, dd MMMM yyyy", _model.datePicked),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6EE),
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: const Color(0xFFFFD9C2),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.access_time_filled_rounded,
                                          color: Color(0xFFEE7B4D),
                                          size: 14.0,
                                        ),
                                        const SizedBox(width: 6.0),
                                        Text(
                                          dateTimeFormat("jm", _model.datePicked),
                                          style: GoogleFonts.inter(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFEE7B4D),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  Text(
                                    'Tap to change arrival time',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    'Select Estimated Arrival Time',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  Text(
                                    'Tap here to pick estimated arrival date and time',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Route Destination Card
                      if (endLocation.isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.pin_drop_rounded,
                                color: Color(0xFFEE7B4D),
                                size: 20.0,
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  'Dropping at: $endLocation',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF374151),
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

              // Bottom Fixed Action Button Container
              Container(
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
                child: InkWell(
                  onTap: _proceedNext,
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
                        Text(
                          'Continue to Transport Mode',
                          style: GoogleFonts.inter(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
