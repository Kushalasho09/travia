import 'package:travia/backend/schema/rides_new_record.dart';

import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'transport_mode4_model.dart';
export 'transport_mode4_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class TransportMode4Widget extends StatefulWidget {
  const TransportMode4Widget({super.key});

  static String routeName = 'transportMode4';
  static String routePath = '/transportMode4';

  @override
  State<TransportMode4Widget> createState() => _TransportMode4WidgetState();
}

class _TransportMode4WidgetState extends State<TransportMode4Widget> {
  late TransportMode4Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TransportMode4Model());
    // Get travel time on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTravelTime();
    });

  }

// Updated _getTravelTime with precise null checks
  Future<void> _getTravelTime() async {
    try {
      String startLocation = FFAppState().RideStartLocaction ?? '';
      String endLocation = FFAppState().RideEndLocaction ?? '';

      print('Ride Start: $startLocation');
      print('Ride End: $endLocation');

      if (startLocation.isEmpty || endLocation.isEmpty) {
        _model.travelTime = 'Locations not available';
        safeSetState(() {});
        return;
      }

      String mode = _model.transportModeValue ?? 'car';
      String result = await _calculateTravelTime(startLocation, endLocation, mode);

      print('Travel Time ($mode): $result');
      _model.travelTime = result;
      safeSetState(() {});

    } catch (e) {
      print('Error getting travel time: $e');
      _model.travelTime = 'Error calculating';
      safeSetState(() {});
    }
  }

  Future<String> _calculateTravelTime(String origin, String destination, String mode) async {
    const String apiKey = 'AIzaSyDZkxRpoy0BOIAPwMaMIvAd5xpCe-6ZYvs';
    String travelMode = _getGoogleTravelMode(mode);

    print('Calculating $mode ($travelMode): $origin → $destination');

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?'
            'origin=${Uri.encodeComponent(origin)}&'
            'destination=${Uri.encodeComponent(destination)}&'
            'mode=$travelMode&'
            'departure_time=now&'  // Real-time traffic
            'traffic_model=best_guess&'  // Precise traffic
            'key=$apiKey'
    );

    final response = await http.get(url);

    print('API Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response Status: ${data['status']}');

      // Handle different API responses
      if (data['status'] == 'OK' && data['routes']?.isNotEmpty == true) {
        String durationText = data['routes'][0]['legs'][0]['duration']['text'];
        String distanceText = data['routes'][0]['legs'][0]['distance']['text'];
        return '$durationText ($distanceText)';
      }
      else if (data['status'] == 'ZERO_RESULTS') {
        print('❌ No routes found for $travelMode');
        return 'No routes available';
      }
      else {
        print('❌ API Error: ${data['status']}');
        return 'Service unavailable';
      }
    } else {
      print('❌ HTTP Error: ${response.statusCode}');
      return 'Network error';
    }
  }

  String _getGoogleTravelMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'car':   return 'driving';
      case 'bike':  return 'bicycling';
      case 'bus':   return 'transit';
      case 'train': return 'transit';
      default:      return 'driving';
    }
  }


  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
            'Mode of Transport',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 20.0,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                          child: CircularPercentIndicator(
                            percent: 0.4,
                            radius: 60.0,
                            lineWidth: 12.0,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: Color(0xFFF57C3B),
                            backgroundColor: Color(0xFFD8D5D5),
                            center: Text(
                              '40%',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Mode of transport',
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
                              FlutterFlowDropDown<String>(
                                controller: _model.transportModeValueController ??= FormFieldController<String>(
                                  _model.transportModeValue ??= FFAppState().modeOfTransport,
                                ),
                                options: ['Car', 'Bike', 'Bus', 'Train'],
                                onChanged: (val) async {
                                  _model.transportModeValue = val;
                                  _model.isCalculatingTime = true;  // Show loader
                                  _model.travelTime = null;         // Clear previous result
                                  safeSetState(() {});

                                  if (val != null && val.isNotEmpty) {
                                    await _getTravelTime();
                                  } else {
                                    _model.travelTime = null;
                                  }

                                  _model.isCalculatingTime = false;  // Hide loader
                                  safeSetState(() {});
                                },
                                width: 401.3,
                                height: 59.22,
                                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                ),
                                hintText: 'Select...',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                elevation: 2.0,
                                borderColor: Color(0xFF4DABF7),
                                borderWidth: 2.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              ),

                              // LOADING STATE - Show while calculating
                              if (_model.isCalculatingTime)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                  child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.blue, width: 1.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'Calculating travel time...',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              // SUCCESS STATE - Show precise time + distance with arrival time
                              if (!_model.isCalculatingTime &&
                                  _model.transportModeValue != null &&
                                  _model.transportModeValue!.isNotEmpty &&
                                  _model.travelTime != null &&
                                  !_model.travelTime!.contains('N/A') &&
                                  !_model.travelTime!.contains('Check API Key') &&
                                  !_model.travelTime!.contains('Error') &&
                                  !_model.travelTime!.contains('Service') &&
                                  !_model.travelTime!.contains('Network'))

                              // Calculate arrival time inline
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      // Calculate arrival time here using FFAppState
                                      DateTime? arrivalDateTime;
                                      if (FFAppState().pickupTime != null && _model.travelTime != null) {
                                        String travelTimeStr = _model.travelTime!;
                                        int totalMinutes = 0;

                                        // Parse travel time string (handles formats like "25 mins", "1 hour 25 mins", "1.5 hours", etc.)
                                        RegExp minutesRegExp = RegExp(r'(\d+)\s*mins?');
                                        RegExp hoursRegExp = RegExp(r'(\d+)\s*hours?');
                                        RegExp decimalHoursRegExp = RegExp(r'(\d+\.?\d*)\s*hours?');

                                        // Check for decimal hours first (e.g., "1.5 hours")
                                        final decimalHoursMatch = decimalHoursRegExp.firstMatch(travelTimeStr);
                                        if (decimalHoursMatch != null) {
                                          double hours = double.parse(decimalHoursMatch.group(1)!);
                                          totalMinutes += (hours * 60).round();
                                        } else {
                                          // Check for hours
                                          final hoursMatch = hoursRegExp.firstMatch(travelTimeStr);
                                          if (hoursMatch != null) {
                                            totalMinutes += int.parse(hoursMatch.group(1)!) * 60;
                                          }

                                          // Check for minutes
                                          final minutesMatch = minutesRegExp.firstMatch(travelTimeStr);
                                          if (minutesMatch != null) {
                                            totalMinutes += int.parse(minutesMatch.group(1)!);
                                          }
                                        }

                                        // If no hours/minutes found, try to parse just numbers
                                        if (totalMinutes == 0) {
                                          RegExp numberRegExp = RegExp(r'(\d+)');
                                          final numberMatch = numberRegExp.firstMatch(travelTimeStr);
                                          if (numberMatch != null) {
                                            totalMinutes = int.parse(numberMatch.group(1)!);
                                          }
                                        }

                                        arrivalDateTime = FFAppState().pickupTime!.add(Duration(minutes: totalMinutes));
                                      }

                                      // Beautiful UI container with arrival time
                                      return Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.green.withOpacity(0.1),
                                              Colors.green.withOpacity(0.05),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Colors.green.withOpacity(0.3),
                                            width: 1.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.green.withOpacity(0.1),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Header with mode and duration
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(12.0),
                                                    ),
                                                    child: Icon(
                                                      _model.transportModeValue == 'Car' || _model.transportModeValue == 'driving'
                                                          ? Icons.directions_car
                                                          : _model.transportModeValue == 'Bike' || _model.transportModeValue == 'bicycling'
                                                          ? Icons.directions_bike
                                                          : _model.transportModeValue == 'Bus'
                                                          ? Icons.directions_bus
                                                          : _model.transportModeValue == 'Train'
                                                          ? Icons.directions_train
                                                          : Icons.directions_transit,
                                                      color: Colors.green[700],
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Trip Duration',
                                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                            color: Colors.green[700],
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          _model.travelTime!,
                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                            color: Colors.green[800],
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Mode badge
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(20.0),
                                                    ),
                                                    child: Text(
                                                      _model.transportModeValue!.toUpperCase(),
                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 16.0),

                                              // Divider with time icon
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Divider(
                                                      color: Colors.green.withOpacity(0.3),
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                    child: Icon(
                                                      Icons.access_time_filled,
                                                      color: Colors.green[600],
                                                      size: 18.0,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Divider(
                                                      color: Colors.green.withOpacity(0.3),
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 12.0),

                                              // Departure and Arrival times
                                              Row(
                                                children: [
                                                  // Departure time
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.all(12.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.5),
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        border: Border.all(
                                                          color: Colors.green.withOpacity(0.2),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.radio_button_unchecked,
                                                          //   color: Colors.green[600],
                                                          //   size: 20.0,
                                                          // ),
                                                          SizedBox(height: 4.0),
                                                          Text(
                                                            'Departure',
                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                              color: Colors.grey[600],
                                                              fontSize: 11.0,
                                                            ),
                                                          ),
                                                          SizedBox(height: 2.0),
                                                          Text(
                                                            FFAppState().pickupTime != null
                                                                ? dateTimeFormat('jm', FFAppState().pickupTime)
                                                                : '--:--',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              color: Colors.green[800],
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          if (FFAppState().pickupTime != null)
                                                            Text(
                                                              dateTimeFormat('yMMMd', FFAppState().pickupTime),
                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                color: Colors.grey[600],
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(width: 8.0),

                                                  // Arrow icon
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green.withOpacity(0.1),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.green[600],
                                                      size: 16.0,
                                                    ),
                                                  ),

                                                  SizedBox(width: 8.0),

                                                  // Arrival time
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.all(12.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.green.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(12.0),
                                                        border: Border.all(
                                                          color: Colors.green.withOpacity(0.3),
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          // Icon(
                                                          //   Icons.flight_land,
                                                          //   color: Colors.green[700],
                                                          //   size: 20.0,
                                                          // ),
                                                          SizedBox(height: 4.0),
                                                          Text(
                                                            'Arrival',
                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                              color: Colors.green[700],
                                                              fontSize: 11.0,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          SizedBox(height: 2.0),
                                                          Text(
                                                            arrivalDateTime != null
                                                                ? dateTimeFormat('jm', arrivalDateTime)
                                                                : '--:--',
                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                              color: Colors.green[800],
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14.0,
                                                            ),
                                                          ),
                                                          if (arrivalDateTime != null)
                                                            Text(
                                                              dateTimeFormat('yMMMd', arrivalDateTime),
                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                color: Colors.grey[600],
                                                                fontSize: 10.0,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // Show date change warning if arrival is next day
                                              if (arrivalDateTime != null &&
                                                  FFAppState().pickupTime != null &&
                                                  arrivalDateTime.day != FFAppState().pickupTime!.day)
                                                Padding(
                                                  padding: EdgeInsets.only(top: 12.0),
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      border: Border.all(color: Colors.amber, width: 1.0),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.wb_twilight,
                                                          color: Colors.amber[700],
                                                          size: 16.0,
                                                        ),
                                                        SizedBox(width: 8.0),
                                                        Expanded(
                                                          child: Text(
                                                            arrivalDateTime.day == FFAppState().pickupTime!.day + 1
                                                                ? 'Arrives next day'
                                                                : 'Arrives on ${dateTimeFormat('yMMMd', arrivalDateTime)}',
                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                              color: Colors.amber[800],
                                                              fontWeight: FontWeight.w500,
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
                                      );
                                    },
                                  ),
                                ),                              // NO ROUTES / ERROR STATE - Show clear message
                              if (!_model.isCalculatingTime &&
                                  _model.transportModeValue != null &&
                                  _model.transportModeValue!.isNotEmpty &&
                                  _model.travelTime != null &&
                                  (_model.travelTime!.contains('No routes available') ||
                                      _model.travelTime!.contains('N/A') ||
                                      _model.travelTime!.contains('Check API Key') ||
                                      _model.travelTime!.contains('Error') ||
                                      _model.travelTime!.contains('Service') ||
                                      _model.travelTime!.contains('Network')))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                                  child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.orange, width: 1.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20.0),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            _model.travelTime == 'No routes available'
                                                ? 'No routes available for ${_model.transportModeValue}'
                                                : _model.travelTime!,
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              color: Colors.orange[800],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 30.0, 24.0, 24.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (_model.transportModeValue != null && _model.transportModeValue != '') {
                        await _getTravelTime();

                        // ✅ SAVE TO PREFS
                        FFAppState().modeOfTransport = _model.transportModeValue!;
                        FFAppState().travelTime = _model.travelTime ?? '';
                        safeSetState(() {});

                        if (_model.transportModeValue == 'Car' ||
                            _model.transportModeValue == 'Bike') {
                          context.pushNamed(CaryItems5Widget.routeName);
                        } else {
                          context.pushNamed(CaryItems5Widget.routeName);
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) => AlertDialog(
                            title: Text('Attention'),
                            content: Text('Please Select Any Mode of Transport'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
