import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move/features/map/data/models/create_request.dart';
import 'package:move/features/map/presentation/providers/providers.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/create_request_state_notifier_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SquarePaymentWidget extends ConsumerStatefulWidget {
  const SquarePaymentWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SquarePaymentWidgetState();
}

class SquarePaymentWidgetState extends ConsumerState<SquarePaymentWidget> {
  late final WebViewController controller;
  String token = '';

  @override
  void initState() {
    super.initState();

    initializeWebPayment();
  }

  void initializeWebPayment() async {
    try {
      controller =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..addJavaScriptChannel(
              'SquareChannel',
              onMessageReceived: (message) async {
                final data = jsonDecode(message.message);
                setState(() {
                  token = data['token'];
                });
                await sendRequest();
              },
            )
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (request) {
                  if (request.url == 'success://home') {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(
              Uri.parse('https://move.softdev.ar/public/index.html'),
            );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error ocurred while creating your request. Try again later',
          ),
        ),
      );
      return;
    }
  }

  Future<bool> sendRequest() async {
    final origin = ref.watch(originAddressProvider);

    if (origin == null) {
      print('Origin is null');
      return false;
    }
    try {
      final destination = ref.watch(destinationAddressProvider);
      final distance = ref.watch(distanceProvider);
      final details = ref.watch(detailsProvider);
      final images = ref.watch(imagesProvider);
      final vehicleId = ref.watch(vehicleProvider);
      final originId = ref.watch(originPlaceId);
      final destinationId = ref.watch(destinationPlaceId);

      final payment = Payment(paymentMethodId: 1, token: token);

      List<Imagenes> imagesList = [
        Imagenes(
          nombre: images.nombre,
          mimeType: images.mimeType,
          data: images.data,
        ),
      ];

      List<Tramos> tramos = [
        Tramos(
          nroTramo: 0,
          existingTo: 0,
          aliasTo: '',
          streetTo: origin.street,
          cpTo: origin.postalCode,
          cityTo: origin.city,
          numberTo: origin.number,
          countryTo: origin.country,
          florNummberTo: '',
          stateTo: origin.state,
          descriptionTo: details.description,
          placeIdTo: originId,
          latTo: origin.latitude,
          longTo: origin.longitude,
          longDirectionTo: '',
          nroRemito: '',
          tamanioCarga: 1,
          pesoCarga: 1,
          acotacionesCarga: '',
          imagenes: imagesList,
        ),
        Tramos(
          nroTramo: 1,
          existingTo: 0,
          aliasTo: '',
          streetTo: destination!.street,
          cpTo: destination.postalCode,
          cityTo: destination.city,
          numberTo: destination.number,
          countryTo: destination.country,
          florNummberTo: '',
          stateTo: destination.state,
          descriptionTo: details.description,
          placeIdTo: destinationId,
          latTo: destination.latitude,
          longTo: destination.longitude,
          longDirectionTo: '',
          nroRemito: '',
          tamanioCarga: 1,
          pesoCarga: 1,
          acotacionesCarga: '',
          imagenes: imagesList,
        ),
      ];

      await ref
          .read(createRequestStateNotifierProvider.notifier)
          .createRequest(
            1,
            '',
            origin.street,
            origin.postalCode,
            origin.city,
            origin.number,
            origin.country,
            '',
            origin.state,
            '',
            '',
            origin.latitude,
            origin.longitude,
            '',
            details.description,
            details.startDate,
            details.startTime,
            '',
            vehicleId,
            2,
            tramos,
            payment,
            distance?.distance.toInt(),
            0,
            0,
            0,
          );

      await Fluttertoast.showToast(
        msg: '✅ Request created successfully',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER,
        backgroundColor: const Color.fromARGB(255, 103, 188, 107),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      context.go(HomeScreen.path);

      // await controller.runJavaScript("""
      //   document.getElementById("message").textContent = "✅ Request created successfully";
      //   setTimeout(() => {
      //     document.getElementById("message").classList.add("hide");
      //   }, 3000);""");
      return true;
    } catch (e) {
      await Fluttertoast.showToast(
        msg: '❌ Error while creating request',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER,
        backgroundColor: const Color.fromARGB(255, 203, 108, 108),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      //   await controller.runJavaScript("""
      //   document.getElementById("message").textContent = "❌ Error al crear la solicitud.";
      // """);
      return false;
    } finally {
      await controller.runJavaScript(
        """document.getElementById("spinner").classList.add("hidden");""",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text('Insert a payment method'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [Expanded(child: WebViewWidget(controller: controller))],
      ),
    );
  }
}
