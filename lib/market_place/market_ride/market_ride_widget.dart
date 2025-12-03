import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

    _model.nameoftheProductsTextController ??= TextEditingController();
    _model.nameoftheProductsFocusNode ??= FocusNode();

    _model.originTextController ??= TextEditingController();
    _model.originFocusNode ??= FocusNode();

    _model.destinationTextController ??= TextEditingController();
    _model.destinationFocusNode ??= FocusNode();
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
          backgroundColor: Color(0xFFF4F4F4),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 18.0,
            buttonSize: 40.0,
            icon: FaIcon(
              FontAwesomeIcons.bars,
              color: Color(0xFF283B5E),
              size: 27.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/logoTraviaJi.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(PlansWidget.routeName);
                        },
                        child: CircleAvatar(

                          radius: 20, // adjust size
                          backgroundColor: Color(0xFF283B5E), // circle color
                          child: Padding(
                            padding: const EdgeInsets.only(right:2),
                            child: Icon(
                              FontAwesomeIcons.crown,
                              color: Colors.white, // icon color
                              size: 18.0,
                            ),
                          ),
                        )

                    ),

                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   image: Image.asset(
                          //     "assets/images/profileIcon.png",
                          //   ).image,
                          // ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF283B5E),
                            width: 1.0,
                          ),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(DriveProfileWidget.routeName);
                          },
                          child: Builder(
                            builder: (context) {
                              if (currentUserPhoto != null && currentUserPhoto != '') {
                                return Container(
                                  width: 200.0,
                                  height: 200.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    currentUserPhoto,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 200.0,
                                  height: 200.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/userIconTravia.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 5.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        primary: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Name of the Products',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w600,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .nameoftheProductsTextController,
                                          focusNode: _model
                                              .nameoftheProductsFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText:
                                            'Like, Fresh strawberrys from Rishikesh',
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF4DABF7),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF5F5F5),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          validator: _model
                                              .nameoftheProductsTextControllerValidator
                                              .asValidator(context),
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
                                  'Origin',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w600,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller:
                                          _model.originTextController,
                                          focusNode: _model.originFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Like, From Rishikesh',
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF4DABF7),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF5F5F5),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          validator: _model
                                              .originTextControllerValidator
                                              .asValidator(context),
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
                                  'Destination',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w600,
                                      fontStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _model
                                              .destinationTextController,
                                          focusNode:
                                          _model.destinationFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Like, From Agra',
                                            hintStyle:
                                            FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontWeight,
                                                fontStyle:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF4DABF7),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(12.0),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFF5F5F5),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .fontStyle,
                                            ),
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(
                                                context)
                                                .bodyMedium
                                                .fontStyle,
                                          ),
                                          textAlign: TextAlign.start,
                                          cursorColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          validator: _model
                                              .destinationTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 16.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                            if ((_model.nameoftheProductsTextController
                                .text !=
                                null &&
                                _model.nameoftheProductsTextController
                                    .text !=
                                    '') &&
                                (_model.originTextController.text != null &&
                                    _model.originTextController.text != '') &&
                                (_model.destinationTextController.text !=
                                    null &&
                                    _model.destinationTextController.text !=
                                        ''))
                              Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 30.0, 24.0, 24.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if ((_model.nameoftheProductsTextController
                                          .text !=
                                          null &&
                                          _model.nameoftheProductsTextController
                                              .text !=
                                              '') &&
                                          (_model.originTextController.text !=
                                              null &&
                                              _model.originTextController
                                                  .text !=
                                                  '') &&
                                          (_model.destinationTextController
                                              .text !=
                                              null &&
                                              _model.destinationTextController
                                                  .text !=
                                                  '')) {
                                        FFAppState().NameoftheProducts = _model
                                            .nameoftheProductsTextController
                                            .text;
                                        FFAppState().origin =
                                            _model.originTextController.text;
                                        FFAppState().destination = _model
                                            .destinationTextController.text;
                                        safeSetState(() {});

                                        context.pushNamed(
                                            MarketRide2Widget.routeName);
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('Attention'),
                                              content: Text(
                                                  'Please fill all details before proceed'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('Ok'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF8C00),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Align(
                                        alignment:
                                        AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ].divide(SizedBox(height: 45.0)),
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
    );
  }
}
