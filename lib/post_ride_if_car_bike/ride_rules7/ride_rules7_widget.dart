import '/components/publish_ride_progress_header.dart';
import '/compotement/termsconditions11/termsconditions11_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ride_rules7_model.dart';
export 'ride_rules7_model.dart';

class RideRules7Widget extends StatefulWidget {
  const RideRules7Widget({super.key});

  static String routeName = 'rideRules7';
  static String routePath = '/rideRules7';

  @override
  State<RideRules7Widget> createState() => _RideRules7WidgetState();
}

class _RideRules7WidgetState extends State<RideRules7Widget> {
  late RideRules7Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _rules = const [
    'We accept only legal parcels. No prohibited, hazardous, or illegal items are allowed.',
    'Senders must arrive at the pickup point at least 10 minutes prior to departure.',
    'Verified receiver contact and drop address details are required upon booking.',
    'Parcels must be securely packed and protected against road vibrations.',
    'Fragile, perishable, or high-value items must be explicitly declared beforehand.',
    'Travia holds zero tolerance for unlawful goods, which will immediately be reported.',
    'Accurate schedule reporting ensures on-time coordination between all parties.',
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideRules7Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _proceedWithAcceptance() async {
    FFAppState().isRiderulesAccepted = true;
    FFAppState().isPredefinedItems = true;
    safeSetState(() {});

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      context: context,
      builder: (bottomSheetContext) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(bottomSheetContext).unfocus();
          },
          child: Padding(
            padding: MediaQuery.viewInsetsOf(bottomSheetContext),
            child: SizedBox(
              height: MediaQuery.sizeOf(bottomSheetContext).height * 0.75,
              child: const Termsconditions11Widget(),
            ),
          ),
        );
      },
    );

    if (mounted) {
      context.pushNamed(Areyousure12Widget.routeName);
    }
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
          actions: [
            TextButton(
              onPressed: () {
                context.pushNamed(RuleRide8BWidget.routeName);
              },
              child: Text(
                'Custom Rules',
                style: GoogleFonts.inter(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6C4DF6),
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
                        currentStep: 7,
                        totalSteps: 8,
                        title: 'Ride & Parcel Rules',
                        subtitle: 'Review and accept standard safety terms and community guidelines.',
                        badgeText: 'STEP 7 OF 8',
                      ),

                      // Rules Container Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18.0),
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
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF7F2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Icon(
                                    Icons.gavel_rounded,
                                    color: Color(0xFF10B981),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Standard Safety Guidelines',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            // List of rules with clean checkmark bullets
                            ..._rules.asMap().entries.map((entry) {
                              final index = entry.key;
                              final rule = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 2.0),
                                      width: 18.0,
                                      height: 18.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFEEF7F2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check_rounded,
                                        color: Color(0xFF10B981),
                                        size: 12.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        rule,
                                        style: GoogleFonts.inter(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF374151),
                                          height: 1.38,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // Terms agreement summary
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0ECFD),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE2DBFC)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified_user_rounded,
                              color: Color(0xFF6C4DF6),
                              size: 20.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'By continuing, you agree to Travia Terms of Service and Carriage Safety Standards.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF4C28D4),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
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
                  onTap: _proceedWithAcceptance,
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
                          'Accept & Review Ride',
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
