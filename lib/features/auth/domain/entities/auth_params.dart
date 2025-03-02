// sign up
class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String? birthDate;
  final int? height;   
  final int? weight;
  final DateTime? createdAt;

  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    this.birthDate,
    this.height,
    this.weight,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      if (birthDate != null) 'birthDate': birthDate,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      'createdAt': createdAt ?? DateTime.now(),
    };
  }
}
// login 
class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}