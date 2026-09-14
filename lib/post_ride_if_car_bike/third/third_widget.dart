import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'third_model.dart';
export 'third_model.dart';

class ThirdWidget extends StatefulWidget {
  const ThirdWidget({super.key});

  static String routeName = 'third';
  static String routePath = '/third';

  @override
  State<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  late ThirdModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _suggestedAmounts = const ['150', '250', '500', '750', '1000'];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ThirdModel());
    _model.parcelDeliveryTextController ??= TextEditingController(
      text: FFAppState().totalDelvieryCost.isNotEmpty ? FFAppState().totalDelvieryCost : '',
    );
    _model.parcelDeliveryFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _proceedNext() {
    final cost = _model.parcelDeliveryTextController.text.trim();
    if (cost.isNotEmpty) {
      FFAppState().totalDelvieryCost = cost;
      safeSetState(() {});
    }
    context.pushNamed(WhatyouCarry5Widget.routeName);
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
              onPressed: _proceedNext,
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
                        currentStep: 6,
                        totalSteps: 8,
                        title: 'Parcel Delivery Charges',
                        subtitle: 'Set an estimated price for carrying packages on this trip.',
                        badgeText: 'STEP 6 OF 8',
                      ),

                      // Pricing Card
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
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF6EE),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.payments_rounded,
                                    color: Color(0xFFEE7B4D),
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Delivery Charge (INR)',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18.0),

                            // Amount Input Field
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                              child: Row(
                                children: [
                                  Text(
                                    '₹',
                                    style: GoogleFonts.inter(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFFEE7B4D),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _model.parcelDeliveryTextController,
                                      focusNode: _model.parcelDeliveryFocusNode,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.inter(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter amount',
                                        hintStyle: GoogleFonts.inter(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF9CA3AF),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (_) => safeSetState(() {}),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 18.0),

                            // Suggested Quick Price Pills
                            Text(
                              'Suggested Rates',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              children: _suggestedAmounts.map((amt) {
                                final isSelected = _model.parcelDeliveryTextController.text == amt;
                                return InkWell(
                                  onTap: () {
                                    _model.parcelDeliveryTextController.text = amt;
                                    safeSetState(() {});
                                  },
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFFEE7B4D) : const Color(0xFFF3F4F6),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      '₹$amt',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected ? Colors.white : const Color(0xFF374151),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Guidelines Box
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
                                Icons.info_outline_rounded,
                                color: Color(0xFF10B981),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Recommended base rate is approximately ₹1 - ₹2 per km. Final delivery terms and handling can be coordinated with the parcel sender.',
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
                          'Continue to Carry Preferences',
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
