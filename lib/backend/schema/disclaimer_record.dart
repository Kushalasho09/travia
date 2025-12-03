import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DisclaimerRecord extends FirestoreRecord {
  DisclaimerRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "intro" field.
  String? _intro;
  String get intro => _intro ?? '';
  bool hasIntro() => _intro != null;

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

  void _initializeFields() {
    _intro = snapshotData['intro'] as String?;
    _title = snapshotData['title'] as String?;
    _description1 = snapshotData['description1'] as String?;
    _description2 = snapshotData['description2'] as String?;
    _description3 = snapshotData['description3'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Disclaimer');

  static Stream<DisclaimerRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DisclaimerRecord.fromSnapshot(s));

  static Future<DisclaimerRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DisclaimerRecord.fromSnapshot(s));

  static DisclaimerRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DisclaimerRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DisclaimerRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DisclaimerRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DisclaimerRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DisclaimerRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDisclaimerRecordData({
  String? intro,
  String? title,
  String? description1,
  String? description2,
  String? description3,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'intro': intro,
      'title': title,
      'description1': description1,
      'description2': description2,
      'description3': description3,
    }.withoutNulls,
  );

  return firestoreData;
}

class DisclaimerRecordDocumentEquality implements Equality<DisclaimerRecord> {
  const DisclaimerRecordDocumentEquality();

  @override
  bool equals(DisclaimerRecord? e1, DisclaimerRecord? e2) {
    return e1?.intro == e2?.intro &&
        e1?.title == e2?.title &&
        e1?.description1 == e2?.description1 &&
        e1?.description2 == e2?.description2 &&
        e1?.description3 == e2?.description3;
  }

  @override
  int hash(DisclaimerRecord? e) => const ListEquality().hash(
      [e?.intro, e?.title, e?.description1, e?.description2, e?.description3]);

  @override
  bool isValidKey(Object? o) => o is DisclaimerRecord;
}
