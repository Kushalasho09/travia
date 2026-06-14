import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsMessagesRecord extends FirestoreRecord {
  ChatsMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "timeSpam" field.
  DateTime? _timeSpam;
  DateTime? get timeSpam => _timeSpam;
  bool hasTimeSpam() => _timeSpam != null;

  // "uidOfSender" field.
  DocumentReference? _uidOfSender;
  DocumentReference? get uidOfSender => _uidOfSender;
  bool hasUidOfSender() => _uidOfSender != null;

  // "nameOfSender" field.
  String? _nameOfSender;
  String get nameOfSender => _nameOfSender ?? '';
  bool hasNameOfSender() => _nameOfSender != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _message = snapshotData['message'] as String?;
    _timeSpam = snapshotData['timeSpam'] as DateTime?;
    _uidOfSender = snapshotData['uidOfSender'] as DocumentReference?;
    _nameOfSender = snapshotData['nameOfSender'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('chatsMessages')
          : FirebaseFirestore.instance.collectionGroup('chatsMessages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('chatsMessages').doc(id);

  static Stream<ChatsMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsMessagesRecord.fromSnapshot(s));

  static Future<ChatsMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsMessagesRecord.fromSnapshot(s));

  static ChatsMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatsMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsMessagesRecordData({
  String? message,
  DateTime? timeSpam,
  DocumentReference? uidOfSender,
  String? nameOfSender,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'message': message,
      'timeSpam': timeSpam,
      'uidOfSender': uidOfSender,
      'nameOfSender': nameOfSender,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsMessagesRecordDocumentEquality
    implements Equality<ChatsMessagesRecord> {
  const ChatsMessagesRecordDocumentEquality();

  @override
  bool equals(ChatsMessagesRecord? e1, ChatsMessagesRecord? e2) {
    return e1?.message == e2?.message &&
        e1?.timeSpam == e2?.timeSpam &&
        e1?.uidOfSender == e2?.uidOfSender &&
        e1?.nameOfSender == e2?.nameOfSender &&
        e1?.image == e2?.image;
  }

  @override
  int hash(ChatsMessagesRecord? e) => const ListEquality().hash(
      [e?.message, e?.timeSpam, e?.uidOfSender, e?.nameOfSender, e?.image]);

  @override
  bool isValidKey(Object? o) => o is ChatsMessagesRecord;
}
