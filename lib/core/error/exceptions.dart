class AppException implements Exception {
  const AppException([this.message = 'Something went wrong']);

  final String message;
}
