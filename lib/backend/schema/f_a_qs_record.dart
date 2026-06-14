import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FAQsRecord extends FirestoreRecord {
  FAQsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  bool hasQuestion() => _question != null;

  // "answer" field.
  String? _answer;
  String get answer => _answer ?? '';
  bool hasAnswer() => _answer != null;

  void _initializeFields() {
    _question = snapshotData['question'] as String?;
    _answer = snapshotData['answer'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('FAQs');

  static Stream<FAQsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FAQsRecord.fromSnapshot(s));

  static Future<FAQsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FAQsRecord.fromSnapshot(s));

  static FAQsRecord fromSnapshot(DocumentSnapshot snapshot) => FAQsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FAQsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FAQsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FAQsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FAQsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFAQsRecordData({
  String? question,
  String? answer,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'question': question,
      'answer': answer,
    }.withoutNulls,
  );

  return firestoreData;
}

class FAQsRecordDocumentEquality implements Equality<FAQsRecord> {
  const FAQsRecordDocumentEquality();

  @override
  bool equals(FAQsRecord? e1, FAQsRecord? e2) {
    return e1?.question == e2?.question && e1?.answer == e2?.answer;
  }

  @override
  int hash(FAQsRecord? e) =>
      const ListEquality().hash([e?.question, e?.answer]);

  @override
  bool isValidKey(Object? o) => o is FAQsRecord;
}
