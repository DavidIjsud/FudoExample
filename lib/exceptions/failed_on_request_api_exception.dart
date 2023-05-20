class FailedOnRequestApiException implements Exception {
  final String urlFailed;

  const FailedOnRequestApiException({
    required this.urlFailed,
  });
}
