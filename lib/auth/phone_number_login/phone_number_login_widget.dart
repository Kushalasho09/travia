import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Country _selectedCountry = CountryParser.parseCountryCode('IN');

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhoneNumberLoginModel());

    _model.phoneNumberTextController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
    _model.phoneNumberFocusNode?.addListener(_onFocusChange);

    authManager.phoneAuthManager.addListener(_onPhoneAuthStateChanged);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  void _onPhoneAuthStateChanged() {
    if (authManager.phoneAuthManager.phoneAuthError != null && mounted) {
      final err = authManager.phoneAuthManager.phoneAuthError.toString();
      authManager.phoneAuthManager.update(() => authManager.phoneAuthManager.phoneAuthError = null);
      setState(() {
        _isLoading = false;
      });
      _showErrorWithRetry(err);
    }
  }

  void _openCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: <String>['IN', 'US', 'GB', 'AE', 'CA', 'AU', 'SA', 'SG'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.75,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        backgroundColor: Colors.white,
        inputDecoration: InputDecoration(
          labelText: 'Search country or code',
          hintText: 'Type country name or code...',
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFEE7B4D)),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: const BorderSide(color: Color(0xFFEE7B4D), width: 1.5),
          ),
        ),
        searchTextStyle: GoogleFonts.inter(
          fontSize: 15.0,
          color: const Color(0xFF111827),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 15.0,
          color: const Color(0xFF111827),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  Future<void> _handleSendOtp() async {
    final rawPhone = _model.phoneNumberTextController?.text.trim() ?? '';
    if (rawPhone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your phone number.'),
        ),
      );
      return;
    }

    // Clean digits
    String digits = rawPhone.replaceAll(RegExp(r'\D'), '');
    // Strip leading zeros if entered (e.g. 09876543210 -> 9876543210)
    digits = digits.replaceFirst(RegExp(r'^0+'), '');

    if (digits.length < 6 || digits.length > 15) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number.'),
        ),
      );
      return;
    }

    // Construct standard E.164 phone number
    String formattedPhone;
    if (rawPhone.startsWith('+')) {
      formattedPhone = '+$digits';
    } else if (_selectedCountry.phoneCode == '91' &&
        digits.startsWith('91') &&
        digits.length == 12) {
      formattedPhone = '+$digits';
    } else {
      formattedPhone = '+${_selectedCountry.phoneCode}$digits';
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final success = await authManager.beginPhoneAuth(
        context: context,
        phoneNumber: formattedPhone,
        onCodeSent: (context) async {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          // Push to VerifyOTPWidget so user can edit phone number or press Back without app closing
          context.pushNamed(VerifyOTPWidget.routeName);
        },
      );

      if (success == false && mounted) {
        setState(() {
          _isLoading = false;
        });
        final rawError = authManager.phoneAuthManager.phoneAuthError?.toString() ?? '';
        _showErrorWithRetry(rawError);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorWithRetry(e.toString());
      }
    }
  }

  void _showErrorWithRetry(String error) {
    if (!mounted) return;
    String displayMsg = 'Temporary server error while sending verification code.';
    if (error.contains('Network') || error.contains('connection') || error.contains('timeout')) {
      displayMsg = 'Connection issue while sending code. Please check your internet.';
    } else if (error.isNotEmpty && !error.contains('Exception') && !error.contains('Instance of')) {
      displayMsg = error;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        duration: const Duration(seconds: 8),
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                displayMsg,
                style: GoogleFonts.inter(fontSize: 13.0, color: Colors.white),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Retry Again',
          textColor: const Color(0xFFFDE047),
          onPressed: _handleSendOtp,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _model.phoneNumberFocusNode?.removeListener(_onFocusChange);
    authManager.phoneAuthManager.removeListener(_onPhoneAuthStateChanged);
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

                      // Phone Input Field Label
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

                      // Global Phone Input with Country Code Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: (_model.phoneNumberFocusNode?.hasFocus ?? false)
                                ? const Color(0xFFEE7B4D)
                                : const Color(0xFFD1D5DB),
                            width: (_model.phoneNumberFocusNode?.hasFocus ?? false)
                                ? 1.5
                                : 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x05000000),
                              blurRadius: 4.0,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Country Code Dropdown Trigger
                            InkWell(
                              onTap: _openCountryPicker,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 14.0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _selectedCountry.flagEmoji,
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      '+${_selectedCountry.phoneCode}',
                                      style: GoogleFonts.inter(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(width: 4.0),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF6B7280),
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Divider
                            Container(
                              height: 28.0,
                              width: 1.0,
                              color: const Color(0xFFE5E7EB),
                            ),

                            // Number Input Field
                            Expanded(
                              child: TextFormField(
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(15),
                                ],
                                style: GoogleFonts.inter(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF111827),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter phone number',
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                  filled: false,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14.0,
                                    vertical: 16.0,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Send OTP Button with active Loader
                      SizedBox(
                        width: double.infinity,
                        height: 52.0,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSendOtp,
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


