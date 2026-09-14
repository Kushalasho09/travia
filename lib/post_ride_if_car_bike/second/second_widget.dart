import '/components/publish_ride_progress_header.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'second_model.dart';
export 'second_model.dart';

class SecondWidget extends StatefulWidget {
  const SecondWidget({super.key});

  static String routeName = 'second';
  static String routePath = '/second';

  @override
  State<SecondWidget> createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> {
  late SecondModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondModel());

    _model.numOfpassTextController ??= TextEditingController(
      text: FFAppState().numPassengers > 0 ? FFAppState().numPassengers.toString() : '1',
    );
    _model.numOfpassFocusNode ??= FocusNode();

    _model.parcelDeliveryTextController ??= TextEditingController(
      text: FFAppState().totalDelvieryCost.isNotEmpty ? FFAppState().totalDelvieryCost : '',
    );
    _model.parcelDeliveryFocusNode ??= FocusNode();

    _model.passangerCostTextController ??= TextEditingController(
      text: FFAppState().pricePerPassengers > 0 ? FFAppState().pricePerPassengers.toString() : '',
    );
    _model.passangerCostFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _showExceedDialog({
    required BuildContext context,
    required String title,
    required String message,
    required double maxParcel,
    required double maxRide,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52.0,
                  height: 52.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF6EE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFEE7B4D),
                    size: 28.0,
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13.0,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Max Parcel Rate', style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFF6B7280))),
                          const SizedBox(height: 2.0),
                          Text('₹${maxParcel.toInt()}', style: GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w700, color: const Color(0xFFEE7B4D))),
                        ],
                      ),
                      Container(width: 1.0, height: 28.0, color: const Color(0xFFE5E7EB)),
                      Column(
                        children: [
                          Text('Max Passenger Fare', style: GoogleFonts.inter(fontSize: 11.5, color: const Color(0xFF6B7280))),
                          const SizedBox(height: 2.0),
                          Text('₹${maxRide.toInt()}', style: GoogleFonts.inter(fontSize: 16.0, fontWeight: FontWeight.w700, color: const Color(0xFFEE7B4D))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    setState(() {
                      _model.parcelDeliveryTextController.text = maxParcel.toInt().toString();
                      _model.passangerCostTextController.text = maxRide.toInt().toString();
                    });
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(14.0),
                  child: Container(
                    width: double.infinity,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE7B4D),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Center(
                      child: Text(
                        'Auto-Fill Maximum Limits',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showInfoDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16.5,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            color: const Color(0xFF4B5563),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
  }

  void _proceedNext() async {
    final passengerCountText = _model.numOfpassTextController.text.trim();
    final parcelText = _model.parcelDeliveryTextController.text.trim();
    final passengerText = _model.passangerCostTextController.text.trim();

    if (parcelText.isEmpty || passengerText.isEmpty || passengerCountText.isEmpty) {
      await _showInfoDialog(
        context,
        title: 'Missing Details',
        message: 'Please fill in seat count, passenger fare, and parcel delivery charges.',
      );
      return;
    }

    final passengerCount = double.tryParse(passengerCountText);
    final parcelAmount = double.tryParse(parcelText);
    final rideAmount = double.tryParse(passengerText);

    if (parcelAmount == null || rideAmount == null || passengerCount == null) {
      await _showInfoDialog(
        context,
        title: 'Invalid Input',
        message: 'Please enter valid numeric amounts.',
      );
      return;
    }

    final travelTime = FFAppState().travelTime;
    final kmMatch = RegExp(r'\((\d+)\s*km\)').firstMatch(travelTime);

    double totalKm = 100.0;
    if (kmMatch != null) {
      totalKm = double.parse(kmMatch.group(1)!);
    }

    final maxParcel = totalKm * 1.5;
    final maxRide = totalKm * 2.5;

    if (parcelAmount > maxParcel && rideAmount > maxRide) {
      await _showExceedDialog(
        context: context,
        title: 'Amounts Exceeded',
        message: 'Both parcel and ride charges exceed standard community limits for this distance ($totalKm km).',
        maxParcel: maxParcel,
        maxRide: maxRide,
      );
      return;
    }

    if (parcelAmount > maxParcel) {
      await _showExceedDialog(
        context: context,
        title: 'Parcel Limit Exceeded',
        message: 'Your parcel charge exceeds the recommended limit of ₹${maxParcel.toInt()} for $totalKm km.',
        maxParcel: maxParcel,
        maxRide: maxRide,
      );
      return;
    }

    if (rideAmount > maxRide) {
      await _showExceedDialog(
        context: context,
        title: 'Ride Fare Exceeded',
        message: 'Your passenger fare exceeds the recommended limit of ₹${maxRide.toInt()} for $totalKm km.',
        maxParcel: maxParcel,
        maxRide: maxRide,
      );
      return;
    }

    FFAppState().totalDelvieryCost = parcelText;
    FFAppState().pricePerPassengers = rideAmount.toInt();
    FFAppState().numPassengers = passengerCount.toInt();
    safeSetState(() {});

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
                        title: 'Pricing & Seat Capacity',
                        subtitle: 'Set available seats, fare per passenger, and parcel charges.',
                        badgeText: 'STEP 6 OF 8',
                      ),

                      // 1. Passenger Seats Card
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
                                        size: 18.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      'Available Seats',
                                      style: GoogleFonts.inter(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
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
                                        width: 36.0,
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
                          ],
                        ),
                      ),

                      // 2. Passenger Fare Card
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
                                    Icons.person_outline_rounded,
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
                                      controller: _model.passangerCostTextController,
                                      focusNode: _model.passangerCostFocusNode,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 350',
                                        hintStyle: GoogleFonts.inter(
                                          fontSize: 15.0,
                                          color: const Color(0xFF9CA3AF),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Standard rate ~₹2.5/km based on route distance.',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Parcel Delivery Cost Card
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
                                    color: const Color(0xFFEEF7F2),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.inventory_2_outlined,
                                    color: Color(0xFF10B981),
                                    size: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Parcel Carrying Charge',
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
                                      color: const Color(0xFF10B981),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _model.parcelDeliveryTextController,
                                      focusNode: _model.parcelDeliveryFocusNode,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF111827),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e.g. 200',
                                        hintStyle: GoogleFonts.inter(
                                          fontSize: 15.0,
                                          color: const Color(0xFF9CA3AF),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Standard rate ~₹1.5/km based on parcel size & delicacy.',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
                                color: const Color(0xFF6B7280),
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
                          'Continue to Carry Items',
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
