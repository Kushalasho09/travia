import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrivacyPolicyRecord extends FirestoreRecord {
  PrivacyPolicyRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description1" field.
  String? _description1;
  String get description1 => _description1 ?? '';
  bool hasDescription1() => _description1 != null;

  // "description2" field.
  String? _description2;
  String get description2 => _description2 ?? '';
  bool hasDescription2() => _description2 != null;

  // "description3" field.
  String? _description3;
  String get description3 => _description3 ?? '';
  bool hasDescription3() => _description3 != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "serialNumber" field.
  int? _serialNumber;
  int get serialNumber => _serialNumber ?? 0;
  bool hasSerialNumber() => _serialNumber != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description1 = snapshotData['description1'] as String?;
    _description2 = snapshotData['description2'] as String?;
    _description3 = snapshotData['description3'] as String?;
    _category = snapshotData['category'] as String?;
    _serialNumber = castToType<int>(snapshotData['serialNumber']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('privacyPolicy');

  static Stream<PrivacyPolicyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PrivacyPolicyRecord.fromSnapshot(s));

  static Future<PrivacyPolicyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PrivacyPolicyRecord.fromSnapshot(s));

  static PrivacyPolicyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PrivacyPolicyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PrivacyPolicyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PrivacyPolicyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PrivacyPolicyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PrivacyPolicyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPrivacyPolicyRecordData({
  String? title,
  String? description1,
  String? description2,
  String? description3,
  String? category,
  int? serialNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description1': description1,
      'description2': description2,
      'description3': description3,
      'category': category,
      'serialNumber': serialNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class PrivacyPolicyRecordDocumentEquality
    implements Equality<PrivacyPolicyRecord> {
  const PrivacyPolicyRecordDocumentEquality();

  @override
  bool equals(PrivacyPolicyRecord? e1, PrivacyPolicyRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.description1 == e2?.description1 &&
        e1?.description2 == e2?.description2 &&
        e1?.description3 == e2?.description3 &&
        e1?.category == e2?.category &&
        e1?.serialNumber == e2?.serialNumber;
  }

  @override
  int hash(PrivacyPolicyRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description1,
        e?.description2,
        e?.description3,
        e?.category,
        e?.serialNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is PrivacyPolicyRecord;
}
