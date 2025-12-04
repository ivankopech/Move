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
          if (requestModel.tracking!.isEmpty) {
            noDataDialog(
              context,
              icon: Icons.info_outline_rounded,
              text: 'The driver hasn\'t started this delivery yet!',
            );
          } else {
            Future.microtask(() {
              context.pushNamed(TrackDeliveryScreen.name, extra: requestModel);
            });
          }
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
                  const SizedBox(height: 10),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'FROM: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '${requestModel.calleDesde} ${requestModel.numeroDesde}, ${requestModel.tramos![0].direccion!.city}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'TO: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '${requestModel.calleHasta} ${requestModel.numeroHasta}, ${requestModel.tramos![1].direccion!.city}',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 10, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        'Active',
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

void noDataDialog(
  BuildContext context, {
  required IconData icon,
  required String text,
  String buttonText = 'Go back',
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.deepPurpleAccent),
              const SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
