import 'package:flutter/material.dart';
import '../widgets/get_requests_widget.dart';

class GetRequestsScreen extends StatefulWidget {
  static const name = 'get-requests';
  static const path = '/get-requests';
  final int initialIndex;
  const GetRequestsScreen({super.key, this.initialIndex = 0});

  @override
  State<GetRequestsScreen> createState() => _GetRequestsScreenState();
}

class _GetRequestsScreenState extends State<GetRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetRequestsWidget(initialIndex: widget.initialIndex);
  }
}
