import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'phone_number_login_model.dart';
export 'phone_number_login_model.dart';

class PhoneNumberLoginWidget extends StatefulWidget {
  const PhoneNumberLoginWidget({super.key});

  static String routeName = 'phoneNumberLogin';
  static String routePath = '/phoneNumberLogin';

  @override
  State<PhoneNumberLoginWidget> createState() => _PhoneNumberLoginWidgetState();
}

class _PhoneNumberLoginWidgetState extends State<PhoneNumberLoginWidget> {
  late PhoneNumberLoginModel _model;
  bool _isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhoneNumberLoginModel());

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.phoneNumberMask = MaskTextInputFormatter(mask: '+91##########');
    authManager.handlePhoneAuthStateChanges(context);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
                              'assets/images/login_phone_illustration.png',
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

                // Card Container for Phone Login Form
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
                        'Login or Sign Up',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Enter your phone number to receive a 6-digit verification code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      // Phone Input Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Phone Number',
                          style: GoogleFonts.inter(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      TextFormField(
                        controller: _model.phoneNumberTextController,
                        focusNode: _model.phoneNumberFocusNode,
                        onFieldSubmitted: (_) async {
                          _model.phoneNumber = int.tryParse(
                              _model.phoneNumberTextController.text);
                          safeSetState(() {});
                        },
                        autofocus: true,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        cursorColor: const Color(0xFFEE7B4D),
                        inputFormatters: [_model.phoneNumberMask],
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number (+91...)',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14.0,
                            color: const Color(0xFF9CA3AF),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 16.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFD1D5DB),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFEE7B4D),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: _model.phoneNumberTextControllerValidator
                            .asValidator(context),
                      ),

                      const SizedBox(height: 24.0),

                      // Send OTP Button with active Loader
                      SizedBox(
                        width: double.infinity,
                        height: 52.0,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  final phoneNumberVal =
                                      _model.phoneNumberTextController.text;
                                  if (phoneNumberVal.isEmpty ||
                                      !phoneNumberVal.startsWith('+')) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Phone Number is required and has to start with +.'),
                                      ),
                                    );
                                    return;
                                  }
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    await authManager.beginPhoneAuth(
                                      context: context,
                                      phoneNumber: phoneNumberVal,
                                      onCodeSent: (context) async {
                                        if (mounted) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                        context.goNamedAuth(
                                          VerifyOTPWidget.routeName,
                                          context.mounted,
                                          ignoreRedirect: true,
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEE7B4D),
                            disabledBackgroundColor: const Color(0xB2EE7B4D),
                            foregroundColor: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: _isLoading
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 22.0,
                                )
                              : Text(
                                  'Send OTP',
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
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  children: [
                    Text('Login or Sign Up'),
                    // ...
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  */
}


