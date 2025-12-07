import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'ride_edit_page_model.dart';
export 'ride_edit_page_model.dart';

class RideEditPageWidget extends StatefulWidget {
  const RideEditPageWidget({
    super.key,
    required this.rideEdit,
  });

  final DocumentReference? rideEdit;

  static String routeName = 'RideEditPage';
  static String routePath = '/rideEditPage';

  @override
  State<RideEditPageWidget> createState() => _RideEditPageWidgetState();
}

class _RideEditPageWidgetState extends State<RideEditPageWidget> {
  late RideEditPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RideEditPageModel());

    _model.expandableExpandableController1 = ExpandableController(initialExpanded: false);

    _model.rideStartLocationFocusNode ??= FocusNode();

    _model.rideEndLocatioFocusNode ??= FocusNode();

    _model.expandableExpandableController2 = ExpandableController(initialExpanded: false);
    _model.expandableExpandableController3 = ExpandableController(initialExpanded: false);
    _model.expandableExpandableController4 = ExpandableController(initialExpanded: false);

    _model.fullCostFocusNode ??= FocusNode();

    _model.expandableExpandableController5 = ExpandableController(initialExpanded: false);

    _model.travelTimeFocusNode ??= FocusNode();

    _model.expandableExpandableController6 = ExpandableController(initialExpanded: false);

    _model.rideRule1FocusNode ??= FocusNode();

    _model.rideRule2FocusNode ??= FocusNode();

    _model.rideRule3FocusNode ??= FocusNode();

    _model.rideRule4FocusNode ??= FocusNode();

    _model.rideRule5FocusNode ??= FocusNode();

    _model.rideRule6FocusNode ??= FocusNode();

    _model.expandableExpandableController7 = ExpandableController(initialExpanded: false);

    _model.driverContactnumberFocusNode ??= FocusNode();

    _model.driverContactnumberMask = MaskTextInputFormatter(mask: '+91 ##### #####');

    _model.vehicleNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RidesNewRecord>(
      stream: RidesNewRecord.getDocument(widget!.rideEdit!),
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

        final rideEditPageRidesNewRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Color(0xFF2B3C58),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Ride Edit',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                      ),
                      color: Colors.white,
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
                  padding: EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Color(0x00000000),
                                      child: ExpandableNotifier(
                                        controller: _model.expandableExpandableController1,
                                        child: ExpandablePanel(
                                          header: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              'Ride Start & Edit Location',
                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                    font: GoogleFonts.interTight(
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                    ),
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 60.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F5F5),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    border: Border.all(
                                                      color: Color(0xFF4DABF7),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model.rideStartLocationTextController ??= TextEditingController(
                                                        text: rideEditPageRidesNewRecord.rideStartLocation,
                                                      ),
                                                      focusNode: _model.rideStartLocationFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        hintText: 'Ride Start Location',
                                                        hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              color: Color(0xFF999999),
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder: InputBorder.none,
                                                        errorBorder: InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                                                      validator: _model.rideStartLocationTextControllerValidator.asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 60.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F5F5),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                    border: Border.all(
                                                      color: Color(0xFF4DABF7),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      controller: _model.rideEndLocatioTextController ??= TextEditingController(
                                                        text: rideEditPageRidesNewRecord.rideEndLocation,
                                                      ),
                                                      focusNode: _model.rideEndLocatioFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration: InputDecoration(
                                                        hintText: 'Ride End Location',
                                                        hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              color: Color(0xFF999999),
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                        enabledBorder: InputBorder.none,
                                                        focusedBorder: InputBorder.none,
                                                        errorBorder: InputBorder.none,
                                                        focusedErrorBorder: InputBorder.none,
                                                        contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                                                      validator: _model.rideEndLocatioTextControllerValidator.asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await rideEditPageRidesNewRecord.reference.update(createRidesNewRecordData(
                                                      rideStartLocation: _model.rideStartLocationTextController.text,
                                                      rideEndLocation: _model.rideStartLocationTextController.text,
                                                    ));
                                                  },
                                                  text: 'Update Now',
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 40.0,
                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                    color: Color(0xFFF67E4A),
                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                          font: GoogleFonts.interTight(
                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                    elevation: 0.0,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 15.0)),
                                            ),
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: true,
                                            tapBodyToCollapse: false,
                                            headerAlignment: ExpandablePanelHeaderAlignment.top,
                                            hasIcon: true,
                                            expandIcon: Icons.edit,
                                            collapseIcon: Icons.clear,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 14.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Color(0x00000000),
                                      child: ExpandableNotifier(
                                        controller: _model.expandableExpandableController2,
                                        child: ExpandablePanel(
                                          header: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              'Ride Start & End Date',
                                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                                    font: GoogleFonts.interTight(
                                                      fontWeight: FontWeight.w600,
                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                    ),
                                                    fontSize: 20.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                            ),
                                          ),
                                          collapsed: Container(),
                                          expanded: SingleChildScrollView(
                                            primary: false,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 10.0),
                                                  child: Text(
                                                    'Ride Start Date and Time',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    final _datePicked1Date = await showDatePicker(
                                                      context: context,
                                                      initialDate: getCurrentTimestamp,
                                                      firstDate: getCurrentTimestamp,
                                                      lastDate: DateTime(2050),
                                                      builder: (context, child) {
                                                        return wrapInMaterialDatePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor: Color(0xFFF9814F),
                                                          headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                          headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                font: GoogleFonts.interTight(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                ),
                                                                fontSize: 32.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w600,
                                                                fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                              ),
                                                          pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                          pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                          selectedDateTimeBackgroundColor: Color(0xFFF9814F),
                                                          selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                          actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );

                                                    TimeOfDay? _datePicked1Time;
                                                    if (_datePicked1Date != null) {
                                                      _datePicked1Time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.fromDateTime(getCurrentTimestamp),
                                                        builder: (context, child) {
                                                          return wrapInMaterialTimePickerTheme(
                                                            context,
                                                            child!,
                                                            headerBackgroundColor: Color(0xFFF9814F),
                                                            headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                            headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                  font: GoogleFonts.interTight(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                  ),
                                                                  fontSize: 32.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                ),
                                                            pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                            pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                            selectedDateTimeBackgroundColor: Color(0xFFF9814F),
                                                            selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                            actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                            iconSize: 24.0,
                                                          );
                                                        },
                                                      );
                                                    }

                                                    if (_datePicked1Date != null && _datePicked1Time != null) {
                                                      safeSetState(() {
                                                        _model.datePicked1 = DateTime(
                                                          _datePicked1Date.year,
                                                          _datePicked1Date.month,
                                                          _datePicked1Date.day,
                                                          _datePicked1Time!.hour,
                                                          _datePicked1Time.minute,
                                                        );
                                                      });
                                                    } else if (_model.datePicked1 != null) {
                                                      safeSetState(() {
                                                        _model.datePicked1 = getCurrentTimestamp;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.watch_later_rounded,
                                                    color: Color(0xFF4DABF7),
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                      child: Text(
                                                        'Time:',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              fontSize: 18.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        if (_model.datePicked1 != null) {
                                                          return Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                            child: Text(
                                                              dateTimeFormat("d/M h:mm a", _model.datePicked1),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    fontSize: 18.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                            child: Text(
                                                              dateTimeFormat("d/M h:mm a", rideEditPageRidesNewRecord.pickupTime!),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    fontSize: 18.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ].divide(SizedBox(width: 6.0)),
                                                ),
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                  child: Text(
                                                    'Ride End Date and Time',
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          font: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                          ),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                        ),
                                                  ),
                                                ),
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    final _datePicked2Date = await showDatePicker(
                                                      context: context,
                                                      initialDate: getCurrentTimestamp,
                                                      firstDate: getCurrentTimestamp,
                                                      lastDate: DateTime(2050),
                                                      builder: (context, child) {
                                                        return wrapInMaterialDatePickerTheme(
                                                          context,
                                                          child!,
                                                          headerBackgroundColor: Color(0xFFF9814F),
                                                          headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                          headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                font: GoogleFonts.interTight(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                ),
                                                                fontSize: 32.0,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FontWeight.w600,
                                                                fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                              ),
                                                          pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                          pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                          selectedDateTimeBackgroundColor: Color(0xFFF9814F),
                                                          selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                          actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                          iconSize: 24.0,
                                                        );
                                                      },
                                                    );

                                                    TimeOfDay? _datePicked2Time;
                                                    if (_datePicked2Date != null) {
                                                      _datePicked2Time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.fromDateTime(getCurrentTimestamp),
                                                        builder: (context, child) {
                                                          return wrapInMaterialTimePickerTheme(
                                                            context,
                                                            child!,
                                                            headerBackgroundColor: Color(0xFFF9814F),
                                                            headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                            headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                  font: GoogleFonts.interTight(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                  ),
                                                                  fontSize: 32.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                ),
                                                            pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                            pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                            selectedDateTimeBackgroundColor: Color(0xFFF9814F),
                                                            selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                            actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                            iconSize: 24.0,
                                                          );
                                                        },
                                                      );
                                                    }

                                                    if (_datePicked2Date != null && _datePicked2Time != null) {
                                                      safeSetState(() {
                                                        _model.datePicked2 = DateTime(
                                                          _datePicked2Date.year,
                                                          _datePicked2Date.month,
                                                          _datePicked2Date.day,
                                                          _datePicked2Time!.hour,
                                                          _datePicked2Time.minute,
                                                        );
                                                      });
                                                    } else if (_model.datePicked2 != null) {
                                                      safeSetState(() {
                                                        _model.datePicked2 = getCurrentTimestamp;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.watch_later_rounded,
                                                    color: Color(0xFF4DABF7),
                                                    size: 40.0,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                      child: Text(
                                                        'Time:',
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              fontSize: 18.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        if (_model.datePicked2 != null) {
                                                          return Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                            child: Text(
                                                              dateTimeFormat("d/M h:mm a", _model.datePicked2),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    fontSize: 18.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          );
                                                        } else {
                                                          return Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                            child: Text(
                                                              dateTimeFormat("d/M h:mm a", rideEditPageRidesNewRecord.dropTime!),
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    fontSize: 18.0,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ].divide(SizedBox(width: 6.0)),
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await rideEditPageRidesNewRecord.reference.update(createRidesNewRecordData(
                                                      pickupTime: _model.datePicked1 != null ? _model.datePicked1 : rideEditPageRidesNewRecord.pickupTime,
                                                      dropTime: _model.datePicked2 != null ? _model.datePicked2 : rideEditPageRidesNewRecord.dropTime,
                                                    ));
                                                  },
                                                  text: 'Update Now',
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 40.0,
                                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                    color: Color(0xFFF67E4A),
                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                          font: GoogleFonts.interTight(
                                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                    elevation: 0.0,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 15.0)),
                                            ),
                                          ),
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment: ExpandablePanelHeaderAlignment.top,
                                            hasIcon: true,
                                            expandIcon: Icons.edit,
                                            collapseIcon: Icons.clear,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 14.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                    child: Text(
                                      'Carry Items',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                          ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        CarryItemEditWidget.routeName,
                                        queryParameters: {
                                          'carryItemEdit': serializeParam(
                                            rideEditPageRidesNewRecord.reference,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Color(0x00000000),
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController3,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Carry Items',
                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Predefined Legal Items carry',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).titleLarge.override(
                                                      font: GoogleFonts.interTight(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                      ),
                                                      color: Color(0xFF303337),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                    ),
                                              ),
                                              if (rideEditPageRidesNewRecord.isPredefinedItems == false)
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                  child: Wrap(
                                                    spacing: 10.0,
                                                    runSpacing: 10.0,
                                                    alignment: WrapAlignment.start,
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    direction: Axis.horizontal,
                                                    runAlignment: WrapAlignment.start,
                                                    verticalDirection: VerticalDirection.down,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              safeSetState(() {});
                                                            },
                                                            child: Text(
                                                              'Food Item',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: Color(0xFF333333),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Sweets',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Spices',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Crockery',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Small Appliances',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Kitchen Items',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Festival goodies',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Clothing & Accessories',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Tech & Electronics',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Homemade Food & Snacks',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Documents',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Child-related Items',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Discuss over call',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Others',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Color(0xFF333333),
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              if (rideEditPageRidesNewRecord.isPredefinedItems == true)
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                  child: Wrap(
                                                    spacing: 10.0,
                                                    runSpacing: 10.0,
                                                    alignment: WrapAlignment.start,
                                                    crossAxisAlignment: WrapCrossAlignment.start,
                                                    direction: Axis.horizontal,
                                                    runAlignment: WrapAlignment.start,
                                                    verticalDirection: VerticalDirection.down,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: InkWell(
                                                            splashColor: Colors.transparent,
                                                            focusColor: Colors.transparent,
                                                            hoverColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () async {
                                                              safeSetState(() {});
                                                            },
                                                            child: Text(
                                                              'Food Item',
                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    color: Colors.white,
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Sweets',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Colors.white,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Spices',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Colors.white,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Crockery',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Small Appliances',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: Colors.white,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Kitchen Items',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Festival goodies',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Clothing & Accessories',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Tech & Electronics',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Homemade Food & Snacks',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Documents',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Child-related Items',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Discuss over call',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF2563EB),
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                          child: Text(
                                                            'Others',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  if (rideEditPageRidesNewRecord.isPredefinedItems == false)
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await widget!.rideEdit!.update(createRidesNewRecordData(
                                                          isPredefinedItems: true,
                                                        ));
                                                        await showDialog(
                                                          context: context,
                                                          builder: (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text('Selected'),
                                                              content: Text('Predefined items selected. '),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                  child: Text('Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      text: 'Accept All',
                                                      options: FFButtonOptions(
                                                        width: 130.0,
                                                        height: 40.0,
                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                        color: Color(0x1F4CAF50),
                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme.of(context).success,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme.of(context).success,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    ),
                                                  if (rideEditPageRidesNewRecord.isPredefinedItems == true)
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await widget!.rideEdit!.update(createRidesNewRecordData(
                                                          isPredefinedItems: false,
                                                        ));
                                                        await showDialog(
                                                          context: context,
                                                          builder: (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text('Unselected'),
                                                              content: Text('Predefined items unselected. '),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                  child: Text('Ok'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      text: 'Remove All',
                                                      options: FFButtonOptions(
                                                        width: 130.0,
                                                        height: 40.0,
                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                        color: Color(0x1FAF4C6C),
                                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme.of(context).error,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme.of(context).error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1.5,
                                                color: Color(0xFFFC8D54),
                                              ),
                                              Text(
                                                'OR Set manually',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context).titleLarge.override(
                                                      font: GoogleFonts.interTight(
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                      ),
                                                      color: Color(0xFF303337),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                    ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  await widget!.rideEdit!.update(createRidesNewRecordData());
                                                },
                                                text: 'Update Now',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Color(0xFFF67E4A),
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.top,
                                          hasIcon: true,
                                          expandIcon: Icons.edit,
                                          collapseIcon: Icons.clear,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 14.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Color(0x00000000),
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController4,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Costing ',
                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 15.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                      child: Text(
                                                        'Parcel Delivery Cost',
                                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                                              font: GoogleFonts.interTight(
                                                                fontWeight: FontWeight.w600,
                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                              ),
                                                              color: Color(0xFF1A5FB4),
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.w600,
                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model.fullCostTextController ??= TextEditingController(
                                                          text: rideEditPageRidesNewRecord.totalDeliveryCost,
                                                        ),
                                                        focusNode: _model.fullCostFocusNode,
                                                        autofocus: false,
                                                        textCapitalization: TextCapitalization.sentences,
                                                        textInputAction: TextInputAction.done,
                                                        obscureText: false,
                                                        decoration: InputDecoration(
                                                          labelText: 'Full Ride Parcel Delivery Cost',
                                                          hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                font: GoogleFonts.inter(
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                                color: Color(0xFF757575),
                                                                letterSpacing: 0.0,
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                              color: Color(0xFF1A5FB4),
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
                                                        ),
                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              font: GoogleFonts.inter(
                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                              ),
                                                              color: Color(0xFF333333),
                                                              letterSpacing: 0.0,
                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                            ),
                                                        cursorColor: Color(0xFF1A5FB4),
                                                        validator: _model.fullCostTextControllerValidator.asValidator(context),
                                                        inputFormatters: [
                                                          if (!isAndroid && !isiOS)
                                                            TextInputFormatter.withFunction((oldValue, newValue) {
                                                              return TextEditingValue(
                                                                selection: newValue.selection,
                                                                text: newValue.text.toCapitalization(TextCapitalization.sentences),
                                                              );
                                                            }),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if (_model.fullCostTextController.text != null && _model.fullCostTextController.text != '') {
                                                    await widget!.rideEdit!.update(createRidesNewRecordData(
                                                      totalDeliveryCost: _model.fullCostTextController.text,
                                                    ));
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Attention'),
                                                          content: Text('Please fill all details'),
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
                                                text: 'Update Now',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Color(0xFFF67E4A),
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.top,
                                          hasIcon: true,
                                          expandIcon: Icons.edit,
                                          collapseIcon: Icons.clear,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 14.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Color(0x00000000),
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController5,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Travel Time',
                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Estimate Time Travel',
                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                          font: GoogleFonts.interTight(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: double.infinity,
                                                          child: TextFormField(
                                                            controller: _model.travelTimeTextController ??= TextEditingController(
                                                              text: rideEditPageRidesNewRecord.travelTime,
                                                            ),
                                                            focusNode: _model.travelTimeFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration: InputDecoration(
                                                              hintText: ' Travel  Time (1 day, 2 Hours 45 mins)',
                                                              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(0xFFF5F5F5),
                                                            ),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  fontSize: 16.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                            textAlign: TextAlign.center,
                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                            validator: _model.travelTimeTextControllerValidator.asValidator(context),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(SizedBox(height: 16.0)),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if (_model.travelTimeTextController.text != null && _model.travelTimeTextController.text != '') {
                                                    await widget!.rideEdit!.update(createRidesNewRecordData(
                                                      travelTime: _model.travelTimeTextController.text,
                                                    ));
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Attention'),
                                                          content: Text('Please fill travel time'),
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
                                                text: 'Update Now',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Color(0xFFF67E4A),
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.top,
                                          hasIcon: true,
                                          expandIcon: Icons.edit,
                                          collapseIcon: Icons.clear,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 14.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                    child: Text(
                                      'Stoppage ',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                            font: GoogleFonts.interTight(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Color(0x00000000),
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController6,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Ride Rules',
                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                child: SingleChildScrollView(
                                                  primary: false,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Predefined Ride Rules',
                                                        textAlign: TextAlign.center,
                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                              font: GoogleFonts.interTight(
                                                                fontWeight: FontWeight.bold,
                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                              ),
                                                              color: Color(0xFF303337),
                                                              fontSize: 15.0,
                                                              letterSpacing: 0.0,
                                                              fontWeight: FontWeight.bold,
                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                                                        child: Wrap(
                                                          spacing: 10.0,
                                                          runSpacing: 10.0,
                                                          alignment: WrapAlignment.start,
                                                          crossAxisAlignment: WrapCrossAlignment.start,
                                                          direction: Axis.horizontal,
                                                          runAlignment: WrapAlignment.start,
                                                          verticalDirection: VerticalDirection.down,
                                                          clipBehavior: Clip.none,
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: InkWell(
                                                                  splashColor: Colors.transparent,
                                                                  focusColor: Colors.transparent,
                                                                  hoverColor: Colors.transparent,
                                                                  highlightColor: Colors.transparent,
                                                                  onTap: () async {
                                                                    safeSetState(() {});
                                                                  },
                                                                  child: Text(
                                                                    'We accept only legal parcels—no prohibited or illegal items allowed.',
                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                          font: GoogleFonts.inter(
                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color: Color(0xFF333333),
                                                                          letterSpacing: 0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'Customers must arrive with the parcel at least 10 minutes before the vehicle arrives.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'Complete receiver information is required at the time of booking.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'Unacceptable items found during the ride may lead to cancellation or being reported.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'Parcels must be securely packed to avoid damage during transit.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'Fragile or high-value items should be declared beforehand.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                borderRadius: BorderRadius.circular(20.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                                                                child: Text(
                                                                  'We are not responsible for delays caused by incomplete or incorrect information.',
                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                        font: GoogleFonts.inter(
                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                        ),
                                                                        color: Color(0xFF333333),
                                                                        letterSpacing: 0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            FFButtonWidget(
                                                              onPressed: () async {
                                                                await widget!.rideEdit!.update(createRidesNewRecordData(
                                                                  isRideRulesAccepted: true,
                                                                ));
                                                                await showDialog(
                                                                  context: context,
                                                                  builder: (alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: Text('Selected'),
                                                                      content: Text('Predefined ride rules selected. '),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                          child: Text('Ok'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              text: 'Accept All',
                                                              options: FFButtonOptions(
                                                                width: 130.0,
                                                                height: 40.0,
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                color: Color(0x1F4CAF50),
                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(context).success,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).success,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8.0),
                                                              ),
                                                            ),
                                                            FFButtonWidget(
                                                              onPressed: () async {
                                                                await widget!.rideEdit!.update(createRidesNewRecordData(
                                                                  isRideRulesAccepted: false,
                                                                ));
                                                                await showDialog(
                                                                  context: context,
                                                                  builder: (alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: Text('Unselected'),
                                                                      content: Text('Predefined ride rules unselected. '),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                          child: Text('Ok'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              text: 'Remove It',
                                                              options: FFButtonOptions(
                                                                width: 130.0,
                                                                height: 40.0,
                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                color: Color(0x1FAF4C6C),
                                                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                      font: GoogleFonts.inter(
                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(context).error,
                                                                      letterSpacing: 0.0,
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(8.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      StyledDivider(
                                                        thickness: 1.5,
                                                        color: Color(0xFFF9814F),
                                                        lineStyle: DividerLineStyle.dashdotted,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                        child: Text(
                                                          'OR',
                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                font: GoogleFonts.interTight(
                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                letterSpacing: 0.0,
                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                        child: SingleChildScrollView(
                                                          primary: false,
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Align(
                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                                                  child: Container(
                                                                    width: double.infinity,
                                                                    decoration: BoxDecoration(
                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                    ),
                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.all(6.0),
                                                                      child: Text(
                                                                        'Please fill minimum 3 out all required fields',
                                                                        textAlign: TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                              font: GoogleFonts.interTight(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    children: [
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 1',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule1TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule1,
                                                                                  ),
                                                                                  focusNode: _model.rideRule1FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 1st rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule1TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 2',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule2TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule2,
                                                                                  ),
                                                                                  focusNode: _model.rideRule2FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 2nd rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule2TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 3',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule3TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule3,
                                                                                  ),
                                                                                  focusNode: _model.rideRule3FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 3rd rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule3TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 4',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule4TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule4,
                                                                                  ),
                                                                                  focusNode: _model.rideRule4FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 4th rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule4TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 5',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule5TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule5,
                                                                                  ),
                                                                                  focusNode: _model.rideRule5FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 5th rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule5TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 4.0,
                                                                              color: Color(0x1A000000),
                                                                              offset: Offset(
                                                                                0.0,
                                                                                2.0,
                                                                              ),
                                                                            )
                                                                          ],
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.all(16.0),
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Rule 6',
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      font: GoogleFonts.interTight(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                              Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.rideRule6TextController ??= TextEditingController(
                                                                                    text: rideEditPageRidesNewRecord.rideRule6,
                                                                                  ),
                                                                                  focusNode: _model.rideRule6FocusNode,
                                                                                  autofocus: false,
                                                                                  obscureText: false,
                                                                                  decoration: InputDecoration(
                                                                                    labelText: 'Enter 6th rule here',
                                                                                    labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    errorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(
                                                                                        color: Color(0x00000000),
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                    ),
                                                                                    filled: true,
                                                                                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.rideRule6TextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 12.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(height: 16.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if ((_model.rideRule1TextController.text != null && _model.rideRule1TextController.text != '') && (_model.rideRule2TextController.text != null && _model.rideRule2TextController.text != '') && (_model.rideRule3TextController.text != null && _model.rideRule3TextController.text != '')) {
                                                    await widget!.rideEdit!.update(createRidesNewRecordData(
                                                      rideRule1: _model.rideRule1TextController.text,
                                                      rideRule2: _model.rideRule2TextController.text,
                                                      rideRule3: _model.rideRule3TextController.text,
                                                      rideRule4: _model.rideRule4TextController.text,
                                                      rideRule5: _model.rideRule5TextController.text,
                                                      rideRule6: _model.rideRule6TextController.text,
                                                    ));
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Attention'),
                                                          content: Text('Please add atleast 3 ride rules'),
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
                                                text: 'Update Now',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Color(0xFFF67E4A),
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.top,
                                          hasIcon: true,
                                          expandIcon: Icons.edit,
                                          collapseIcon: Icons.clear,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 14.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Color(0x00000000),
                                    child: ExpandableNotifier(
                                      controller: _model.expandableExpandableController7,
                                      child: ExpandablePanel(
                                        header: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Driver Details',
                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                ),
                                          ),
                                        ),
                                        collapsed: Container(),
                                        expanded: SingleChildScrollView(
                                          primary: false,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Driver Contact Number',
                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                          font: GoogleFonts.interTight(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: double.infinity,
                                                          child: TextFormField(
                                                            controller: _model.driverContactnumberTextController ??= TextEditingController(
                                                              text: rideEditPageRidesNewRecord.driverNumber,
                                                            ),
                                                            focusNode: _model.driverContactnumberFocusNode,
                                                            autofocus: false,
                                                            obscureText: false,
                                                            decoration: InputDecoration(
                                                              labelText: 'Enter Contact Number',
                                                              hintText: '+91 70178 XXXXX',
                                                              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(0xFFF5F5F5),
                                                            ),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  fontSize: 16.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                            textAlign: TextAlign.start,
                                                            keyboardType: TextInputType.number,
                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                            validator: _model.driverContactnumberTextControllerValidator.asValidator(context),
                                                            inputFormatters: [_model.driverContactnumberMask],
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(SizedBox(height: 16.0)),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Vehicle Number (Optional)',
                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                          font: GoogleFonts.interTight(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                        ),
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: double.infinity,
                                                          child: TextFormField(
                                                            controller: _model.vehicleNumberTextController ??= TextEditingController(
                                                              text: rideEditPageRidesNewRecord.vehicleNumber,
                                                            ),
                                                            focusNode: _model.vehicleNumberFocusNode,
                                                            autofocus: false,
                                                            textCapitalization: TextCapitalization.characters,
                                                            obscureText: false,
                                                            decoration: InputDecoration(
                                                              labelText: 'Enter your vehicle number',
                                                              hintText: 'UP 65 ET XXXX',
                                                              hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                    ),
                                                                    letterSpacing: 0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: Color(0xFF4DABF7),
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              errorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              focusedErrorBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color: FlutterFlowTheme.of(context).error,
                                                                  width: 2.0,
                                                                ),
                                                                borderRadius: BorderRadius.circular(12.0),
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(0xFFF5F5F5),
                                                            ),
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  font: GoogleFonts.inter(
                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                  ),
                                                                  fontSize: 16.0,
                                                                  letterSpacing: 0.0,
                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                ),
                                                            textAlign: TextAlign.center,
                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                            validator: _model.vehicleNumberTextControllerValidator.asValidator(context),
                                                            inputFormatters: [
                                                              if (!isAndroid && !isiOS)
                                                                TextInputFormatter.withFunction((oldValue, newValue) {
                                                                  return TextEditingValue(
                                                                    selection: newValue.selection,
                                                                    text: newValue.text.toCapitalization(TextCapitalization.characters),
                                                                  );
                                                                }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(SizedBox(width: 16.0)),
                                                  ),
                                                ].divide(SizedBox(height: 16.0)),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if (_model.driverContactnumberTextController.text != null && _model.driverContactnumberTextController.text != '') {
                                                    await widget!.rideEdit!.update(createRidesNewRecordData(
                                                      driverNumber: _model.driverContactnumberTextController.text,
                                                      vehicleNumber: _model.vehicleNumberTextController.text,
                                                    ));
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Attention'),
                                                          content: Text('Please add Driver Number'),
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
                                                text: 'Update Now',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 40.0,
                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                  color: Color(0xFFF67E4A),
                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                        font: GoogleFonts.interTight(
                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ].divide(SizedBox(height: 15.0)),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment: ExpandablePanelHeaderAlignment.top,
                                          hasIcon: true,
                                          expandIcon: Icons.edit,
                                          collapseIcon: Icons.clear,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 14.0)),
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 45.0)),
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
