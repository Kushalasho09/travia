import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RidesNewRecord extends FirestoreRecord {
  RidesNewRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "RideStartLocation" field.
  String? _rideStartLocation;
  String get rideStartLocation => _rideStartLocation ?? '';
  bool hasRideStartLocation() => _rideStartLocation != null;

  // "RideEndLocation" field.
  String? _rideEndLocation;
  String get rideEndLocation => _rideEndLocation ?? '';
  bool hasRideEndLocation() => _rideEndLocation != null;

  // "pickupTime" field.
  DateTime? _pickupTime;
  DateTime? get pickupTime => _pickupTime;
  bool hasPickupTime() => _pickupTime != null;

  // "DropTime" field.
  DateTime? _dropTime;
  DateTime? get dropTime => _dropTime;
  bool hasDropTime() => _dropTime != null;

  // "isPredefinedItems" field.
  bool? _isPredefinedItems;
  bool get isPredefinedItems => _isPredefinedItems ?? false;
  bool hasIsPredefinedItems() => _isPredefinedItems != null;

  // "numPassengers" field.
  int? _numPassengers;
  int get numPassengers => _numPassengers ?? 0;
  bool hasNumPassengers() => _numPassengers != null;

  // "pricePerPassengers" field.
  int? _pricePerPassengers;
  int get pricePerPassengers => _pricePerPassengers ?? 0;
  bool hasPricePerPassengers() => _pricePerPassengers != null;

  // "numBagAllowed" field.
  int? _numBagAllowed;
  int get numBagAllowed => _numBagAllowed ?? 0;
  bool hasNumBagAllowed() => _numBagAllowed != null;

  // "rideRule1" field.
  String? _rideRule1;
  String get rideRule1 => _rideRule1 ?? '';
  bool hasRideRule1() => _rideRule1 != null;

  // "rideRule2" field.
  String? _rideRule2;
  String get rideRule2 => _rideRule2 ?? '';
  bool hasRideRule2() => _rideRule2 != null;

  // "rideRule3" field.
  String? _rideRule3;
  String get rideRule3 => _rideRule3 ?? '';
  bool hasRideRule3() => _rideRule3 != null;

  // "rideRule4" field.
  String? _rideRule4;
  String get rideRule4 => _rideRule4 ?? '';
  bool hasRideRule4() => _rideRule4 != null;

  // "rideRule5" field.
  String? _rideRule5;
  String get rideRule5 => _rideRule5 ?? '';
  bool hasRideRule5() => _rideRule5 != null;

  // "rideRule6" field.
  String? _rideRule6;
  String get rideRule6 => _rideRule6 ?? '';
  bool hasRideRule6() => _rideRule6 != null;

  // "isTermAccepted" field.
  bool? _isTermAccepted;
  bool get isTermAccepted => _isTermAccepted ?? false;
  bool hasIsTermAccepted() => _isTermAccepted != null;

  // "modeOfTransport" field.
  String? _modeOfTransport;
  String get modeOfTransport => _modeOfTransport ?? '';
  bool hasModeOfTransport() => _modeOfTransport != null;

  // "travelTime" field.
  String? _travelTime;
  String get travelTime => _travelTime ?? '';
  bool hasTravelTime() => _travelTime != null;

  // "vehicleNumber" field.
  String? _vehicleNumber;
  String get vehicleNumber => _vehicleNumber ?? '';
  bool hasVehicleNumber() => _vehicleNumber != null;

  // "totalDeliveryCost" field.
  String? _totalDeliveryCost;
  String get totalDeliveryCost => _totalDeliveryCost ?? '';
  bool hasTotalDeliveryCost() => _totalDeliveryCost != null;

  // "driverNumber" field.
  String? _driverNumber;
  String get driverNumber => _driverNumber ?? '';
  bool hasDriverNumber() => _driverNumber != null;

  // "creatorID" field.
  DocumentReference? _creatorID;
  DocumentReference? get creatorID => _creatorID;
  bool hasCreatorID() => _creatorID != null;

  // "bidCustomerID" field.
  DocumentReference? _bidCustomerID;
  DocumentReference? get bidCustomerID => _bidCustomerID;
  bool hasBidCustomerID() => _bidCustomerID != null;

  // "isRideApproved" field.
  bool? _isRideApproved;
  bool get isRideApproved => _isRideApproved ?? false;
  bool hasIsRideApproved() => _isRideApproved != null;

  // "isRideRejected" field.
  bool? _isRideRejected;
  bool get isRideRejected => _isRideRejected ?? false;
  bool hasIsRideRejected() => _isRideRejected != null;

  // "rideID" field.
  String? _rideID;
  String get rideID => _rideID ?? '';
  bool hasRideID() => _rideID != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "pickLocationMap" field.
  LatLng? _pickLocationMap;
  LatLng? get pickLocationMap => _pickLocationMap;
  bool hasPickLocationMap() => _pickLocationMap != null;

  // "caryyItems" field.
  List<String>? _caryyItems;
  List<String> get caryyItems => _caryyItems ?? const [];
  bool hasCaryyItems() => _caryyItems != null;

  // "stoppages" field.
  List<String>? _stoppages;
  List<String> get stoppages => _stoppages ?? const [];
  bool hasStoppages() => _stoppages != null;

  // "rejectResoan" field.
  String? _rejectResoan;
  String get rejectResoan => _rejectResoan ?? '';
  bool hasRejectResoan() => _rejectResoan != null;

  // "rideStatus" field.
  String? _rideStatus;
  String get rideStatus => _rideStatus ?? '';
  bool hasRideStatus() => _rideStatus != null;

  // "bookingsID" field.
  DocumentReference? _bookingsID;
  DocumentReference? get bookingsID => _bookingsID;
  bool hasBookingsID() => _bookingsID != null;

  // "isPassangerAllowedinCar" field.
  String? _isPassangerAllowedinCar;
  String get isPassangerAllowedinCar => _isPassangerAllowedinCar ?? '';
  bool hasIsPassangerAllowedinCar() => _isPassangerAllowedinCar != null;

  // "isRideRulesAccepted" field.
  bool? _isRideRulesAccepted;
  bool get isRideRulesAccepted => _isRideRulesAccepted ?? false;
  bool hasIsRideRulesAccepted() => _isRideRulesAccepted != null;

  // "rideStartLocationGoogle" field.
  LatLng? _rideStartLocationGoogle;
  LatLng? get rideStartLocationGoogle => _rideStartLocationGoogle;
  bool hasRideStartLocationGoogle() => _rideStartLocationGoogle != null;

  // "rideEndLocationGoogle" field.
  LatLng? _rideEndLocationGoogle;
  LatLng? get rideEndLocationGoogle => _rideEndLocationGoogle;
  bool hasRideEndLocationGoogle() => _rideEndLocationGoogle != null;

  // "rideSavedByUser" field.
  DocumentReference? _rideSavedByUser;
  DocumentReference? get rideSavedByUser => _rideSavedByUser;
  bool hasRideSavedByUser() => _rideSavedByUser != null;

  // "rideCost" field.
  double? _rideCost;
  double get rideCost => _rideCost ?? 0.0;
  bool hasRideCost() => _rideCost != null;

  // "googleStartAddress" field.
  String? _googleStartAddress;
  String get googleStartAddress => _googleStartAddress ?? '';
  bool hasGoogleStartAddress() => _googleStartAddress != null;

  // "googleEndAddress" field.
  String? _googleEndAddress;
  String get googleEndAddress => _googleEndAddress ?? '';
  bool hasGoogleEndAddress() => _googleEndAddress != null;

  void _initializeFields() {
    _rideStartLocation = snapshotData['RideStartLocation'] as String?;
    _rideEndLocation = snapshotData['RideEndLocation'] as String?;
    _pickupTime = snapshotData['pickupTime'] as DateTime?;
    _dropTime = snapshotData['DropTime'] as DateTime?;
    _isPredefinedItems = snapshotData['isPredefinedItems'] as bool?;
    _numPassengers = castToType<int>(snapshotData['numPassengers']);
    _pricePerPassengers = castToType<int>(snapshotData['pricePerPassengers']);
    _numBagAllowed = castToType<int>(snapshotData['numBagAllowed']);
    _rideRule1 = snapshotData['rideRule1'] as String?;
    _rideRule2 = snapshotData['rideRule2'] as String?;
    _rideRule3 = snapshotData['rideRule3'] as String?;
    _rideRule4 = snapshotData['rideRule4'] as String?;
    _rideRule5 = snapshotData['rideRule5'] as String?;
    _rideRule6 = snapshotData['rideRule6'] as String?;
    _isTermAccepted = snapshotData['isTermAccepted'] as bool?;
    _modeOfTransport = snapshotData['modeOfTransport'] as String?;
    _travelTime = snapshotData['travelTime'] as String?;
    _vehicleNumber = snapshotData['vehicleNumber'] as String?;
    _totalDeliveryCost = snapshotData['totalDeliveryCost'] as String?;
    _driverNumber = snapshotData['driverNumber'] as String?;
    _creatorID = snapshotData['creatorID'] as DocumentReference?;
    _bidCustomerID = snapshotData['bidCustomerID'] as DocumentReference?;
    _isRideApproved = snapshotData['isRideApproved'] as bool?;
    _isRideRejected = snapshotData['isRideRejected'] as bool?;
    _rideID = snapshotData['rideID'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _pickLocationMap = snapshotData['pickLocationMap'] as LatLng?;
    _caryyItems = getDataList(snapshotData['caryyItems']);
    _stoppages = getDataList(snapshotData['stoppages']);
    _rejectResoan = snapshotData['rejectResoan'] as String?;
    _rideStatus = snapshotData['rideStatus'] as String?;
    _bookingsID = snapshotData['bookingsID'] as DocumentReference?;
    _isPassangerAllowedinCar =
        snapshotData['isPassangerAllowedinCar'] as String?;
    _isRideRulesAccepted = snapshotData['isRideRulesAccepted'] as bool?;
    _rideStartLocationGoogle =
        snapshotData['rideStartLocationGoogle'] as LatLng?;
    _rideEndLocationGoogle = snapshotData['rideEndLocationGoogle'] as LatLng?;
    _rideSavedByUser = snapshotData['rideSavedByUser'] as DocumentReference?;
    _rideCost = castToType<double>(snapshotData['rideCost']);
    _googleStartAddress = snapshotData['googleStartAddress'] as String?;
    _googleEndAddress = snapshotData['googleEndAddress'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('RidesNew');

  static Stream<RidesNewRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RidesNewRecord.fromSnapshot(s));

  static Future<RidesNewRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RidesNewRecord.fromSnapshot(s));

  static RidesNewRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RidesNewRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RidesNewRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RidesNewRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RidesNewRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RidesNewRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRidesNewRecordData({
  String? rideStartLocation,
  String? rideEndLocation,
  DateTime? pickupTime,
  DateTime? dropTime,
  bool? isPredefinedItems,
  int? numPassengers,
  int? pricePerPassengers,
  int? numBagAllowed,
  String? rideRule1,
  String? rideRule2,
  String? rideRule3,
  String? rideRule4,
  String? rideRule5,
  String? rideRule6,
  bool? isTermAccepted,
  String? modeOfTransport,
  String? travelTime,
  String? vehicleNumber,
  String? totalDeliveryCost,
  String? driverNumber,
  DocumentReference? creatorID,
  DocumentReference? bidCustomerID,
  bool? isRideApproved,
  bool? isRideRejected,
  String? rideID,
  DateTime? createdTime,
  LatLng? pickLocationMap,
  String? rejectResoan,
  String? rideStatus,
  DocumentReference? bookingsID,
  String? isPassangerAllowedinCar,
  bool? isRideRulesAccepted,
  LatLng? rideStartLocationGoogle,
  LatLng? rideEndLocationGoogle,
  DocumentReference? rideSavedByUser,
  double? rideCost,
  String? googleStartAddress,
  String? googleEndAddress,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'RideStartLocation': rideStartLocation,
      'RideEndLocation': rideEndLocation,
      'pickupTime': pickupTime,
      'DropTime': dropTime,
      'isPredefinedItems': isPredefinedItems,
      'numPassengers': numPassengers,
      'pricePerPassengers': pricePerPassengers,
      'numBagAllowed': numBagAllowed,
      'rideRule1': rideRule1,
      'rideRule2': rideRule2,
      'rideRule3': rideRule3,
      'rideRule4': rideRule4,
      'rideRule5': rideRule5,
      'rideRule6': rideRule6,
      'isTermAccepted': isTermAccepted,
      'modeOfTransport': modeOfTransport,
      'travelTime': travelTime,
      'vehicleNumber': vehicleNumber,
      'totalDeliveryCost': totalDeliveryCost,
      'driverNumber': driverNumber,
      'creatorID': creatorID,
      'bidCustomerID': bidCustomerID,
      'isRideApproved': isRideApproved,
      'isRideRejected': isRideRejected,
      'rideID': rideID,
      'createdTime': createdTime,
      'pickLocationMap': pickLocationMap,
      'rejectResoan': rejectResoan,
      'rideStatus': rideStatus,
      'bookingsID': bookingsID,
      'isPassangerAllowedinCar': isPassangerAllowedinCar,
      'isRideRulesAccepted': isRideRulesAccepted,
      'rideStartLocationGoogle': rideStartLocationGoogle,
      'rideEndLocationGoogle': rideEndLocationGoogle,
      'rideSavedByUser': rideSavedByUser,
      'rideCost': rideCost,
      'googleStartAddress': googleStartAddress,
      'googleEndAddress': googleEndAddress,
    }.withoutNulls,
  );

  return firestoreData;
}

class RidesNewRecordDocumentEquality implements Equality<RidesNewRecord> {
  const RidesNewRecordDocumentEquality();

  @override
  bool equals(RidesNewRecord? e1, RidesNewRecord? e2) {
    const listEquality = ListEquality();
    return e1?.rideStartLocation == e2?.rideStartLocation &&
        e1?.rideEndLocation == e2?.rideEndLocation &&
        e1?.pickupTime == e2?.pickupTime &&
        e1?.dropTime == e2?.dropTime &&
        e1?.isPredefinedItems == e2?.isPredefinedItems &&
        e1?.numPassengers == e2?.numPassengers &&
        e1?.pricePerPassengers == e2?.pricePerPassengers &&
        e1?.numBagAllowed == e2?.numBagAllowed &&
        e1?.rideRule1 == e2?.rideRule1 &&
        e1?.rideRule2 == e2?.rideRule2 &&
        e1?.rideRule3 == e2?.rideRule3 &&
        e1?.rideRule4 == e2?.rideRule4 &&
        e1?.rideRule5 == e2?.rideRule5 &&
        e1?.rideRule6 == e2?.rideRule6 &&
        e1?.isTermAccepted == e2?.isTermAccepted &&
        e1?.modeOfTransport == e2?.modeOfTransport &&
        e1?.travelTime == e2?.travelTime &&
        e1?.vehicleNumber == e2?.vehicleNumber &&
        e1?.totalDeliveryCost == e2?.totalDeliveryCost &&
        e1?.driverNumber == e2?.driverNumber &&
        e1?.creatorID == e2?.creatorID &&
        e1?.bidCustomerID == e2?.bidCustomerID &&
        e1?.isRideApproved == e2?.isRideApproved &&
        e1?.isRideRejected == e2?.isRideRejected &&
        e1?.rideID == e2?.rideID &&
        e1?.createdTime == e2?.createdTime &&
        e1?.pickLocationMap == e2?.pickLocationMap &&
        listEquality.equals(e1?.caryyItems, e2?.caryyItems) &&
        listEquality.equals(e1?.stoppages, e2?.stoppages) &&
        e1?.rejectResoan == e2?.rejectResoan &&
        e1?.rideStatus == e2?.rideStatus &&
        e1?.bookingsID == e2?.bookingsID &&
        e1?.isPassangerAllowedinCar == e2?.isPassangerAllowedinCar &&
        e1?.isRideRulesAccepted == e2?.isRideRulesAccepted &&
        e1?.rideStartLocationGoogle == e2?.rideStartLocationGoogle &&
        e1?.rideEndLocationGoogle == e2?.rideEndLocationGoogle &&
        e1?.rideSavedByUser == e2?.rideSavedByUser &&
        e1?.rideCost == e2?.rideCost &&
        e1?.googleStartAddress == e2?.googleStartAddress &&
        e1?.googleEndAddress == e2?.googleEndAddress;
  }

  @override
  int hash(RidesNewRecord? e) => const ListEquality().hash([
        e?.rideStartLocation,
        e?.rideEndLocation,
        e?.pickupTime,
        e?.dropTime,
        e?.isPredefinedItems,
        e?.numPassengers,
        e?.pricePerPassengers,
        e?.numBagAllowed,
        e?.rideRule1,
        e?.rideRule2,
        e?.rideRule3,
        e?.rideRule4,
        e?.rideRule5,
        e?.rideRule6,
        e?.isTermAccepted,
        e?.modeOfTransport,
        e?.travelTime,
        e?.vehicleNumber,
        e?.totalDeliveryCost,
        e?.driverNumber,
        e?.creatorID,
        e?.bidCustomerID,
        e?.isRideApproved,
        e?.isRideRejected,
        e?.rideID,
        e?.createdTime,
        e?.pickLocationMap,
        e?.caryyItems,
        e?.stoppages,
        e?.rejectResoan,
        e?.rideStatus,
        e?.bookingsID,
        e?.isPassangerAllowedinCar,
        e?.isRideRulesAccepted,
        e?.rideStartLocationGoogle,
        e?.rideEndLocationGoogle,
        e?.rideSavedByUser,
        e?.rideCost,
        e?.googleStartAddress,
        e?.googleEndAddress
      ]);

  @override
  bool isValidKey(Object? o) => o is RidesNewRecord;
}
