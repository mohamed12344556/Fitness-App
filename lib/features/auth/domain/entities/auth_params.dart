class SignUpParams {
  final String email;
  final String password;
  final String fullName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class SignInParams {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });
}