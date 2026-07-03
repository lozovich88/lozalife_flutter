/// Stage 2: persists sync metadata (lastUpdateId, session, sync state).
abstract interface class SyncRepository {
  Future<int> getLastUpdateId();

  Future<void> saveLastUpdateId(int updateId);
}
