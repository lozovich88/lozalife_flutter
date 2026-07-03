import 'package:lozalife/core/sync/connectivity_observer.dart';
import 'package:lozalife/core/sync/pending_operations_repository.dart';
import 'package:lozalife/core/sync/snapshot_downloader.dart';
import 'package:lozalife/core/sync/updates_applier.dart';
import 'package:lozalife/core/sync/updates_receiver.dart';

/// Stage 2 entry point: orchestrates the Telegram-like sync loop.
///
/// Planned flow:
/// 1. Authorize and obtain a session.
/// 2. `getUpdates(lastUpdateId)` via [UpdatesReceiver].
/// 3. Apply each update to the local database via [UpdatesApplier].
/// 4. If the server answers `needFullSync=true`, replace the local database
///    through [SnapshotDownloader].
/// 5. Flush [PendingOperationsRepository] queue with `POST /updates`.
///
/// UI never talks to this class directly; it keeps observing Drift streams.
abstract interface class SyncManager {
  UpdatesReceiver get updatesReceiver;
  UpdatesApplier get updatesApplier;
  PendingOperationsRepository get pendingOperations;
  SnapshotDownloader get snapshotDownloader;
  ConnectivityObserver get connectivityObserver;

  Future<void> start();

  Future<void> stop();
}
