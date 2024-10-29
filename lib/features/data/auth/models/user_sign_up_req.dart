class UserSignUpReq {
  final String email;
  final String password;
  final String confirmPassword;

  UserSignUpReq({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}