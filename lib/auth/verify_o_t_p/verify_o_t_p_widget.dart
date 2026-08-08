import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_o_t_p_model.dart';
export 'verify_o_t_p_model.dart';

/// create a page to show enter otp and verify your phone number
class VerifyOTPWidget extends StatefulWidget {
  const VerifyOTPWidget({super.key});

  static String routeName = 'VerifyOTP';
  static String routePath = '/verifyOTP';

  @override
  State<VerifyOTPWidget> createState() => _VerifyOTPWidgetState();
}

class _VerifyOTPWidgetState extends State<VerifyOTPWidget> {
  late VerifyOTPModel _model;
  bool _isVerifying = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifyOTPModel());

    _model.pinCodeFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _handleVerifyOTP() async {
    if (_isVerifying) return;
    final smsCodeVal = _model.pinCodeController!.text;
    if (smsCodeVal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter SMS verification code.'),
        ),
      );
      return;
    }
    setState(() {
      _isVerifying = true;
    });
    try {
      GoRouter.of(context).prepareAuthEvent();
      final phoneVerifiedUser = await authManager.verifySmsCode(
        context: context,
        smsCode: smsCodeVal,
      );
      if (phoneVerifiedUser == null) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
        }
        return;
      }

      context.goNamedAuth(
          SelectBidTypeWidget.routeName, context.mounted);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header / Travia Logo
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                  child: Image.asset(
                    'assets/images/logoTraviaJi.png',
                    height: 52.0,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        'Travia',
                        style: GoogleFonts.outfit(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2C3550),
                        ),
                      );
                    },
                  ),
                ).animate().fade(duration: 400.ms).slideY(begin: -0.1, end: 0),
                const SizedBox(height: 10.0),

                // Top Hero Section (Banner & Illustration)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Text & Description
                        Expanded(
                          flex: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Travel ',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Smarter.',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Connect ',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Better',
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFEE7B4D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                'Carry Items, Send Packages\nCarpool or Bikepool-or find\nwhat you need with trusted\ntravellers',
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF4B5563),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fade(delay: 100.ms, duration: 500.ms).slideX(begin: -0.05, end: 0),
                        const SizedBox(width: 8.0),
                        // Right Illustration with gentle floating loop animation
                        Expanded(
                          flex: 11,
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/images/otp_verification_illustration.png',
                              fit: BoxFit.contain,
                              height: 160.0,
                            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                             .moveY(begin: -6.0, end: 6.0, duration: 2400.ms, curve: Curves.easeInOut),
                          ),
                        ),
                      ],
                    ),
                    // Floating Badge with bounce-in animation
                    Positioned(
                      right: 10.0,
                      bottom: -16.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 7.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 12.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFF0E9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_rounded,
                                color: Color(0xFFEE7B4D),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              'Safe • Verified • Reliable',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fade(delay: 250.ms, duration: 500.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0), curve: Curves.easeOutBack),
                  ],
                ),

                const SizedBox(height: 45.0),

                // Card Container for OTP Form
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 16.0,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Verify Your Phone Number',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'We\'ve sent a 6-digit verification code to your phone number',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // PIN Code TextField
                      PinCodeTextField(
                        autoDisposeControllers: false,
                        appContext: context,
                        length: 6,
                        textStyle: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        enableActiveFill: true,
                        autoFocus: true,
                        focusNode: _model.pinCodeFocusNode,
                        enablePinAutofill: true,
                        errorTextSpace: 16.0,
                        showCursor: true,
                        cursorColor: const Color(0xFFEE7B4D),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          fieldHeight: 52.0,
                          fieldWidth: 44.0,
                          borderWidth: 1.5,
                          borderRadius: BorderRadius.circular(12.0),
                          shape: PinCodeFieldShape.box,
                          activeColor: const Color(0xFFEE7B4D),
                          inactiveColor: const Color(0xFFE5E7EB),
                          selectedColor: const Color(0xFFEE7B4D),
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: const Color(0xFFFFF0E9),
                        ),
                        controller: _model.pinCodeController,
                        onChanged: (_) {},
                        onCompleted: (_) async {
                          await _handleVerifyOTP();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _model.pinCodeControllerValidator
                            .asValidator(context),
                      ),
                      const SizedBox(height: 12.0),

                      // Resend Code Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive the code? ',
                            style: GoogleFonts.inter(
                              fontSize: 13.0,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Resend action
                            },
                            child: Text(
                              'Resend',
                              style: GoogleFonts.inter(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFEE7B4D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),

                      // Verify OTP Button with active Loader
                      SizedBox(
                        width: double.infinity,
                        height: 52.0,
                        child: ElevatedButton(
                          onPressed: _isVerifying ? null : _handleVerifyOTP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEE7B4D),
                            disabledBackgroundColor: const Color(0xB2EE7B4D),
                            foregroundColor: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: _isVerifying
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 22.0,
                                )
                              : Text(
                                  'Verify OTP',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Terms & Privacy Footer
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                            TextSpan(
                              text: 'Terms of service',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                color: const Color(0xFF6B7280),
                                decoration: TextDecoration.underline,
                              ),
                              mouseCursor: SystemMouseCursors.click,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  context.pushNamed(
                                    TCPagesWidget.routeName,
                                    queryParameters: {
                                      'categoryRef': serializeParam(
                                        'Terms Of Service',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                            ),
                            TextSpan(
                              text: ' & ',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy policy',
                              style: GoogleFonts.inter(
                                fontSize: 11.0,
                                color: const Color(0xFF6B7280),
                                decoration: TextDecoration.underline,
                              ),
                              mouseCursor: SystemMouseCursors.click,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  context.pushNamed(
                                    TCPagesWidget.routeName,
                                    queryParameters: {
                                      'categoryRef': serializeParam(
                                        'Privacy policy',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fade(delay: 300.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  // PREVIOUS BUILD IMPLEMENTATION (COMMENTED FOR REFERENCE)
  Widget _oldBuild(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).otherColour,
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.phone_android,
                                color: FlutterFlowTheme.of(context).alternate,
                                size: 40.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                            child: Text(
                              'Verify Your Phone Number',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                          // ...
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  */
}

