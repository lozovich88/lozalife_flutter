/// Stage 2: queue of local operations waiting to be sent to the server.
///
/// Repositories will enqueue an operation right after committing a local
/// change (CreateTask, DeleteTask, MoveTask, RenameTask, ...). SyncService
/// sends the queue with `POST /updates` and removes confirmed entries.
abstract interface class PendingOperationsRepository {
  Future<void> enqueue(String operationType, Map<String, Object?> payload);

  Future<List<Map<String, Object?>>> getPending();

  Future<void> markCompleted(List<String> operationIds);
}
