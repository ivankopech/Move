import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../requests/data/models/get_requests_model.dart';
import '../../../requests/presentation/providers/set_tip_state_notifier_provider.dart';
import '../../../requests/presentation/providers/get_request_id_state_notifier_provider.dart';
import '../../presentation/providers/create_review_state_notifier_provider.dart';
import '../../../../common/widgets/generic_error_screen.dart';

class TipDialog extends ConsumerStatefulWidget {
  final int id;
  final String from;
  final String to;

  const TipDialog({
    super.key,
    required this.id,
    required this.from,
    required this.to,
  });

  @override
  ConsumerState<TipDialog> createState() => _TipDialogState();
}

class _TipDialogState extends ConsumerState<TipDialog> {
  int rating = 0;
  int? selectedPercentage;
  final commentController = TextEditingController();
  final customAmountController = TextEditingController();

  void sendTip(double tripAmount) {
    if (rating < 1 || rating > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please rate your trip from 1 to 5 stars'),
        ),
      );
      return;
    }

    final comment = commentController.text;

    double percentage = selectedPercentage?.toDouble() ?? 0;
    double amount = double.tryParse(customAmountController.text) ?? 0;

    bool noTip = percentage == 0 && amount == 0;

    ref
        .read(setTipStateNotifierProvider.notifier)
        .setTip(widget.id, percentage, amount, noTip);

    ref
        .read(createReviewStateNotifierProvider.notifier)
        .createReview(id: widget.id, comment: comment, rating: rating);

    Navigator.pop(context);
  }

  void onRetry() {
    ref
        .read(getRequestByIdStateNotifierProvider.notifier)
        .getRequestById(widget.id);
  }

  @override
  void dispose() {
    commentController.dispose();
    customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestData = ref.watch(getRequestByIdStateNotifierProvider);

    return requestData.when(
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => GenericErrorScreen(onRetry: onRetry),
      data: (request) {
        final courier = request!.userTernsportista;
        final driver =
            '${request.userTernsportista!.name} ${request.userTernsportista!.surname}';
        final name = courier!.name!.trim();

        final priceNum = (request.costoEstimado);

        final mq = MediaQuery.of(context);
        final maxH = mq.size.height * 0.85;
        final maxW = mq.size.width * 0.85;
        final bottomInset = mq.viewInsets.bottom;
        return Material(
          color: Colors.transparent,
          child: Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW, maxHeight: maxH),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      color: Colors.black,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Rate your trip with $driver',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            /// Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return IconButton(
                                  icon: Icon(
                                    Icons.star,
                                    color:
                                        index < rating
                                            ? Colors.amber
                                            : Colors.grey.shade700,
                                    size: 32,
                                  ),
                                  onPressed:
                                      () => setState(() => rating = index + 1),
                                );
                              }),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              children: [
                                Icon(Icons.edit, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  'Reward $name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            /// Comment
                            TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintText: 'Ej: Polite and gentle',
                                filled: true,
                                fillColor: Colors.grey.shade900,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),

                            const SizedBox(height: 25),

                            Text(
                              'Add an extra for $driver',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Due amount: \$$priceNum',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 15),

                            /// Percent buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  [5, 10, 20].map((percent) {
                                    final selected =
                                        selectedPercentage == percent;
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ChoiceChip(
                                        label: Text(
                                          '$percent%',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        selected: selected,
                                        selectedColor: Colors.black,
                                        backgroundColor: Colors.black,
                                        side: BorderSide(
                                          color:
                                              selected
                                                  ? Colors.white
                                                  : Colors.grey.shade900,
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        onSelected: (isSelected) {
                                          setState(() {
                                            if (selectedPercentage == percent) {
                                              selectedPercentage = null;
                                            } else {
                                              selectedPercentage = percent;
                                              customAmountController.clear();
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                            ),

                            const SizedBox(height: 15),

                            /// Custom amount
                            TextField(
                              controller: customAmountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Custom amount',
                                filled: true,
                                fillColor: Colors.grey.shade900,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              onTap:
                                  () =>
                                      setState(() => selectedPercentage = null),
                            ),

                            const SizedBox(height: 30),

                            /// Send button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed:
                                    () => sendTip((priceNum ?? 0).toDouble()),
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
