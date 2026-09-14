import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'whatyou_carry5_model.dart';
export 'whatyou_carry5_model.dart';

class WhatyouCarry5Widget extends StatefulWidget {
  const WhatyouCarry5Widget({super.key});

  static String routeName = 'whatyouCarry5';
  static String routePath = '/whatyouCarry5';

  @override
  State<WhatyouCarry5Widget> createState() => _WhatyouCarry5WidgetState();
}

class _WhatyouCarry5WidgetState extends State<WhatyouCarry5Widget> {
  late WhatyouCarry5Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WhatyouCarry5Model());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _proceedNext() {
    if (_model.choiceChipsValues != null && _model.choiceChipsValues!.isNotEmpty) {
      FFAppState().carryItemNormalRides =
          _model.choiceChipsValues!.toList().cast<String>();
      safeSetState(() {});
    }

    context.pushNamed(DriverDetail6Widget.routeName);
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
                        currentStep: 5,
                        totalSteps: 8,
                        title: 'What Can You Carry?',
                        subtitle: 'Select package categories and items you are comfortable transporting.',
                        badgeText: 'STEP 5 OF 8',
                      ),

                      // Category Chips Container Card
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
                                    color: const Color(0xFFF0ECFD),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Icon(
                                    Icons.category_rounded,
                                    color: Color(0xFF6C4DF6),
                                    size: 16.0,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  'Select Allowed Categories',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            FlutterFlowChoiceChips(
                              options: const [
                                ChipData('Food Items', Icons.restaurant_rounded),
                                ChipData('Sweets & Snacks', Icons.cake_rounded),
                                ChipData('Spices & Groceries', Icons.local_dining_rounded),
                                ChipData('Crockery & Fragile', Icons.wine_bar_rounded),
                                ChipData('Small Appliances', Icons.devices_other_rounded),
                                ChipData('Kitchen Items', Icons.kitchen_rounded),
                                ChipData('Festival Goodies', Icons.card_giftcard_rounded),
                                ChipData('Clothing & Apparel', Icons.checkroom_rounded),
                                ChipData('Tech & Gadgets', Icons.phone_iphone_rounded),
                                ChipData('Documents', Icons.description_rounded),
                                ChipData('Books & Study Material', Icons.menu_book_rounded),
                                ChipData('Discuss on Call', Icons.phone_in_talk_rounded),
                                ChipData('Other Packages', Icons.inventory_2_rounded),
                              ],
                              onChanged: (val) =>
                                  safeSetState(() => _model.choiceChipsValues = val),
                              selectedChipStyle: ChipStyle(
                                backgroundColor: const Color(0xFFEE7B4D),
                                textStyle: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                iconColor: Colors.white,
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(20.0),
                                borderColor: const Color(0xFFEE7B4D),
                                borderWidth: 1.0,
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor: const Color(0xFFF9FAFB),
                                textStyle: GoogleFonts.inter(
                                  color: const Color(0xFF374151),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                iconColor: const Color(0xFF6B7280),
                                iconSize: 16.0,
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(20.0),
                                borderColor: const Color(0xFFE5E7EB),
                                borderWidth: 1.0,
                              ),
                              chipSpacing: 8.0,
                              rowSpacing: 10.0,
                              multiselect: true,
                              initialized: _model.choiceChipsValues != null,
                              alignment: WrapAlignment.start,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                FFAppState().carryItemNormalRides,
                              ),
                              wrapped: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18.0),

                      // Safety Notice Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFFFEDD5)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFEDD5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.shield_outlined,
                                color: Color(0xFFEA580C),
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                'Prohibited and hazardous items are strictly prohibited under Travia Community Safety Guidelines.',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9A3412),
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
                          'Continue to Driver Details',
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
