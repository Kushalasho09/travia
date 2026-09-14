import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'pansanger5_b_model.dart';
export 'pansanger5_b_model.dart';

class Pansanger5BWidget extends StatefulWidget {
  const Pansanger5BWidget({super.key});

  static String routeName = 'pansanger5B';
  static String routePath = '/pansanger5B';

  @override
  State<Pansanger5BWidget> createState() => _Pansanger5BWidgetState();
}

class _Pansanger5BWidgetState extends State<Pansanger5BWidget> {
  late Pansanger5BModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Pansanger5BModel());
    _model.isPassangersAllowedValue ??= 'Yes';
    _model.isPassangerAllowed = 'Yes';

    _model.numOfpassTextController ??= TextEditingController(
      text: FFAppState().numPassengers > 0 ? FFAppState().numPassengers.toString() : '2',
    );
    _model.numOfpassFocusNode ??= FocusNode();

    _model.priceTextController ??= TextEditingController(
      text: FFAppState().pricePerPassengers > 0 ? FFAppState().pricePerPassengers.toString() : '',
    );
    _model.priceFocusNode ??= FocusNode();

    _model.priceMask = MaskTextInputFormatter(mask: '#####');
    _model.bagsTextController ??= TextEditingController(
      text: FFAppState().numBagAllowed > 0 ? FFAppState().numBagAllowed.toString() : '1',
    );
    _model.bagsFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _proceedNext() async {
    final seatsText = _model.numOfpassTextController.text.trim();
    final priceText = _model.priceTextController.text.trim();
    final bagsText = _model.bagsTextController.text.trim();

    if (_model.isPassangerAllowed == 'Yes') {
      if (seatsText.isEmpty || priceText.isEmpty) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            title: Text(
              'Missing Details',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 16.5,
              ),
            ),
            content: Text(
              'Please enter the number of seats and price per passenger.',
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

      FFAppState().isPassengers = 'Yes';
      FFAppState().numPassengers = int.tryParse(seatsText) ?? 1;
      FFAppState().pricePerPassengers = int.tryParse(priceText) ?? 0;
      FFAppState().numBagAllowed = int.tryParse(bagsText) ?? 1;
    } else {
      FFAppState().isPassengers = 'No';
      FFAppState().numPassengers = 0;
      FFAppState().pricePerPassengers = 0;
      FFAppState().numBagAllowed = 0;
    }

    safeSetState(() {});
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
                        title: 'Carpool Capacity & Fare',
                        subtitle: 'Set available seats, fare per passenger, and luggage allowances.',
                        badgeText: 'STEP 6 OF 8',
                      ),

                      // 1. Available Seats Card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0ECFD),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.airline_seat_recline_normal_rounded,
                                    color: Color(0xFF6C4DF6),
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available Seats',
                                      style: GoogleFonts.inter(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    Text(
                                      'Passenger capacity',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_rounded, size: 18.0),
                                    onPressed: () {
                                      int current = int.tryParse(_model.numOfpassTextController.text) ?? 1;
                                      if (current > 1) {
                                        _model.numOfpassTextController.text = (current - 1).toString();
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 32.0,
                                    child: Text(
                                      _model.numOfpassTextController.text.isNotEmpty
                                          ? _model.numOfpassTextController.text
                                          : '1',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_rounded, size: 18.0),
                                    onPressed: () {
                                      int current = int.tryParse(_model.numOfpassTextController.text) ?? 1;
                                      if (current < 8) {
                                        _model.numOfpassTextController.text = (current + 1).toString();
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 2. Price Per Passenger Card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16.0),
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
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF6EE),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.payments_rounded,
                                    color: Color(0xFFEE7B4D),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Price Per Passenger',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14.0),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  Text(
                                    '₹',
                                    style: GoogleFonts.inter(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFEE7B4D),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _model.priceTextController,
                                      focusNode: _model.priceFocusNode,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [_model.priceMask],
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter amount (e.g. 350)',
                                        hintStyle: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          color: const Color(0xFF9CA3AF),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Luggage Bags Allowed Card
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEEF7F2),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.luggage_rounded,
                                    color: Color(0xFF10B981),
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bags Allowed',
                                      style: GoogleFonts.inter(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                    Text(
                                      'Per passenger limit',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.5,
                                        color: const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_rounded, size: 18.0),
                                    onPressed: () {
                                      int current = int.tryParse(_model.bagsTextController.text) ?? 0;
                                      if (current > 0) {
                                        _model.bagsTextController.text = (current - 1).toString();
                                        safeSetState(() {});
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: 32.0,
                                    child: Text(
                                      _model.bagsTextController.text.isNotEmpty
                                          ? _model.bagsTextController.text
                                          : '0',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_rounded, size: 18.0),
                                    onPressed: () {
                                      int current = int.tryParse(_model.bagsTextController.text) ?? 0;
                                      if (current < 4) {
                                        _model.bagsTextController.text = (current + 1).toString();
                                        safeSetState(() {});
                                      }
                                    },
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
