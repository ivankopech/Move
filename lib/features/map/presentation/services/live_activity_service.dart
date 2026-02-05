import 'package:live_activities/live_activities.dart';
import 'package:flutter/foundation.dart';

class LiveActivityService {
  final LiveActivities plugin = LiveActivities();
  String? systemActivityId;
  bool initialized = false;

  Future<void> init() async {
    if (initialized) return;
    await plugin.init(appGroupId: 'group.com.softing.move');
    initialized = true;
  }

  Future<void> start({
    required String status,
    required double distance,
    required String destination,
  }) async {
    await init();

    if (systemActivityId != null) {
      await update(
        status: status,
        distance: distance,
        destination: destination,
      );
      return;
    }

    final customId = 'delivery_${DateTime.now().millisecondsSinceEpoch}';

    final createdId = await plugin.createActivity(customId, {
      'status': status,
      'distance': distance,
      'destination': destination,
    });

    systemActivityId = createdId?.toString();
    if (systemActivityId == null || systemActivityId!.isEmpty) {
      debugPrint('create activity returned null/empty id');
      return;
    }
    debugPrint('system id: $systemActivityId');
  }

  Future<void> update({
    required String status,
    required double distance,
    required String destination,
  }) async {
    await init();
    if (systemActivityId == null) return;

    await plugin.updateActivity(systemActivityId!, {
      'status': status,
      'distance': distance,
      'destination': destination,
    });
  }

  Future<void> end() async {
    await init();

    if (systemActivityId == null) return;

    await plugin.endActivity(systemActivityId!);
    systemActivityId = null;
  }
}
