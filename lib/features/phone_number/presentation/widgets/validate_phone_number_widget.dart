import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './custom_textfields.dart';
import '../providers/validate_phone_number_state_notifier_provider.dart';

class ValidatePhoneNumberWidget extends ConsumerStatefulWidget {
  const ValidatePhoneNumberWidget({super.key});

  @override
  ConsumerState<ValidatePhoneNumberWidget> createState() =>
      _ValidatePhoneNumberWidgetState();
}

class _ValidatePhoneNumberWidgetState
    extends ConsumerState<ValidatePhoneNumberWidget> {
  TextEditingController numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  bool isVerifying = false;
  bool showCodeField = false;

  Future<void> handleRequest() async {
    setState(() => isVerifying = true);
    final number = numberController.text.trim();
    if (number.isEmpty) return;

    try {
      await ref
          .read(validatePhoneNumberStateNotifierProvider.notifier)
          .validatePhoneNumber(number);
      setState(() => showCodeField = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ocurrió un error inesperado')),
      );
    } finally {
      setState(() => isVerifying = false);
    }
  }

  void handleSecondAction() {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter the code')));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (_, constraints) {
          final isWide = constraints.maxWidth > 600;
          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: isWide ? 400 : double.infinity,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Iniciar sesión',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Número de teléfono',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (showCodeField) ...[
                      TextField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Código de verificación',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child:
                          isVerifying
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                onPressed:
                                    showCodeField
                                        ? handleSecondAction
                                        : handleRequest,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  showCodeField
                                      ? 'Segundo botón'
                                      : 'Primer botón',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Log in with your phone number',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: TextField(
//                 controller: numberController,
//                 decoration: textFieldDecoration(
//                   'Enter phone number',
//                   Icons.phone_iphone_outlined,
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//             SizedBox(height: 10),
//             if (showSecondTextField) ...[
//               TextField(
//                 controller: codeController,
//                 decoration: textFieldDecoration(
//                   'Enter the code you received',
//                   Icons.code_outlined,
//                 ),
//               ),
//             ],
//             if (temporaryMessage != null)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Text(
//                   temporaryMessage!,
//                   style: TextStyle(
//                     color:
//                         temporaryMessage == "Carga exitosa"
//                             ? Colors.green
//                             : Colors.red,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             if (isLoading)
//               const CircularProgressIndicator()
//             else if (requestCompleted)
//               ElevatedButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('Nuevo boton')));
//                 },
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Colors.indigo, Colors.purple],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Container(
//                     constraints: const BoxConstraints(
//                       minWidth: 100,
//                       minHeight: 50,
//                     ),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       "Continue",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               )
//             else
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: ElevatedButton(
//                   onPressed: handleRequest,
//                   style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
//                   child: Ink(
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Colors.indigo, Colors.purple],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: Container(
//                       constraints: const BoxConstraints(
//                         minWidth: 80,
//                         minHeight: 50,
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text(
//                         "Continue",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
