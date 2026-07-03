/// Stage 2: notifies the sync layer about network availability so the
/// pending operations queue can be flushed as soon as the device is online.
abstract interface class ConnectivityObserver {
  Stream<bool> get isOnlineStream;
}
