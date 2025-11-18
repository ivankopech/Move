import 'package:flutter/material.dart';
import '../widgets/track_delivery.dart';
import '../../../requests/data/models/get_requests_model.dart';

class TrackDeliveryScreen extends StatefulWidget {
  final GetRequestsModel requestsModel;
  const TrackDeliveryScreen({super.key, required this.requestsModel});

  static const name = 'track-requests';
  static const path = '/track-requests';

  @override
  State<TrackDeliveryScreen> createState() => _TrackDeliveryScreenState();
}

class _TrackDeliveryScreenState extends State<TrackDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return TrackDelivery(requestsModel: widget.requestsModel);
  }
}
