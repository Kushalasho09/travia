import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cary_items5_model.dart';
export 'cary_items5_model.dart';

class CaryItems5Widget extends StatefulWidget {
  const CaryItems5Widget({super.key});

  static String routeName = 'caryItems5';
  static String routePath = '/caryItems5';

  @override
  State<CaryItems5Widget> createState() => _CaryItems5WidgetState();
}

class _CaryItems5WidgetState extends State<CaryItems5Widget> {
  late CaryItems5Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _suggestedItems = const [
    'Laptop Bag',
    'Travel Luggage',
    'Documents',
    'Electronics',
    'Snacks / Food',
    'Small Package',
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CaryItems5Model());
    _model.itemsTextController ??= TextEditingController();
    _model.itemsFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _addItem(String text) {
    final trimmed = text.trim();
    if (trimmed.isNotEmpty && !_model.items11.contains(trimmed)) {
      _model.addToItems11(trimmed);
      _model.itemsTextController?.clear();
      safeSetState(() {});
    }
  }

  void _removeItem(String item) {
    _model.removeFromItems11(item);
    safeSetState(() {});
  }

  void _proceedNext() {
    if (_model.items11.isNotEmpty) {
      FFAppState().carryItemNormalRides = _model.items11.toList().cast<String>();
      safeSetState(() {});
    }

    final transportModeValue = FFAppState().modeOfTransport;
    if (transportModeValue == 'Car' || transportModeValue == 'Bike') {
      context.pushNamed(FirstWidget.routeName);
    } else {
      context.pushNamed(ParcelCost6Widget.routeName);
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
                        title: 'Stoppages & Luggage',
                        subtitle: 'Specify stoppage points or items you can carry on this ride.',
                        badgeText: 'STEP 5 OF 8',
                      ),

                      // Input Card
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
                            Text(
                              'Add Stoppage / Item Name',
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF9FAFB),
                                      borderRadius: BorderRadius.circular(14.0),
                                      border: Border.all(color: const Color(0xFFE5E7EB)),
                                    ),
                                    child: TextField(
                                      controller: _model.itemsTextController,
                                      focusNode: _model.itemsFocusNode,
                                      onSubmitted: (val) => _addItem(val),
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        color: const Color(0xFF111827),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. Noida Sector 62, Medium Suitcase...',
                                        hintStyle: GoogleFonts.inter(
                                          color: const Color(0xFF9CA3AF),
                                          fontSize: 13.0,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 14.0,
                                          vertical: 12.0,
                                        ),
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                InkWell(
                                  onTap: () => _addItem(_model.itemsTextController?.text ?? ''),
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: Container(
                                    height: 46.0,
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEE7B4D),
                                      borderRadius: BorderRadius.circular(14.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x28EE7B4D),
                                          blurRadius: 8.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.add_rounded,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          'Add',
                                          style: GoogleFonts.inter(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18.0),

                            // Suggestions Quick Chips
                            Text(
                              'Popular Suggestions',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: _suggestedItems.map((suggestion) {
                                final isAdded = _model.items11.contains(suggestion);
                                return InkWell(
                                  onTap: () {
                                    if (isAdded) {
                                      _removeItem(suggestion);
                                    } else {
                                      _addItem(suggestion);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: isAdded ? const Color(0xFFFFF6EE) : const Color(0xFFF3F4F6),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: isAdded ? const Color(0xFFEE7B4D) : Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isAdded ? Icons.check_rounded : Icons.add_rounded,
                                          color: isAdded ? const Color(0xFFEE7B4D) : const Color(0xFF6B7280),
                                          size: 14.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          suggestion,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.0,
                                            fontWeight: isAdded ? FontWeight.w700 : FontWeight.w500,
                                            color: isAdded ? const Color(0xFFEE7B4D) : const Color(0xFF374151),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Added Items Display Card
                      if (_model.items11.isNotEmpty)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: const Color(0xFFEAECEF)),
                          ),
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.inventory_2_outlined,
                                    color: Color(0xFF10B981),
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Added Items (${_model.items11.length})',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: _model.items11.map((item) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0ECFD),
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(color: const Color(0xFFE2DBFC)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF6C4DF6),
                                          ),
                                        ),
                                        const SizedBox(width: 6.0),
                                        InkWell(
                                          onTap: () => _removeItem(item),
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Color(0xFF6C4DF6),
                                            size: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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
                          'Continue',
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
