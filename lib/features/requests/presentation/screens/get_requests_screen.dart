import 'package:flutter/material.dart';
import '../widgets/get_requests_widget.dart';

class GetRequestsScreen extends StatefulWidget {
  const GetRequestsScreen({super.key});

  static const name = 'get-requests';
  static const path = '/get-requests';

  @override
  State<GetRequestsScreen> createState() => _GetRequestsScreenState();
}

class _GetRequestsScreenState extends State<GetRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetRequestsWidget();
  }
}
