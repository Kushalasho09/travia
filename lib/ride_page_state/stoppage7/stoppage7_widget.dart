import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import 'stoppage7_model.dart';
export 'stoppage7_model.dart';

class Stoppage7Widget extends StatefulWidget {
  const Stoppage7Widget({super.key});

  static String routeName = 'Stoppage7';
  static String routePath = '/stoppage7';

  @override
  State<Stoppage7Widget> createState() => _Stoppage7WidgetState();
}

class _Stoppage7WidgetState extends State<Stoppage7Widget> {
  late Stoppage7Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isAutoDetecting = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Stoppage7Model());

    _model.stoppagesTextController ??= TextEditingController();
    _model.stoppagesFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_model.stoppages.isEmpty) {
        _autoDetectStoppages();
      }
    });
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> _autoDetectStoppages() async {
    String start = FFAppState().RideStartLocaction.isNotEmpty
        ? FFAppState().RideStartLocaction
        : FFAppState().GoogleStartAddress;
    String end = FFAppState().RideEndLocaction.isNotEmpty
        ? FFAppState().RideEndLocaction
        : FFAppState().GoogleEndAddress;

    if (start.trim().isEmpty || end.trim().isEmpty) return;

    safeSetState(() => _isAutoDetecting = true);

    try {
      const String apiKey = 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs';
      final directionsUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${Uri.encodeComponent(start)}&'
        'destination=${Uri.encodeComponent(end)}&'
        'alternatives=true&'
        'key=$apiKey',
      );

      final resp = await http.get(directionsUrl);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        if (data['status'] == 'OK' && (data['routes'] as List).isNotEmpty) {
          final polylineStr = data['routes'][0]['overview_polyline']?['points'] ?? '';
          if (polylineStr.isNotEmpty) {
            final points = _decodePolyline(polylineStr);
            if (points.isNotEmpty) {
              // Sample 4 intermediate points (20%, 40%, 60%, 80%) along route
              final fractions = [0.20, 0.40, 0.60, 0.80];
              final sampleIndices = fractions.map((f) => (points.length * f).toInt()).toList();

              final detected = <String>[];
              final startName = start.split(',').first.trim().toLowerCase();
              final endName = end.split(',').first.trim().toLowerCase();

              for (final idx in sampleIndices) {
                if (idx < points.length) {
                  final pt = points[idx];
                  final nearbyUrl = Uri.parse(
                    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
                    'location=${pt.latitude},${pt.longitude}&'
                    'radius=25000&'
                    'type=locality&'
                    'key=$apiKey',
                  );

                  final nResp = await http.get(nearbyUrl);
                  if (nResp.statusCode == 200) {
                    final nData = json.decode(nResp.body);
                    if (nData['results'] != null && (nData['results'] as List).isNotEmpty) {
                      final name = nData['results'][0]['name']?.toString() ?? '';
                      final lower = name.toLowerCase();
                      if (name.isNotEmpty &&
                          !detected.contains(name) &&
                          !_model.stoppages.contains(name) &&
                          !lower.contains(startName) &&
                          !lower.contains(endName) &&
                          !startName.contains(lower) &&
                          !endName.contains(lower)) {
                        detected.add(name);
                      }
                    }
                  }
                }
              }

              for (final stop in detected) {
                _model.addToStoppages(stop);
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error auto-detecting stoppages: $e');
    } finally {
      if (mounted) {
        safeSetState(() => _isAutoDetecting = false);
      }
    }
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
            'Add Ride Stoppages',
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 25.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(RideRules7Widget.routeName);
                        },
                        text: 'Skip',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0x1F4CAF50),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).success,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).success,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Text(
                      'Add or auto-detect cities along your route',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.interTight(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: CircularPercentIndicator(
                      percent: 0.7,
                      radius: 60.0,
                      lineWidth: 12.0,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: Color(0xFFF57C3B),
                      backgroundColor: Color(0xFFD8D5D5),
                      center: Text(
                        '70%',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
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
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 32.0),
                      child: Builder(
                        builder: (context) {
                          final itemsList = _model.stoppages.toList();

                          return Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            clipBehavior: Clip.none,
                            children: List.generate(itemsList.length,
                                (itemsListIndex) {
                              final itemsListItem = itemsList[itemsListIndex];
                              return Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: const Color(0xFF93C5FD),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      14.0, 6.0, 10.0, 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        itemsListItem,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              color: const Color(0xFF1E293B),
                                              fontSize: 13.5,
                                            ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      InkWell(
                                        onTap: () {
                                          _model.removeFromStoppages(itemsListItem);
                                          safeSetState(() {});
                                        },
                                        child: const Icon(
                                          Icons.cancel_rounded,
                                          size: 18.0,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),

                  // Auto-Detect Route Stoppages Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: InkWell(
                      onTap: _isAutoDetecting ? null : _autoDetectStoppages,
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: const Color(0xFF93C5FD), width: 1.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isAutoDetecting)
                              const SizedBox(
                                width: 16.0,
                                height: 16.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Color(0xFF2563EB),
                                ),
                              )
                            else
                              const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF2563EB),
                                size: 18.0,
                              ),
                            const SizedBox(width: 8.0),
                            Text(
                              _isAutoDetecting
                                  ? 'Auto-detecting route cities...'
                                  : 'Auto-Detect Route Cities',
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2563EB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),

                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 250.0,
                        child: GooglePlaceAutoCompleteTextField(
                          focusNode: _model.stoppagesFocusNode,
                          textEditingController: _model.stoppagesTextController!,
                          googleAPIKey: "AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs",
                          inputDecoration: InputDecoration(
                            isDense: true,
                            hintText: 'Add stop name / location',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF4DABF7),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          debounceTime: 600,
                          isLatLngRequired: false,
                          getPlaceDetailWithLatLng: (prediction) {},
                          itemClick: (prediction) {
                            final text = prediction.description ?? "";
                            if (text.isNotEmpty) {
                              _model.addToStoppages(text);
                              safeSetState(() {});
                              safeSetState(() {
                                _model.stoppagesTextController?.clear();
                              });
                            }
                          },
                          itemBuilder: (context, index, prediction) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 18.0, color: Color(0xFF4DABF7)),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Text(
                                      prediction.description ?? "",
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          seperatedBuilder: Divider(height: 1.0, thickness: 0.5),
                          isCrossBtnShown: true,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (_model.stoppagesTextController.text != null &&
                              _model.stoppagesTextController.text != '') {
                            _model.addToStoppages(
                                _model.stoppagesTextController.text);
                            safeSetState(() {});
                            safeSetState(() {
                              _model.stoppagesTextController?.clear();
                            });
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Attention Required '),
                                  content: Text('Please add stoppages of ride'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Icon(
                          Icons.add_circle,
                          color: Color(0xFFF57C3B),
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 16.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        FFAppState().stoppageNormalParcaleRide =
                            _model.stoppages.toList().cast<String>();
                        safeSetState(() {});
                        safeSetState(() {
                          _model.stoppagesTextController?.clear();
                        });

                        context.pushNamed(RideRules7Widget.routeName);
                      },
                      text: _model.stoppages.isNotEmpty
                          ? 'Continue with ${_model.stoppages.length} Stop${_model.stoppages.length > 1 ? 's' : ''}'
                          : 'Continue to Ride Rules',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: EdgeInsets.all(8.0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFFF67E4A),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).info,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                        elevation: 2.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
