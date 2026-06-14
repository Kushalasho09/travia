import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

void main() {
  final prediction = Prediction();
  print('Prediction properties:');
  try {
    print('lat: ${prediction.lat}');
    print('lng: ${prediction.lng}');
  } catch (e) {
    print('Error: $e');
  }
}
