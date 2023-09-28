class UserCredential {
  final String external_user_id;
  final String? email;
  final String type;
  UserCredential(
      {required this.external_user_id, this.email, required this.type});
}
