/// Login in request form data
class LogInRequest {
  final String username;
  final String password;

  LogInRequest(this.username, this.password);

  @override
  String toString() {
    return 'LogInRequest{username: $username, password: $password}';
  }
}
