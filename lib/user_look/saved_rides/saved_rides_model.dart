import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'saved_rides_widget.dart' show SavedRidesWidget;

class SavedRidesModel extends FlutterFlowModel<SavedRidesWidget> {
  ///  Local state fields for this page.

  DateTime? pageState;

  ///  State fields for stateful widgets in this page.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  Completer<GoogleMapController> googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
