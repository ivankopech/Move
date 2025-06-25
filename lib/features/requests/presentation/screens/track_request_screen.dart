import 'package:flutter/material.dart';
import '../widgets/track_request_widget.dart';

class TrackRequestScreen extends StatefulWidget {
  final int id;
  const TrackRequestScreen({super.key, required this.id});

  static const name = 'track-requests';
  static const path = '/track-requests';

  @override
  State<TrackRequestScreen> createState() => _GetRequestsScreenState();
}

class _GetRequestsScreenState extends State<TrackRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return TrackRequestWidget(id: widget.id);
  }
}
