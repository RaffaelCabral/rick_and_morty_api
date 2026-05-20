/// Falha ao ler dados persistidos (ex.: episódio nunca sincronizado ou cache incompleto).
class OfflineCacheException implements Exception {
  OfflineCacheException(this.message);

  final String message;

  @override
  String toString() => message;
}
