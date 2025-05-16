import 'package:flutter/material.dart';
import 'package:move/features/map/data/models/create_request.dart';
import 'package:move/features/map/presentation/providers/providers.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/create_request_state_notifier_provider.dart';

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
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'SquareChannel',
            onMessageReceived: (message) async {
              final data = jsonDecode(message.message);
              token = data['token'];
              print('el token es $token');
              await sendRequest();
            },
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) {
                if (request.url == 'success://home') {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse('https://move.softdev.ar/public/index.html'));
  }

  Future<bool> sendRequest() async {
    final origin = ref.watch(originAddressProvider);
    if (origin == null) {
      // Mostramos un error o retornamos
      print('Origin is null');
      return false;
    }
    try {
      final destination = ref.watch(destinationAddressProvider);
      final distance = ref.watch(distanceProvider);
      final details = ref.watch(detailsProvider);
      final images = ref.watch(imagesProvider);

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
          placeIdTo: '',
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
          placeIdTo: '',
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
            2,
            2,
            tramos,
            payment,
            distance?.distance.toInt(),
            0,
            0,
            0,
          );

      await controller.runJavaScript("""
        document.getElementById("message").textContent = "✅ Solicitud creada con éxito";
        setTimeout(() => window.location.href = "success://home", 1000);
      """);
      return true;
    } catch (e) {
      await controller.runJavaScript("""
      document.getElementById("message").textContent = "❌ Error al crear la solicitud.";
    """);
      return false;
    } finally {
      await controller.runJavaScript("""
      document.getElementById("pay-button").classList.remove("hidden");
      document.getElementById("spinner").classList.add("hidden");
    """);
    }
  }

  @override
  Widget build(BuildContext context) {
    final requestsState = ref.watch(createRequestStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Insert a payment method')),
      body: WebViewWidget(controller: controller),
    );
  }
}
