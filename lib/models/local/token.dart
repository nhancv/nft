class Token {
  Token({this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        tokenType: json['token_type'] as String,
        expiresIn: json['expires_in'] as int,
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
      );

  static const String localKey = 'token';

  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token_type': tokenType,
        'expires_in': expiresIn,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };

  @override
  String toString() {
    return 'Token{tokenType: $tokenType, expiresIn: $expiresIn, accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
