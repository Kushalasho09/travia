import 'package:google_places_flutter/google_places_flutter.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'market_ride_model.dart';
export 'market_ride_model.dart';

class MarketRideWidget extends StatefulWidget {
  const MarketRideWidget({super.key});

  static String routeName = 'marketRide';
  static String routePath = '/marketRide';

  @override
  State<MarketRideWidget> createState() => _MarketRideWidgetState();
}

class _MarketRideWidgetState extends State<MarketRideWidget> {
  late MarketRideModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketRideModel());

    _model.originTextController = TextEditingController();
    _model.destinationTextController = TextEditingController();
    _model.originFocusNode = FocusNode();
    _model.destinationFocusNode = FocusNode();

    _model.nameoftheProductsTextController = TextEditingController();
    _model.nameoftheProductsFocusNode = FocusNode();

    // Pre-fill from app state if returning
    if (FFAppState().NameoftheProducts.isNotEmpty) {
      _model.nameoftheProductsTextController.text = FFAppState().NameoftheProducts;
    }
    if (FFAppState().origin.isNotEmpty) {
      _model.originTextController.text = FFAppState().origin;
    }
    if (FFAppState().destination.isNotEmpty) {
      _model.destinationTextController.text = FFAppState().destination;
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _validateAndProceed() {
    final productName = _model.nameoftheProductsTextController.text.trim();
    final origin = _model.originTextController.text.trim();
    final destination = _model.destinationTextController.text.trim();

    if (productName.isEmpty || origin.isEmpty || destination.isEmpty) {
      showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            'Missing Information',
            style: GoogleFonts.inter(fontSize: 17.0, fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Please fill in the product name, origin, and destination locations before proceeding.',
            style: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF475569)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(alertDialogContext),
              child: Text(
                'Got It',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
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

    FFAppState().NameoftheProducts = productName;
    FFAppState().origin = origin;
    FFAppState().destination = destination;
    safeSetState(() {});

    context.pushNamed(MarketRide2Widget.routeName);
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => context.safePop(),
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: 38.0,
                    height: 38.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFF1E293B),
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'List on Marketplace',
            style: GoogleFonts.inter(
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: InkWell(
                  onTap: () => context.pushNamed(DriveProfileWidget.routeName),
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                    ),
                    child: ClipOval(
                      child: currentUserPhoto.isNotEmpty
                          ? Image.network(
                              currentUserPhoto,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/userIconTr.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/userIconTr.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Stepper Header
              _buildStepperHeader(),

              // Scrollable Form Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'What are you listing?',
                        style: GoogleFonts.inter(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Enter your item details and the route you will travel.',
                        style: GoogleFonts.inter(
                          fontSize: 13.0,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Product Name Card
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 10.0,
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
                                  width: 32.0,
                                  height: 32.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFF5ED),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Color(0xFFEE7B4D),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Product or Item Name *',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
                              child: TextFormField(
                                controller: _model.nameoftheProductsTextController,
                                focusNode: _model.nameoftheProductsFocusNode,
                                style: GoogleFonts.inter(fontSize: 14.0, color: const Color(0xFF1E293B)),
                                decoration: InputDecoration(
                                  hintText: 'e.g. Fresh Strawberries, Bakery Items, Sweets',
                                  hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Route Selection Card
                      Container(
                        padding: const EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x06000000),
                              blurRadius: 10.0,
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
                                  width: 32.0,
                                  height: 32.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEFF6FF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.alt_route_rounded,
                                    color: Color(0xFF3B82F6),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Delivery Route *',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14.0),

                            // Origin Field
                            Text(
                              'Origin (Where item is sourced) *',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.trip_origin_rounded, color: Color(0xFF10D4A0), size: 18.0),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: GooglePlaceAutoCompleteTextField(
                                      focusNode: _model.originFocusNode,
                                      textEditingController: _model.originTextController,
                                      googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                      boxDecoration: const BoxDecoration(color: Colors.transparent),
                                      containerHorizontalPadding: 0,
                                      containerVerticalPadding: 0,
                                      inputDecoration: InputDecoration(
                                        hintText: 'Search pickup city or area...',
                                        hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                      ),
                                      textStyle: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF1E293B)),
                                      debounceTime: 500,
                                      isLatLngRequired: false,
                                      itemClick: (prediction) {
                                        _model.originTextController.text = prediction.description ?? "";
                                        _model.originTextController.selection = TextSelection.fromPosition(
                                          TextPosition(offset: prediction.description?.length ?? 0),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14.0),

                            // Destination Field
                            Text(
                              'Destination (Where you can deliver) *',
                              style: GoogleFonts.inter(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_rounded, color: Color(0xFFEE7B4D), size: 19.0),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: GooglePlaceAutoCompleteTextField(
                                      focusNode: _model.destinationFocusNode,
                                      textEditingController: _model.destinationTextController,
                                      googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                                      boxDecoration: const BoxDecoration(color: Colors.transparent),
                                      containerHorizontalPadding: 0,
                                      containerVerticalPadding: 0,
                                      inputDecoration: InputDecoration(
                                        hintText: 'Search delivery city or area...',
                                        hintStyle: GoogleFonts.inter(fontSize: 13.0, color: const Color(0xFF94A3B8)),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                                      ),
                                      textStyle: GoogleFonts.inter(fontSize: 13.5, color: const Color(0xFF1E293B)),
                                      debounceTime: 500,
                                      isLatLngRequired: false,
                                      itemClick: (prediction) {
                                        _model.destinationTextController.text = prediction.description ?? "";
                                        _model.destinationTextController.selection = TextSelection.fromPosition(
                                          TextPosition(offset: prediction.description?.length ?? 0),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Pro Tip Card
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFFFEDD5)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFFEA580C), size: 20.0),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Helpful Tip',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF9A3412),
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    'Choose general city centers or transit hubs for higher visibility and easier drop-offs.',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.0,
                                      color: const Color(0xFF9A3412),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Fixed Action Bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12.0,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEE7B4D), Color(0xFFF26835)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33EE7B4D),
                          blurRadius: 12.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _validateAndProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue to Details',
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
                            size: 19.0,
                          ),
                        ],
                      ),
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

  Widget _buildStepperHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step 1 of 3',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFEE7B4D),
                ),
              ),
              Text(
                'Product & Route',
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEE7B4D),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Container(
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
