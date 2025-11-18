import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../requests/data/models/get_requests_model.dart';
import '../screens/track_delivery_screen.dart';

class DeliveryCard extends StatelessWidget {
  final GetRequestsModel requestModel;
  const DeliveryCard({super.key, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Future.microtask(() {
            context.pushNamed(TrackDeliveryScreen.name, extra: requestModel);
          });
        },
        child: Row(
          children: [
            const Icon(
              Icons.local_shipping_rounded,
              size: 40,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery #${requestModel.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${requestModel.calleHasta} ${requestModel.numeroHasta}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 10, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        'On the way',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
