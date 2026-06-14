import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MarketPlaceRecord extends FirestoreRecord {
  MarketPlaceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "productName" field.
  String? _productName;
  String get productName => _productName ?? '';
  bool hasProductName() => _productName != null;

  // "origin" field.
  String? _origin;
  String get origin => _origin ?? '';
  bool hasOrigin() => _origin != null;

  // "destination" field.
  String? _destination;
  String get destination => _destination ?? '';
  bool hasDestination() => _destination != null;

  // "destinationLocation" field.
  LatLng? _destinationLocation;
  LatLng? get destinationLocation => _destinationLocation;
  bool hasDestinationLocation() => _destinationLocation != null;

  // "descriptionItem" field.
  String? _descriptionItem;
  String get descriptionItem => _descriptionItem ?? '';
  bool hasDescriptionItem() => _descriptionItem != null;

  // "quantity" field.
  String? _quantity;
  String get quantity => _quantity ?? '';
  bool hasQuantity() => _quantity != null;

  // "price" field.
  String? _price;
  String get price => _price ?? '';
  bool hasPrice() => _price != null;

  // "postedBy" field.
  DocumentReference? _postedBy;
  DocumentReference? get postedBy => _postedBy;
  bool hasPostedBy() => _postedBy != null;

  // "imageOfproduct" field.
  String? _imageOfproduct;
  String get imageOfproduct => _imageOfproduct ?? '';
  bool hasImageOfproduct() => _imageOfproduct != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "arivalDate" field.
  DateTime? _arivalDate;
  DateTime? get arivalDate => _arivalDate;
  bool hasArivalDate() => _arivalDate != null;

  void _initializeFields() {
    _productName = snapshotData['productName'] as String?;
    _origin = snapshotData['origin'] as String?;
    _destination = snapshotData['destination'] as String?;
    _destinationLocation = snapshotData['destinationLocation'] as LatLng?;
    _descriptionItem = snapshotData['descriptionItem'] as String?;
    _quantity = snapshotData['quantity'] as String?;
    _price = snapshotData['price'] as String?;
    _postedBy = snapshotData['postedBy'] as DocumentReference?;
    _imageOfproduct = snapshotData['imageOfproduct'] as String?;
    _status = snapshotData['status'] as String?;
    _arivalDate = snapshotData['arivalDate'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('marketPlace');

  static Stream<MarketPlaceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MarketPlaceRecord.fromSnapshot(s));

  static Future<MarketPlaceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MarketPlaceRecord.fromSnapshot(s));

  static MarketPlaceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MarketPlaceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MarketPlaceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MarketPlaceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MarketPlaceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MarketPlaceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMarketPlaceRecordData({
  String? productName,
  String? origin,
  String? destination,
  LatLng? destinationLocation,
  String? descriptionItem,
  String? quantity,
  String? price,
  DocumentReference? postedBy,
  String? imageOfproduct,
  String? status,
  DateTime? arivalDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'productName': productName,
      'origin': origin,
      'destination': destination,
      'destinationLocation': destinationLocation,
      'descriptionItem': descriptionItem,
      'quantity': quantity,
      'price': price,
      'postedBy': postedBy,
      'imageOfproduct': imageOfproduct,
      'status': status,
      'arivalDate': arivalDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class MarketPlaceRecordDocumentEquality implements Equality<MarketPlaceRecord> {
  const MarketPlaceRecordDocumentEquality();

  @override
  bool equals(MarketPlaceRecord? e1, MarketPlaceRecord? e2) {
    return e1?.productName == e2?.productName &&
        e1?.origin == e2?.origin &&
        e1?.destination == e2?.destination &&
        e1?.destinationLocation == e2?.destinationLocation &&
        e1?.descriptionItem == e2?.descriptionItem &&
        e1?.quantity == e2?.quantity &&
        e1?.price == e2?.price &&
        e1?.postedBy == e2?.postedBy &&
        e1?.imageOfproduct == e2?.imageOfproduct &&
        e1?.status == e2?.status &&
        e1?.arivalDate == e2?.arivalDate;
  }

  @override
  int hash(MarketPlaceRecord? e) => const ListEquality().hash([
        e?.productName,
        e?.origin,
        e?.destination,
        e?.destinationLocation,
        e?.descriptionItem,
        e?.quantity,
        e?.price,
        e?.postedBy,
        e?.imageOfproduct,
        e?.status,
        e?.arivalDate
      ]);

  @override
  bool isValidKey(Object? o) => o is MarketPlaceRecord;
}
