import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bid_posted_thanks_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'send_parcel_model.dart';
export 'send_parcel_model.dart';

class SendParcelWidget extends StatefulWidget {
  const SendParcelWidget({
    super.key,
    required this.bookingKarnaHai,
  });

  final DocumentReference? bookingKarnaHai;

  static String routeName = 'SendParcel';
  static String routePath = '/sendParcel';

  @override
  State<SendParcelWidget> createState() => _SendParcelWidgetState();
}

class _SendParcelWidgetState extends State<SendParcelWidget> {
  late SendParcelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SendParcelModel());

    _model.itemNameTextController ??= TextEditingController();
    _model.itemNameFocusNode ??= FocusNode();

    _model.reciverNameTextController ??= TextEditingController(text: currentUserDisplayName);
    _model.reciverNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.additionalInformationTextController ??= TextEditingController();
    _model.additionalInformationFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RidesNewRecord>(
      stream: RidesNewRecord.getDocument(widget!.bookingKarnaHai!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitFadingCircle(
                  color: Color(0xFF2B3C58),
                  size: 50.0,
                ),
              ),
            ),
          );
        }

        final sendParcelRidesNewRecord = snapshot.data!;

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
                'Post a Bid',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                      fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).containerColour,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).containerBG,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: Color(0xFFA7A7A7),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 12.0),
                                                child: Text(
                                                  'Product details',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme.of(context).iconColours,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: _model.itemNameTextController,
                                                focusNode: _model.itemNameFocusNode,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Documents',
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFD0D0D0),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: FlutterFlowTheme.of(context).accent4,
                                                ),
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                    ),
                                                validator: _model.itemNameTextControllerValidator.asValidator(context),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 12.0),
                                                child: Text(
                                                  'Name of Recipient',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme.of(context).iconColours,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                              ),
                                              AuthUserStreamWidget(
                                                builder: (context) => TextFormField(
                                                  controller: _model.reciverNameTextController,
                                                  focusNode: _model.reciverNameFocusNode,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Sumit',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme.of(context).accent4,
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                  validator: _model.reciverNameTextControllerValidator.asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 12.0),
                                                child: Text(
                                                  'Contact person\'s number',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme.of(context).iconColours,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.w500,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                ),
                                              ),
                                              AuthUserStreamWidget(
                                                builder: (context) => TextFormField(
                                                  controller: _model.phoneNumberTextController,
                                                  focusNode: _model.phoneNumberFocusNode,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: '7312345678',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme.of(context).accent4,
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                  keyboardType: TextInputType.phone,
                                                  validator: _model.phoneNumberTextControllerValidator.asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    'Address of meetup',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme.of(context).iconColours,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _model.addressTextController,
                                                  focusNode: _model.addressFocusNode,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                        ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme.of(context).accent4,
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                  validator: _model.addressTextControllerValidator.asValidator(context),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    'Additional Information',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w500,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme.of(context).iconColours,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w500,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: _model.additionalInformationTextController,
                                                  focusNode: _model.additionalInformationFocusNode,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                        ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme.of(context).accent4,
                                                  ),
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                      ),
                                                  validator: _model.additionalInformationTextControllerValidator.asValidator(context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity: VisualDensity.compact,
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                          ),
                                          unselectedWidgetColor: Color(0xFFFF0606),
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue ??= false,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model.checkboxValue = newValue!);
                                          },
                                          side: (Color(0xFFFF0606) != null)
                                              ? BorderSide(
                                                  width: 2,
                                                  color: Color(0xFFFF0606)!,
                                                )
                                              : null,
                                          activeColor: FlutterFlowTheme.of(context).secondary,
                                          checkColor: FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                      Text(
                                        'Please Read our terms and conditions *',
                                        style: FlutterFlowTheme.of(context).bodySmall.override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                              ),
                                              color: Color(0xFF848484),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 12.0),
                                        child: Builder(
                                          builder: (context) => FFButtonWidget(
                                            onPressed: () async {
                                              if ((_model.itemNameTextController.text != null && _model.itemNameTextController.text != '') &&
                                                  (_model.reciverNameTextController.text != null && _model.reciverNameTextController.text != '') &&
                                                  (_model.phoneNumberTextController.text != null && _model.phoneNumberTextController.text != '') &&
                                                  (_model.addressTextController.text != null && _model.addressTextController.text != '') &&
                                                  (_model.additionalInformationTextController.text != null && _model.additionalInformationTextController.text != '') &&
                                                  (_model.checkboxValue == true)) {
                                                await BookingsRecord.collection.doc().set(createBookingsRecordData(
                                                      itemName: _model.itemNameTextController.text,
                                                      receiverName: _model.reciverNameTextController.text,
                                                      phoneNumber: _model.phoneNumberTextController.text,
                                                      meetupLocation: _model.addressTextController.text,
                                                      additionalInformation: _model.additionalInformationTextController.text,
                                                      createdTime: getCurrentTimestamp,
                                                      creator: currentUserReference,
                                                      rideID: sendParcelRidesNewRecord.reference,
                                                      status: 'Pending',
                                                    ));
                                                await showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding: EdgeInsets.zero,
                                                      backgroundColor: Colors.transparent,
                                                      alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          FocusScope.of(dialogContext).unfocus();
                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                        },
                                                        child: BidPostedThanksWidget(),
                                                      ),
                                                    );
                                                  },
                                                );

                                                context.goNamed(
                                                  HomeWidget.routeName,
                                                  queryParameters: {
                                                    'tabNumberRef': serializeParam(
                                                      1,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder: (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Attention Required '),
                                                      content: Text('Please fill in all the details carefully.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            text: 'Book Now',
                                            options: FFButtonOptions(
                                              width: 150.0,
                                              height: 50.0,
                                              padding: EdgeInsets.all(8.0),
                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFFF77F4A),
                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                    font: GoogleFonts.interTight(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                    ),
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                  ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 5.0)),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
