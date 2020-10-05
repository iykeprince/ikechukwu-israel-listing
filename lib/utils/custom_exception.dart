class CustomException implements Exception {
  final String message;
  CustomException(this.message);
  String errorMessage() {
    return message;
  }
}

class NetworkErrorException extends CustomException {
  NetworkErrorException(String message) : super(message);
}
class BadStatusResponseException extends CustomException {
  BadStatusResponseException(String message) : super(message);
}
class CustomFileErrorException extends CustomException {
  CustomFileErrorException(String message) : super(message);
}