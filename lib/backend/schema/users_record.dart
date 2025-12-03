import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "date_of_birth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "is_profile_completed" field.
  bool? _isProfileCompleted;
  bool get isProfileCompleted => _isProfileCompleted ?? false;
  bool hasIsProfileCompleted() => _isProfileCompleted != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "aadhar_front" field.
  String? _aadharFront;
  String get aadharFront => _aadharFront ?? '';
  bool hasAadharFront() => _aadharFront != null;

  // "aadhar_back" field.
  String? _aadharBack;
  String get aadharBack => _aadharBack ?? '';
  bool hasAadharBack() => _aadharBack != null;

  // "is_tc_acceoted" field.
  bool? _isTcAcceoted;
  bool get isTcAcceoted => _isTcAcceoted ?? false;
  bool hasIsTcAcceoted() => _isTcAcceoted != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "isVerifed" field.
  bool? _isVerifed;
  bool get isVerifed => _isVerifed ?? false;
  bool hasIsVerifed() => _isVerifed != null;

  // "street" field.
  String? _street;
  String get street => _street ?? '';
  bool hasStreet() => _street != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "postalCode" field.
  int? _postalCode;
  int get postalCode => _postalCode ?? 0;
  bool hasPostalCode() => _postalCode != null;

  // "aadharNumber" field.
  int? _aadharNumber;
  int get aadharNumber => _aadharNumber ?? 0;
  bool hasAadharNumber() => _aadharNumber != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "walletBalance" field.
  double? _walletBalance;
  double get walletBalance => _walletBalance ?? 0.0;
  bool hasWalletBalance() => _walletBalance != null;

  // "newDateOfBirth" field.
  String? _newDateOfBirth;
  String get newDateOfBirth => _newDateOfBirth ?? '';
  bool hasNewDateOfBirth() => _newDateOfBirth != null;

  // "ratings" field.
  List<double>? _ratings;
  List<double> get ratings => _ratings ?? const [];
  bool hasRatings() => _ratings != null;

  // "chatConnected" field.
  List<DocumentReference>? _chatConnected;
  List<DocumentReference> get chatConnected => _chatConnected ?? const [];
  bool hasChatConnected() => _chatConnected != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _dateOfBirth = snapshotData['date_of_birth'] as DateTime?;
    _isProfileCompleted = snapshotData['is_profile_completed'] as bool?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _aadharFront = snapshotData['aadhar_front'] as String?;
    _aadharBack = snapshotData['aadhar_back'] as String?;
    _isTcAcceoted = snapshotData['is_tc_acceoted'] as bool?;
    _userName = snapshotData['userName'] as String?;
    _isVerifed = snapshotData['isVerifed'] as bool?;
    _street = snapshotData['street'] as String?;
    _city = snapshotData['city'] as String?;
    _state = snapshotData['state'] as String?;
    _postalCode = castToType<int>(snapshotData['postalCode']);
    _aadharNumber = castToType<int>(snapshotData['aadharNumber']);
    _role = snapshotData['role'] as String?;
    _walletBalance = castToType<double>(snapshotData['walletBalance']);
    _newDateOfBirth = snapshotData['newDateOfBirth'] as String?;
    _ratings = getDataList(snapshotData['ratings']);
    _chatConnected = getDataList(snapshotData['chatConnected']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  DateTime? dateOfBirth,
  bool? isProfileCompleted,
  String? phoneNumber,
  String? aadharFront,
  String? aadharBack,
  bool? isTcAcceoted,
  String? userName,
  bool? isVerifed,
  String? street,
  String? city,
  String? state,
  int? postalCode,
  int? aadharNumber,
  String? role,
  double? walletBalance,
  String? newDateOfBirth,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'date_of_birth': dateOfBirth,
      'is_profile_completed': isProfileCompleted,
      'phone_number': phoneNumber,
      'aadhar_front': aadharFront,
      'aadhar_back': aadharBack,
      'is_tc_acceoted': isTcAcceoted,
      'userName': userName,
      'isVerifed': isVerifed,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'aadharNumber': aadharNumber,
      'role': role,
      'walletBalance': walletBalance,
      'newDateOfBirth': newDateOfBirth,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.isProfileCompleted == e2?.isProfileCompleted &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.aadharFront == e2?.aadharFront &&
        e1?.aadharBack == e2?.aadharBack &&
        e1?.isTcAcceoted == e2?.isTcAcceoted &&
        e1?.userName == e2?.userName &&
        e1?.isVerifed == e2?.isVerifed &&
        e1?.street == e2?.street &&
        e1?.city == e2?.city &&
        e1?.state == e2?.state &&
        e1?.postalCode == e2?.postalCode &&
        e1?.aadharNumber == e2?.aadharNumber &&
        e1?.role == e2?.role &&
        e1?.walletBalance == e2?.walletBalance &&
        e1?.newDateOfBirth == e2?.newDateOfBirth &&
        listEquality.equals(e1?.ratings, e2?.ratings) &&
        listEquality.equals(e1?.chatConnected, e2?.chatConnected);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.dateOfBirth,
        e?.isProfileCompleted,
        e?.phoneNumber,
        e?.aadharFront,
        e?.aadharBack,
        e?.isTcAcceoted,
        e?.userName,
        e?.isVerifed,
        e?.street,
        e?.city,
        e?.state,
        e?.postalCode,
        e?.aadharNumber,
        e?.role,
        e?.walletBalance,
        e?.newDateOfBirth,
        e?.ratings,
        e?.chatConnected
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
