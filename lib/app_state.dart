import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isShowHeatthIcon =
          prefs.getBool('ff_isShowHeatthIcon') ?? _isShowHeatthIcon;
    });
    _safeInit(() {
      _rideCostforDetailRides = prefs.getDouble('ff_rideCostforDetailRides') ??
          _rideCostforDetailRides;
    });
    _safeInit(() {
      _GoogleStartAddress =
          prefs.getString('ff_GoogleStartAddress') ?? _GoogleStartAddress;
    });
    _safeInit(() {
      _GoogleEndAddress =
          prefs.getString('ff_GoogleEndAddress') ?? _GoogleEndAddress;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _RideStartLocaction = '';
  String get RideStartLocaction => _RideStartLocaction;
  set RideStartLocaction(String value) {
    _RideStartLocaction = value;
  }

  String _RideEndLocaction = '';
  String get RideEndLocaction => _RideEndLocaction;
  set RideEndLocaction(String value) {
    _RideEndLocaction = value;
  }

  DateTime? _pickupTime;
  DateTime? get pickupTime => _pickupTime;
  set pickupTime(DateTime? value) {
    _pickupTime = value;
  }

  DateTime? _DropTime;
  DateTime? get DropTime => _DropTime;
  set DropTime(DateTime? value) {
    _DropTime = value;
  }

  bool _isPredefinedItems = false;
  bool get isPredefinedItems => _isPredefinedItems;
  set isPredefinedItems(bool value) {
    _isPredefinedItems = value;
  }

  String _isPassengers = '';
  String get isPassengers => _isPassengers;
  set isPassengers(String value) {
    _isPassengers = value;
  }

  int _numPassengers = 0;
  int get numPassengers => _numPassengers;
  set numPassengers(int value) {
    _numPassengers = value;
  }

  int _pricePerPassengers = 0;
  int get pricePerPassengers => _pricePerPassengers;
  set pricePerPassengers(int value) {
    _pricePerPassengers = value;
  }

  int _numBagAllowed = 0;
  int get numBagAllowed => _numBagAllowed;
  set numBagAllowed(int value) {
    _numBagAllowed = value;
  }

  bool _isRiderulesAccepted = false;
  bool get isRiderulesAccepted => _isRiderulesAccepted;
  set isRiderulesAccepted(bool value) {
    _isRiderulesAccepted = value;
  }

  bool _isTermAccepted = false;
  bool get isTermAccepted => _isTermAccepted;
  set isTermAccepted(bool value) {
    _isTermAccepted = value;
  }

  String _rideRule1 = '';
  String get rideRule1 => _rideRule1;
  set rideRule1(String value) {
    _rideRule1 = value;
  }

  String _rideRule2 = '';
  String get rideRule2 => _rideRule2;
  set rideRule2(String value) {
    _rideRule2 = value;
  }

  String _rideRule3 = '';
  String get rideRule3 => _rideRule3;
  set rideRule3(String value) {
    _rideRule3 = value;
  }

  String _rideRule4 = '';
  String get rideRule4 => _rideRule4;
  set rideRule4(String value) {
    _rideRule4 = value;
  }

  String _rideRule5 = '';
  String get rideRule5 => _rideRule5;
  set rideRule5(String value) {
    _rideRule5 = value;
  }

  String _rideRule6 = '';
  String get rideRule6 => _rideRule6;
  set rideRule6(String value) {
    _rideRule6 = value;
  }

  String _rideRule7 = '';
  String get rideRule7 => _rideRule7;
  set rideRule7(String value) {
    _rideRule7 = value;
  }

  String _rideRule8 = '';
  String get rideRule8 => _rideRule8;
  set rideRule8(String value) {
    _rideRule8 = value;
  }

  String _modeOfTransport = '';
  String get modeOfTransport => _modeOfTransport;
  set modeOfTransport(String value) {
    _modeOfTransport = value;
  }

  String _travelTime = '';
  String get travelTime => _travelTime;
  set travelTime(String value) {
    _travelTime = value;
  }

  String _vehicleNumber = '';
  String get vehicleNumber => _vehicleNumber;
  set vehicleNumber(String value) {
    _vehicleNumber = value;
  }

  String _totalDelvieryCost = '';
  String get totalDelvieryCost => _totalDelvieryCost;
  set totalDelvieryCost(String value) {
    _totalDelvieryCost = value;
  }

  String _DriverNumber = '';
  String get DriverNumber => _DriverNumber;
  set DriverNumber(String value) {
    _DriverNumber = value;
  }

  String _NameoftheProducts = '';
  String get NameoftheProducts => _NameoftheProducts;
  set NameoftheProducts(String value) {
    _NameoftheProducts = value;
  }

  String _Descriptionoftheitem = '';
  String get Descriptionoftheitem => _Descriptionoftheitem;
  set Descriptionoftheitem(String value) {
    _Descriptionoftheitem = value;
  }

  String _origin = '';
  String get origin => _origin;
  set origin(String value) {
    _origin = value;
  }

  String _destination = '';
  String get destination => _destination;
  set destination(String value) {
    _destination = value;
  }

  String _price = '';
  String get price => _price;
  set price(String value) {
    _price = value;
  }

  String _quantity = '';
  String get quantity => _quantity;
  set quantity(String value) {
    _quantity = value;
  }

  List<String> _carryItemNormalRides = [];
  List<String> get carryItemNormalRides => _carryItemNormalRides;
  set carryItemNormalRides(List<String> value) {
    _carryItemNormalRides = value;
  }

  void addToCarryItemNormalRides(String value) {
    carryItemNormalRides.add(value);
  }

  void removeFromCarryItemNormalRides(String value) {
    carryItemNormalRides.remove(value);
  }

  void removeAtIndexFromCarryItemNormalRides(int index) {
    carryItemNormalRides.removeAt(index);
  }

  void updateCarryItemNormalRidesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    carryItemNormalRides[index] = updateFn(_carryItemNormalRides[index]);
  }

  void insertAtIndexInCarryItemNormalRides(int index, String value) {
    carryItemNormalRides.insert(index, value);
  }

  List<String> _stoppageNormalParcaleRide = [];
  List<String> get stoppageNormalParcaleRide => _stoppageNormalParcaleRide;
  set stoppageNormalParcaleRide(List<String> value) {
    _stoppageNormalParcaleRide = value;
  }

  void addToStoppageNormalParcaleRide(String value) {
    stoppageNormalParcaleRide.add(value);
  }

  void removeFromStoppageNormalParcaleRide(String value) {
    stoppageNormalParcaleRide.remove(value);
  }

  void removeAtIndexFromStoppageNormalParcaleRide(int index) {
    stoppageNormalParcaleRide.removeAt(index);
  }

  void updateStoppageNormalParcaleRideAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    stoppageNormalParcaleRide[index] =
        updateFn(_stoppageNormalParcaleRide[index]);
  }

  void insertAtIndexInStoppageNormalParcaleRide(int index, String value) {
    stoppageNormalParcaleRide.insert(index, value);
  }

  DateTime? _marketPlaceAriveDate;
  DateTime? get marketPlaceAriveDate => _marketPlaceAriveDate;
  set marketPlaceAriveDate(DateTime? value) {
    _marketPlaceAriveDate = value;
  }

  /// eska use hoga phone verify karte time show karene ke liye.
  int _phoneNumberAuth = 0;
  int get phoneNumberAuth => _phoneNumberAuth;
  set phoneNumberAuth(int value) {
    _phoneNumberAuth = value;
  }

  LatLng? _rideStartLocationGoogle;
  LatLng? get rideStartLocationGoogle => _rideStartLocationGoogle;
  set rideStartLocationGoogle(LatLng? value) {
    _rideStartLocationGoogle = value;
  }

  LatLng? _rideEndLocationGoogle;
  LatLng? get rideEndLocationGoogle => _rideEndLocationGoogle;
  set rideEndLocationGoogle(LatLng? value) {
    _rideEndLocationGoogle = value;
  }

  bool _isShowHeatthIcon = false;
  bool get isShowHeatthIcon => _isShowHeatthIcon;
  set isShowHeatthIcon(bool value) {
    _isShowHeatthIcon = value;
    prefs.setBool('ff_isShowHeatthIcon', value);
  }

  double _rideCostforDetailRides = 0.0;
  double get rideCostforDetailRides => _rideCostforDetailRides;
  set rideCostforDetailRides(double value) {
    _rideCostforDetailRides = value;
    prefs.setDouble('ff_rideCostforDetailRides', value);
  }

  String _GoogleStartAddress = '';
  String get GoogleStartAddress => _GoogleStartAddress;
  set GoogleStartAddress(String value) {
    _GoogleStartAddress = value;
    prefs.setString('ff_GoogleStartAddress', value);
  }

  String _GoogleEndAddress = '';
  String get GoogleEndAddress => _GoogleEndAddress;
  set GoogleEndAddress(String value) {
    _GoogleEndAddress = value;
    prefs.setString('ff_GoogleEndAddress', value);
  }

  final _idontKnowManager = StreamRequestManager<List<MarketPlaceRecord>>();
  Stream<List<MarketPlaceRecord>> idontKnow({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<MarketPlaceRecord>> Function() requestFn,
  }) =>
      _idontKnowManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearIdontKnowCache() => _idontKnowManager.clear();
  void clearIdontKnowCacheKey(String? uniqueKey) =>
      _idontKnowManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
