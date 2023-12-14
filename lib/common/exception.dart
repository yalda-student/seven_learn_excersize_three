class ServerException{
  final String message;
  final int statusCode;

  ServerException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'ServerException{message: $message, statusCode: $statusCode}';
  }
}