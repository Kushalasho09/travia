import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BidsForMarketPlaceRecord extends FirestoreRecord {
  BidsForMarketPlaceRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "bidsCreatorID" field.
  DocumentReference? _bidsCreatorID;
  DocumentReference? get bidsCreatorID => _bidsCreatorID;
  bool hasBidsCreatorID() => _bidsCreatorID != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "marketPlaceRef" field.
  DocumentReference? _marketPlaceRef;
  DocumentReference? get marketPlaceRef => _marketPlaceRef;
  bool hasMarketPlaceRef() => _marketPlaceRef != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "createAt" field.
  DateTime? _createAt;
  DateTime? get createAt => _createAt;
  bool hasCreateAt() => _createAt != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "quantity" field.
  double? _quantity;
  double get quantity => _quantity ?? 0.0;
  bool hasQuantity() => _quantity != null;

  void _initializeFields() {
    _bidsCreatorID = snapshotData['bidsCreatorID'] as DocumentReference?;
    _description = snapshotData['description'] as String?;
    _marketPlaceRef = snapshotData['marketPlaceRef'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _createAt = snapshotData['createAt'] as DateTime?;
    _price = castToType<double>(snapshotData['price']);
    _quantity = castToType<double>(snapshotData['quantity']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bidsForMarketPlace');

  static Stream<BidsForMarketPlaceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BidsForMarketPlaceRecord.fromSnapshot(s));

  static Future<BidsForMarketPlaceRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => BidsForMarketPlaceRecord.fromSnapshot(s));

  static BidsForMarketPlaceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BidsForMarketPlaceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BidsForMarketPlaceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BidsForMarketPlaceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BidsForMarketPlaceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BidsForMarketPlaceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBidsForMarketPlaceRecordData({
  DocumentReference? bidsCreatorID,
  String? description,
  DocumentReference? marketPlaceRef,
  String? status,
  DateTime? createAt,
  double? price,
  double? quantity,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bidsCreatorID': bidsCreatorID,
      'description': description,
      'marketPlaceRef': marketPlaceRef,
      'status': status,
      'createAt': createAt,
      'price': price,
      'quantity': quantity,
    }.withoutNulls,
  );

  return firestoreData;
}

class BidsForMarketPlaceRecordDocumentEquality
    implements Equality<BidsForMarketPlaceRecord> {
  const BidsForMarketPlaceRecordDocumentEquality();

  @override
  bool equals(BidsForMarketPlaceRecord? e1, BidsForMarketPlaceRecord? e2) {
    return e1?.bidsCreatorID == e2?.bidsCreatorID &&
        e1?.description == e2?.description &&
        e1?.marketPlaceRef == e2?.marketPlaceRef &&
        e1?.status == e2?.status &&
        e1?.createAt == e2?.createAt &&
        e1?.price == e2?.price &&
        e1?.quantity == e2?.quantity;
  }

  @override
  int hash(BidsForMarketPlaceRecord? e) => const ListEquality().hash([
        e?.bidsCreatorID,
        e?.description,
        e?.marketPlaceRef,
        e?.status,
        e?.createAt,
        e?.price,
        e?.quantity
      ]);

  @override
  bool isValidKey(Object? o) => o is BidsForMarketPlaceRecord;
}
