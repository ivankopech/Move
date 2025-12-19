import 'package:live_activities/live_activities.dart';
import 'package:flutter/foundation.dart';

class LiveActivityService {
  final LiveActivities plugin = LiveActivities();
  String? activityKey;
  bool initialized = false;

  Future<void> _init() async {
    if (initialized) return;
    await plugin.init(appGroupId: 'group.com.softing.move');
    initialized = true;
  }

  Future<void> start({
    required String status,
    //required String destination,
  }) async {
    await _init();

    if (activityKey != null) {
      await update(status: status);
      return;
    }

    final key = 'delivery_${DateTime.now().millisecondsSinceEpoch}';

    await plugin.createActivity(key, {
      'status': status,
      //'destination': destination,
    });

    activityKey = key;
  }

  Future<void> update({
    required String status,
    //required String destination,
  }) async {
    await _init();
    if (activityKey == null) return;

    await plugin.updateActivity(activityKey!, {
      'status': status,
      //'destination': destination,
    });
  }

  Future<void> end() async {
    await _init();

    if (activityKey == null) return;

    await plugin.endActivity(activityKey!);
    activityKey = null;
  }
}
