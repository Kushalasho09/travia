import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContactSetupRecord extends FirestoreRecord {
  ContactSetupRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "phoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "emailID" field.
  String? _emailID;
  String get emailID => _emailID ?? '';
  bool hasEmailID() => _emailID != null;

  // "whatsappNumber" field.
  String? _whatsappNumber;
  String get whatsappNumber => _whatsappNumber ?? '';
  bool hasWhatsappNumber() => _whatsappNumber != null;

  // "liveChatLink" field.
  String? _liveChatLink;
  String get liveChatLink => _liveChatLink ?? '';
  bool hasLiveChatLink() => _liveChatLink != null;

  void _initializeFields() {
    _phoneNumber = snapshotData['phoneNumber'] as String?;
    _emailID = snapshotData['emailID'] as String?;
    _whatsappNumber = snapshotData['whatsappNumber'] as String?;
    _liveChatLink = snapshotData['liveChatLink'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('contactSetup');

  static Stream<ContactSetupRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ContactSetupRecord.fromSnapshot(s));

  static Future<ContactSetupRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ContactSetupRecord.fromSnapshot(s));

  static ContactSetupRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ContactSetupRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ContactSetupRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ContactSetupRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ContactSetupRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ContactSetupRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createContactSetupRecordData({
  String? phoneNumber,
  String? emailID,
  String? whatsappNumber,
  String? liveChatLink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'phoneNumber': phoneNumber,
      'emailID': emailID,
      'whatsappNumber': whatsappNumber,
      'liveChatLink': liveChatLink,
    }.withoutNulls,
  );

  return firestoreData;
}

class ContactSetupRecordDocumentEquality
    implements Equality<ContactSetupRecord> {
  const ContactSetupRecordDocumentEquality();

  @override
  bool equals(ContactSetupRecord? e1, ContactSetupRecord? e2) {
    return e1?.phoneNumber == e2?.phoneNumber &&
        e1?.emailID == e2?.emailID &&
        e1?.whatsappNumber == e2?.whatsappNumber &&
        e1?.liveChatLink == e2?.liveChatLink;
  }

  @override
  int hash(ContactSetupRecord? e) => const ListEquality()
      .hash([e?.phoneNumber, e?.emailID, e?.whatsappNumber, e?.liveChatLink]);

  @override
  bool isValidKey(Object? o) => o is ContactSetupRecord;
}
