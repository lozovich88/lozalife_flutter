/// Stage 2: full re-sync fallback.
///
/// When the server answers `needFullSync=true` (too many missed updates),
/// the client downloads a full snapshot, replaces the local database and
/// stores the new `lastUpdateId`.
abstract interface class SnapshotDownloader {
  Future<void> downloadSnapshot();
}
