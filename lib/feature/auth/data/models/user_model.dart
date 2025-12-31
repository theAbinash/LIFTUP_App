import 'package:liftup/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  int? id;
  String? name;
  String email;
  int? sex; 
  String? dob;
  String personUserName;
  String personUserPassword;
  DateTime? personUserCreatedDate;
  String? timestamp;

  UserModel({
    this.id,
    this.name,
    required this.email,
    this.sex,
    this.dob,
    required this.personUserName,
    required this.personUserPassword,
    this.personUserCreatedDate,
    this.timestamp,
  }) : super(personEmail: email,personUserName: personUserName,personUserPassword: personUserPassword);

  
  Map<String, dynamic> toMap() {
    return {
      'person_id': id,
      'person_name': name,
      'person_email': email,
      'person_sex': sex,
      'person_dob': dob,
      'person_user_name':personUserName,
      'person_user_password':personUserPassword,
      'person_user_created_date':personUserCreatedDate,
      'timestamp': timestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['person_id'],
      name: map['person_name'],
      email: map['person_email'],
      sex: map['person_sex'],
      dob: map['person_dob'],
      personUserName: map['person_user_name'],
      personUserPassword: map['person_user_password'],
      personUserCreatedDate: map['person_user_created_date'],
      timestamp: map['timestamp'],
    );
  }
}
