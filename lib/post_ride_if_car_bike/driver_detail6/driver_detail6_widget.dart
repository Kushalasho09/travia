import '/auth/firebase_auth/auth_util.dart';
import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'driver_detail6_model.dart';
export 'driver_detail6_model.dart';

class DriverDetail6Widget extends StatefulWidget {
  const DriverDetail6Widget({super.key});

  static String routeName = 'driverDetail6';
  static String routePath = '/driverDetail6';

  @override
  State<DriverDetail6Widget> createState() => _DriverDetail6WidgetState();
}

class _DriverDetail6WidgetState extends State<DriverDetail6Widget> {
  late DriverDetail6Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverDetail6Model());

    _model.driverContactnumberTextController ??= TextEditingController(
      text: currentPhoneNumber.isNotEmpty ? currentPhoneNumber : '',
    );
    _model.driverContactnumberFocusNode ??= FocusNode();

    _model.driverContactnumberMask = MaskTextInputFormatter(mask: '+91 ##### #####');
    _model.vehicleNumberTextController ??= TextEditingController(
      text: FFAppState().vehicleNumber.isNotEmpty ? FFAppState().vehicleNumber : '',
    );
    _model.vehicleNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _proceedNext() async {
    final contact = _model.driverContactnumberTextController.text.trim();

    if (contact.isEmpty) {
      await showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          title: Text(
            'Contact Required',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
            ),
          ),
          content: Text(
            'Please enter your contact number so passengers can reach you upon ride confirmation.',
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

    FFAppState().DriverNumber = contact;
    FFAppState().vehicleNumber = _model.vehicleNumberTextController.text.trim();
    safeSetState(() {});

    context.pushNamed(Stoppage7Widget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
                        currentStep: 6,
                        totalSteps: 8,
                        title: 'Driver & Vehicle Details',
                        subtitle: 'Confirm your phone number and vehicle details.',
                        badgeText: 'STEP 6 OF 8',
                      ),

                      // Driver Form Container Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Contact field
                            Text(
                              'Driver Contact Number',
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9FAFB),
                                  borderRadius: BorderRadius.circular(14.0),
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                ),
                                child: TextField(
                                  controller: _model.driverContactnumberTextController,
                                  focusNode: _model.driverContactnumberFocusNode,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [_model.driverContactnumberMask],
                                  style: GoogleFonts.inter(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF111827),
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.phone_rounded,
                                      color: Color(0xFFEE7B4D),
                                      size: 20.0,
                                    ),
                                    hintText: '+91 98765 43210',
                                    hintStyle: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: 14.0,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14.0,
                                      vertical: 14.0,
                                    ),
                                  ),
                                  onChanged: (_) => safeSetState(() {}),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20.0),

                            // Vehicle Plate field
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Vehicle Name or Detail',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                                Text(
                                  'Optional',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: TextField(
                                controller: _model.vehicleNumberTextController,
                                focusNode: _model.vehicleNumberFocusNode,
                                textCapitalization: TextCapitalization.words,
                                style: GoogleFonts.inter(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.0,
                                  color: const Color(0xFF111827),
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.directions_car_rounded,
                                    color: Color(0xFF6B7280),
                                    size: 20.0,
                                  ),
                                  hintText: 'E.g. Hyundai Aura 2023',
                                  hintStyle: GoogleFonts.inter(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14.0,
                                    vertical: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Privacy Notice Card
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
                                Icons.lock_outline_rounded,
                                color: Color(0xFF10B981),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Your phone number and vehicle details are protected and only shared with verified travellers upon confirmed ride bookings.',
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
                          'Continue to Ride Rules',
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
