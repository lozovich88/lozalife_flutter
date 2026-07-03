import 'package:lozalife/core/network/models/update_model.dart';

/// Stage 2: applies a server update to the local Drift database.
///
/// Conflict policy for the first sync iteration: server wins.
/// The UI refreshes automatically through Drift streams.
abstract interface class UpdatesApplier {
  Future<void> apply(UpdateModel update);
}
