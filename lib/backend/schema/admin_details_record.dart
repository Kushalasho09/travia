import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminDetailsRecord extends FirestoreRecord {
  AdminDetailsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "whatsAppNumber" field.
  String? _whatsAppNumber;
  String get whatsAppNumber => _whatsAppNumber ?? '';
  bool hasWhatsAppNumber() => _whatsAppNumber != null;

  void _initializeFields() {
    _whatsAppNumber = snapshotData['whatsAppNumber'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('adminDetails');

  static Stream<AdminDetailsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdminDetailsRecord.fromSnapshot(s));

  static Future<AdminDetailsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdminDetailsRecord.fromSnapshot(s));

  static AdminDetailsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminDetailsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminDetailsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminDetailsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminDetailsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminDetailsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminDetailsRecordData({
  String? whatsAppNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'whatsAppNumber': whatsAppNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminDetailsRecordDocumentEquality
    implements Equality<AdminDetailsRecord> {
  const AdminDetailsRecordDocumentEquality();

  @override
  bool equals(AdminDetailsRecord? e1, AdminDetailsRecord? e2) {
    return e1?.whatsAppNumber == e2?.whatsAppNumber;
  }

  @override
  int hash(AdminDetailsRecord? e) =>
      const ListEquality().hash([e?.whatsAppNumber]);

  @override
  bool isValidKey(Object? o) => o is AdminDetailsRecord;
}
