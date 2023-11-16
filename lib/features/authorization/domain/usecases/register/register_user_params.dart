class RegisterUserParams {
  const RegisterUserParams({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;
}
