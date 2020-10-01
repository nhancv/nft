/// Login in request form data
class LogInRequest {
  LogInRequest(this.username, this.password);

  final String username;
  final String password;

  @override
  String toString() {
    return 'LogInRequest{username: $username, password: $password}';
  }
}
