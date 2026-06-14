import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingsRecord extends FirestoreRecord {
  BookingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "itemName" field.
  String? _itemName;
  String get itemName => _itemName ?? '';
  bool hasItemName() => _itemName != null;

  // "receiverName" field.
  String? _receiverName;
  String get receiverName => _receiverName ?? '';
  bool hasReceiverName() => _receiverName != null;

  // "phoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "meetupLocation" field.
  String? _meetupLocation;
  String get meetupLocation => _meetupLocation ?? '';
  bool hasMeetupLocation() => _meetupLocation != null;

  // "meetupLocationMap" field.
  LatLng? _meetupLocationMap;
  LatLng? get meetupLocationMap => _meetupLocationMap;
  bool hasMeetupLocationMap() => _meetupLocationMap != null;

  // "additionalInformation" field.
  String? _additionalInformation;
  String get additionalInformation => _additionalInformation ?? '';
  bool hasAdditionalInformation() => _additionalInformation != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  // "rideID" field.
  DocumentReference? _rideID;
  DocumentReference? get rideID => _rideID;
  bool hasRideID() => _rideID != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "bookingType" field.
  String? _bookingType;
  String get bookingType => _bookingType ?? '';
  bool hasBookingType() => _bookingType != null;

  // "rideNameOfPerson" field.
  String? _rideNameOfPerson;
  String get rideNameOfPerson => _rideNameOfPerson ?? '';
  bool hasRideNameOfPerson() => _rideNameOfPerson != null;

  // "ridePersonContactNumber" field.
  String? _ridePersonContactNumber;
  String get ridePersonContactNumber => _ridePersonContactNumber ?? '';
  bool hasRidePersonContactNumber() => _ridePersonContactNumber != null;

  // "rideMeetupAddress" field.
  String? _rideMeetupAddress;
  String get rideMeetupAddress => _rideMeetupAddress ?? '';
  bool hasRideMeetupAddress() => _rideMeetupAddress != null;

  // "rideAdditionalInformation" field.
  String? _rideAdditionalInformation;
  String get rideAdditionalInformation => _rideAdditionalInformation ?? '';
  bool hasRideAdditionalInformation() => _rideAdditionalInformation != null;

  // "rideBookFor" field.
  String? _rideBookFor;
  String get rideBookFor => _rideBookFor ?? '';
  bool hasRideBookFor() => _rideBookFor != null;

  // "bookingFor" field.
  String? _bookingFor;
  String get bookingFor => _bookingFor ?? '';
  bool hasBookingFor() => _bookingFor != null;

  void _initializeFields() {
    _itemName = snapshotData['itemName'] as String?;
    _receiverName = snapshotData['receiverName'] as String?;
    _phoneNumber = snapshotData['phoneNumber'] as String?;
    _meetupLocation = snapshotData['meetupLocation'] as String?;
    _meetupLocationMap = snapshotData['meetupLocationMap'] as LatLng?;
    _additionalInformation = snapshotData['additionalInformation'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _creator = snapshotData['creator'] as DocumentReference?;
    _rideID = snapshotData['rideID'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _bookingType = snapshotData['bookingType'] as String?;
    _rideNameOfPerson = snapshotData['rideNameOfPerson'] as String?;
    _ridePersonContactNumber =
        snapshotData['ridePersonContactNumber'] as String?;
    _rideMeetupAddress = snapshotData['rideMeetupAddress'] as String?;
    _rideAdditionalInformation =
        snapshotData['rideAdditionalInformation'] as String?;
    _rideBookFor = snapshotData['rideBookFor'] as String?;
    _bookingFor = snapshotData['bookingFor'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bookings');

  static Stream<BookingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BookingsRecord.fromSnapshot(s));

  static Future<BookingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BookingsRecord.fromSnapshot(s));

  static BookingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BookingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BookingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BookingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BookingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BookingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBookingsRecordData({
  String? itemName,
  String? receiverName,
  String? phoneNumber,
  String? meetupLocation,
  LatLng? meetupLocationMap,
  String? additionalInformation,
  DateTime? createdTime,
  DocumentReference? creator,
  DocumentReference? rideID,
  String? status,
  String? bookingType,
  String? rideNameOfPerson,
  String? ridePersonContactNumber,
  String? rideMeetupAddress,
  String? rideAdditionalInformation,
  String? rideBookFor,
  String? bookingFor,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'itemName': itemName,
      'receiverName': receiverName,
      'phoneNumber': phoneNumber,
      'meetupLocation': meetupLocation,
      'meetupLocationMap': meetupLocationMap,
      'additionalInformation': additionalInformation,
      'createdTime': createdTime,
      'creator': creator,
      'rideID': rideID,
      'status': status,
      'bookingType': bookingType,
      'rideNameOfPerson': rideNameOfPerson,
      'ridePersonContactNumber': ridePersonContactNumber,
      'rideMeetupAddress': rideMeetupAddress,
      'rideAdditionalInformation': rideAdditionalInformation,
      'rideBookFor': rideBookFor,
      'bookingFor': bookingFor,
    }.withoutNulls,
  );

  return firestoreData;
}

class BookingsRecordDocumentEquality implements Equality<BookingsRecord> {
  const BookingsRecordDocumentEquality();

  @override
  bool equals(BookingsRecord? e1, BookingsRecord? e2) {
    return e1?.itemName == e2?.itemName &&
        e1?.receiverName == e2?.receiverName &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.meetupLocation == e2?.meetupLocation &&
        e1?.meetupLocationMap == e2?.meetupLocationMap &&
        e1?.additionalInformation == e2?.additionalInformation &&
        e1?.createdTime == e2?.createdTime &&
        e1?.creator == e2?.creator &&
        e1?.rideID == e2?.rideID &&
        e1?.status == e2?.status &&
        e1?.bookingType == e2?.bookingType &&
        e1?.rideNameOfPerson == e2?.rideNameOfPerson &&
        e1?.ridePersonContactNumber == e2?.ridePersonContactNumber &&
        e1?.rideMeetupAddress == e2?.rideMeetupAddress &&
        e1?.rideAdditionalInformation == e2?.rideAdditionalInformation &&
        e1?.rideBookFor == e2?.rideBookFor &&
        e1?.bookingFor == e2?.bookingFor;
  }

  @override
  int hash(BookingsRecord? e) => const ListEquality().hash([
        e?.itemName,
        e?.receiverName,
        e?.phoneNumber,
        e?.meetupLocation,
        e?.meetupLocationMap,
        e?.additionalInformation,
        e?.createdTime,
        e?.creator,
        e?.rideID,
        e?.status,
        e?.bookingType,
        e?.rideNameOfPerson,
        e?.ridePersonContactNumber,
        e?.rideMeetupAddress,
        e?.rideAdditionalInformation,
        e?.rideBookFor,
        e?.bookingFor
      ]);

  @override
  bool isValidKey(Object? o) => o is BookingsRecord;
}
