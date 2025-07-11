class AuthException implements Exception {
  final String code;
  final String? message;

  AuthException({required this.code, this.message});
}

class MatchException implements Exception {
  final String? message;

  MatchException({this.message});
}

class SocketException implements Exception {
  final String? message;

  SocketException({this.message});
}
