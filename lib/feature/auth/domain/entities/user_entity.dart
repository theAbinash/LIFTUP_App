class UserEntity {

  final int? id;
  final String personUserName;
  final String personEmail;
  final String personUserPassword;
  final String? token;

  const UserEntity({
    this.id,
    required this.personUserName,
    required this.personEmail,
    required this.personUserPassword,
    this.token,
  });
}