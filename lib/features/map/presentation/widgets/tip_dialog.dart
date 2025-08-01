import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../requests/data/models/get_requests_model.dart';
import '../../../requests/presentation/providers/set_tip_state_notifier_provider.dart';

class TipDialog extends ConsumerStatefulWidget {
  final int? id;
  final String? from;
  final String? to;
  final String? date;

  const TipDialog({
    super.key,
    required this.id,
    required this.from,
    required this.to,
    required this.date,
  });

  @override
  ConsumerState<TipDialog> createState() => _TipDialogState();
}

class _TipDialogState extends ConsumerState<TipDialog> {
  final tipPercentageController = TextEditingController();
  final tipAmountController = TextEditingController();
  String selectedOption = 'Amount';
  String? errorText;

  String formatDate(String? rawDate) {
    if (rawDate == null) return '';
    final dateTime = DateTime.tryParse(rawDate);
    if (dateTime == null) return '';
    final formatter = DateFormat('dd MMM yyyy, HH:mm \'h\'');
    return formatter.format(dateTime);
  }

  void sendTip() {
    FocusScope.of(context).unfocus(); // Cierra teclado
    double amount = 0;
    double percentage = 0;
    if (selectedOption == 'Amount') {
      amount = double.tryParse(tipAmountController.text) ?? -1;
      if (amount <= 0) {
        setState(() => errorText = 'Please enter a valid amount');
        return;
      }
    } else {
      percentage = double.tryParse(tipPercentageController.text) ?? -1;
      if (percentage <= 0) {
        setState(() => errorText = 'Please enter a valid percentage');
        return;
      }
    }

    ref
        .read(setTipStateNotifierProvider.notifier)
        .setTip(widget.id, percentage, amount);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Add a tip to your mover'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('From: ${widget.from}', style: theme.textTheme.bodyLarge),
              SizedBox(height: 5),
              Text('To: ${widget.to}', style: theme.textTheme.bodyLarge),
              SizedBox(height: 5),
              Text(
                'Date: ${formatDate(widget.date)}',
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Amount', overflow: TextOverflow.ellipsis),
                      value: 'Amount',
                      groupValue: selectedOption,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      activeColor: Colors.indigo,
                      onChanged:
                          (value) => setState(() {
                            selectedOption = value!;
                            errorText = null;
                          }),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text(
                        'Percentage',
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: 'Percentage',
                      groupValue: selectedOption,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      activeColor: Colors.indigo,
                      onChanged:
                          (value) => setState(() {
                            selectedOption = value!;
                            errorText = null;
                          }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              selectedOption == 'Amount'
                  ? TextField(
                    controller: tipAmountController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      icon: Icon(Icons.attach_money_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorText: errorText,
                    ),
                  )
                  : TextField(
                    controller: tipPercentageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter percentage',
                      icon: Icon(Icons.percent_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorText: errorText,
                    ),
                  ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ref
                    .read(setTipStateNotifierProvider.notifier)
                    .setTip(widget.id, 0.0, 0.0);
                context.pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: Text('No tip', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 30),
            ElevatedButton(
              onPressed: sendTip,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: Text('Send tip', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
