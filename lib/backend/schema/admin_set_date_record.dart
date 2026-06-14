import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminSetDateRecord extends FirestoreRecord {
  AdminSetDateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "dateList" field.
  DateTime? _dateList;
  DateTime? get dateList => _dateList;
  bool hasDateList() => _dateList != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  void _initializeFields() {
    _dateList = snapshotData['dateList'] as DateTime?;
    _title = snapshotData['title'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('adminSetDate');

  static Stream<AdminSetDateRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdminSetDateRecord.fromSnapshot(s));

  static Future<AdminSetDateRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdminSetDateRecord.fromSnapshot(s));

  static AdminSetDateRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminSetDateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminSetDateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminSetDateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminSetDateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminSetDateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminSetDateRecordData({
  DateTime? dateList,
  String? title,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'dateList': dateList,
      'title': title,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminSetDateRecordDocumentEquality
    implements Equality<AdminSetDateRecord> {
  const AdminSetDateRecordDocumentEquality();

  @override
  bool equals(AdminSetDateRecord? e1, AdminSetDateRecord? e2) {
    return e1?.dateList == e2?.dateList && e1?.title == e2?.title;
  }

  @override
  int hash(AdminSetDateRecord? e) =>
      const ListEquality().hash([e?.dateList, e?.title]);

  @override
  bool isValidKey(Object? o) => o is AdminSetDateRecord;
}
