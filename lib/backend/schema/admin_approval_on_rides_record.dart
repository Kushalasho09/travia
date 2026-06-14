import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminApprovalOnRidesRecord extends FirestoreRecord {
  AdminApprovalOnRidesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "isDirectApproved" field.
  String? _isDirectApproved;
  String get isDirectApproved => _isDirectApproved ?? '';
  bool hasIsDirectApproved() => _isDirectApproved != null;

  void _initializeFields() {
    _isDirectApproved = snapshotData['isDirectApproved'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('AdminApprovalOnRides');

  static Stream<AdminApprovalOnRidesRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => AdminApprovalOnRidesRecord.fromSnapshot(s));

  static Future<AdminApprovalOnRidesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AdminApprovalOnRidesRecord.fromSnapshot(s));

  static AdminApprovalOnRidesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminApprovalOnRidesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminApprovalOnRidesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminApprovalOnRidesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminApprovalOnRidesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminApprovalOnRidesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminApprovalOnRidesRecordData({
  String? isDirectApproved,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'isDirectApproved': isDirectApproved,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminApprovalOnRidesRecordDocumentEquality
    implements Equality<AdminApprovalOnRidesRecord> {
  const AdminApprovalOnRidesRecordDocumentEquality();

  @override
  bool equals(AdminApprovalOnRidesRecord? e1, AdminApprovalOnRidesRecord? e2) {
    return e1?.isDirectApproved == e2?.isDirectApproved;
  }

  @override
  int hash(AdminApprovalOnRidesRecord? e) =>
      const ListEquality().hash([e?.isDirectApproved]);

  @override
  bool isValidKey(Object? o) => o is AdminApprovalOnRidesRecord;
}
