import 'package:lozalife/core/network/models/update_model.dart';

/// Stage 2: receives incremental updates from the server,
/// analogous to Telegram `getUpdates(pts)`.
abstract interface class UpdatesReceiver {
  /// Requests all updates that happened after [lastUpdateId].
  Future<List<UpdateModel>> getUpdates(int lastUpdateId);

  /// Live stream of updates pushed by the server while the app is online.
  Stream<UpdateModel> getUpdatesStream();
}
