import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

    _model.numOfpassTextController ??= TextEditingController();
    _model.numOfpassFocusNode ??=FocusNode();

    _model.parcelDeliveryTextController ??= TextEditingController();
    _model.parcelDeliveryFocusNode ??= FocusNode();

    _model.passangerCostTextController ??= TextEditingController();
    _model.passangerCostFocusNode ??= FocusNode();
  }



// For exceed errors with auto-fill
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
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ⚠️ Warning Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF8C00).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFFF8C00),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),

                // 🏷 Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context)
                      .titleMedium
                      .override(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),

                // 📄 Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context)
                      .bodyMedium
                      .override(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),

                // 💰 Show max amounts
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Maximum allowed amounts:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '📦 Parcel',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '₹${maxParcel.toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFFF8C00),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '🚗 Ride',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '₹${maxRide.toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFFF8C00),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // ✅ Action button - Auto-fill max amounts
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF8C00),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        // Clear both fields
                        _model.parcelDeliveryTextController?.clear();
                        _model.passangerCostTextController?.clear();

                        // Then auto-fill with max amounts
                        _model.parcelDeliveryTextController.text = maxParcel.toInt().toString();
                        _model.passangerCostTextController.text = maxRide.toInt().toString();
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Fill with maximum amount',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

// For info errors (missing details, invalid input, distance error)
  Future<void> _showInfoDialog(
      BuildContext context, {
        required String title,
        required String message,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF8C00).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Color(0xFFFF8C00),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context)
                      .titleMedium
                      .override(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context)
                      .bodyMedium
                      .override(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF8C00),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Got it',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Parcel & Ride Cost',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0.0, 22.0, 0.0, 0.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 25.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                      DriverDetail10Widget.routeName);
                                },
                                text: 'Skip',
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0x1F4CAF50),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontWeight,
                                        fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).success,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: CircularPercentIndicator(
                              percent: 0.6,
                              radius: 60.0,
                              lineWidth: 12.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: Color(0xFFF57C3B),
                              backgroundColor: Color(0xFFD8D5D5),
                              center: Text(
                                '60%',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .fontWeight,
                                        fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .headlineSmall
                                                .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // NUMBER OF PASSENGERS
                              Align( // 👈 LEFT ALIGN HEADING
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0), // 👈 REDUCED FROM 16 TO 8
                                  child: Text(
                                    'Number of Passengers',
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: Color(0xFF1A5FB4),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.numOfpassTextController,
                                  focusNode: _model.numOfpassFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    // labelText: 'Enter number of passengers',
                                    hintText: 'Enter number of passengers',
                                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: Color(0xFF757575),
                                      letterSpacing: 0.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF1A5FB4),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F5),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // 👈 ADDED FOR BETTER TEXT FIELD HEIGHT
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    color: Color(0xFF333333),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF1A5FB4),
                                  validator: _model.numOfpassTextControllerValidator.asValidator(context),
                                ),
                              ),

                              SizedBox(height: 16.0), // 👈 SPACING BEFORE NEXT SECTION

                              // PARCEL DELIVERY COST
                              Align( // 👈 LEFT ALIGN HEADING
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0), // 👈 REDUCED FROM 16 TO 8
                                  child: Text(
                                    'Parcel Delivery Cost',
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: Color(0xFF1A5FB4),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.parcelDeliveryTextController,
                                  focusNode: _model.parcelDeliveryFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    // labelText: 'How much do you charge for parcel delivery?',
                                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: Color(0xFF757575),
                                      letterSpacing: 0.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF1A5FB4),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F5),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // 👈 ADDED FOR CONSISTENCY
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    color: Color(0xFF333333),
                                    letterSpacing: 0.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF1A5FB4),
                                  validator: _model.parcelDeliveryTextControllerValidator.asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0), // 👈 REDUCED TOP PADDING
                                child: Text(
                                  '₹1.5/km, final logistics rate as per size & delicacy (to be discussed on call).',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.0), // 👈 SPACING BEFORE NEXT SECTION

                              // RIDE COST
                              Align( // 👈 LEFT ALIGN HEADING
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0), // 👈 REDUCED FROM 16 TO 8
                                  child: Text(
                                    'Ride Cost',
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: Color(0xFF1A5FB4),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _model.passangerCostTextController,
                                  focusNode: _model.passangerCostFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    // labelText: 'How much do you charge per passenger?',
                                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                      font: GoogleFonts.inter(),
                                      color: Color(0xFF757575),
                                      letterSpacing: 0.0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF1A5FB4),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F5F5),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0), // 👈 ADDED FOR CONSISTENCY
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    color: Color(0xFF333333),
                                    letterSpacing: 0.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xFF1A5FB4),
                                  validator: _model.passangerCostTextControllerValidator.asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 0.0), // 👈 REDUCED TOP PADDING
                                child: Text(
                                  '₹2.5/km, final rate as per number of passenger & location (to be discussed on call).',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(),
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // if (_model.parcelDeliveryTextController.text != null &&
                      //     _model.parcelDeliveryTextController.text != '')
                        Align(
                          alignment: AlignmentDirectional(1.0, 1.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final passengerCountText = _model.numOfpassTextController.text.trim();
                              final parcelText = _model.parcelDeliveryTextController.text.trim();
                              final passengerText = _model.passangerCostTextController.text.trim();

                              print('📦 Parcel Delivery Cost: $parcelText');
                              print('👥 Ride Cost: $passengerText');
                              print('👥 Passenger Count: $passengerCountText');

                              // Empty check
                              if (parcelText.isEmpty || passengerText.isEmpty || passengerCountText.isEmpty) {
                                await _showInfoDialog(
                                  context,
                                  title: 'Missing details',
                                  message: 'Please fill all details',
                                );
                                return;
                              }

                              final passengerCount = double.tryParse(passengerCountText);
                              final parcelAmount = double.tryParse(parcelText);
                              final rideAmount = double.tryParse(passengerText);

                              if (parcelAmount == null || rideAmount == null || passengerCount == null) {
                                await _showInfoDialog(
                                  context,
                                  title: 'Invalid amount',
                                  message: 'Please enter valid numeric values',
                                );
                                return;
                              }

                              // Extract KM
                              final travelTime = FFAppState().travelTime;
                              final kmMatch = RegExp(r'\((\d+)\s*km\)').firstMatch(travelTime);

                              if (kmMatch == null) {
                                await _showInfoDialog(
                                  context,
                                  title: 'Distance error',
                                  message: 'Unable to calculate distance',
                                );
                                return;
                              }

                              final totalKm = double.parse(kmMatch.group(1)!);

                              // Rates
                              final maxParcel = totalKm * 1.5; // ₹1/km
                              final maxRide = totalKm * 2.5;   // ₹2/km

                              // Validation messages with auto-fill
                              if (parcelAmount > maxParcel && rideAmount > maxRide) {
                                await _showExceedDialog(
                                  context: context,
                                  title: 'Amount exceeded',
                                  message: 'Both parcel and ride charges exceed the maximum limits.',
                                  maxParcel: maxParcel,
                                  maxRide: maxRide,
                                );
                                return;
                              }

                              if (parcelAmount > maxParcel) {
                                await _showExceedDialog(
                                  context: context,
                                  title: 'Parcel charge exceeded',
                                  message: 'Your parcel charge exceeds the maximum limit of ₹${maxParcel.toInt()}.',
                                  maxParcel: maxParcel,
                                  maxRide: maxRide,
                                );
                                return;
                              }

                              if (rideAmount > maxRide) {
                                await _showExceedDialog(
                                  context: context,
                                  title: 'Ride charge exceeded',
                                  message: 'Your ride charge exceeds the maximum limit of ₹${maxRide.toInt()}.',
                                  maxParcel: maxParcel,
                                  maxRide: maxRide,
                                );
                                return;
                              }

                              // ✅ SAVE TO PREFS
                              FFAppState().totalDelvieryCost = parcelText;
                              FFAppState().pricePerPassengers = rideAmount.toInt();
                              FFAppState().numPassengers = passengerCount.toInt();
                              safeSetState(() {});

                              print('✅ State Updated - Parcel: ${FFAppState().totalDelvieryCost}');
                              print('✅ State Updated - Ride: ${FFAppState().pricePerPassengers}');

                              context.pushNamed(WhatyouCarry5Widget.routeName);
                            },
                            // onTap: () async {
                            //   print('📦 Parcel Delivery Cost: ${_model.parcelDeliveryTextController.text}');
                            //   print('👥 Passenger Cost: ${_model.passangerCostTextController.text}');
                            //
                            //   if (_model.parcelDeliveryTextController.text != null &&
                            //       _model.parcelDeliveryTextController.text != '') {
                            //     FFAppState().totalDelvieryCost = _model.parcelDeliveryTextController.text;
                            //     FFAppState().pricePerPassengers = int.parse(_model.passangerCostTextController.text);
                            //     safeSetState(() {});
                            //
                            //     print('✅ State Updated - Total Delivery: ${FFAppState().totalDelvieryCost}');
                            //     print('✅ State Updated - Per Passenger: ${FFAppState().pricePerPassengers}');
                            //
                            //     context.pushNamed(WhatyouCarry5Widget.routeName);
                            //   } else {
                            //     await showDialog(
                            //       context: context,
                            //       builder: (alertDialogContext) {
                            //         return AlertDialog(
                            //           title: Text('Attention'),
                            //           content: Text('Please fill all details'),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () => Navigator.pop(alertDialogContext),
                            //               child: Text('Ok'),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   }
                            // },
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF8C00),
                                shape: BoxShape.circle,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
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
      ),
    );
  }
}
