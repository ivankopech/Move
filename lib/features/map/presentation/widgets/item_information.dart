import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:mime/mime.dart';
import 'package:move/features/map/presentation/providers/providers.dart';
import 'package:path_provider/path_provider.dart';

import '../screens/payment_input.dart';

class ItemInformation extends ConsumerStatefulWidget {
  const ItemInformation({super.key});

  @override
  ConsumerState<ItemInformation> createState() => _ItemInformationState();
}

class _ItemInformationState extends ConsumerState<ItemInformation> {
  TextEditingController controller = TextEditingController();
  final List<XFile> images = [];
  final ImagePicker picker = ImagePicker();

  Future<Map<String, dynamic>> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        images.add(image);
      });
      // Cargar la imagen seleccionada
      File originalImage = File(image.path);
      List<int> bytes = await originalImage.readAsBytes();

      // Convertir la imagen a PNG usando el paquete 'image'
      img.Image? decodedImage = img.decodeImage(Uint8List.fromList(bytes));
      if (decodedImage != null) {
        // Convertir la imagen a PNG
        List<int> pngBytes = img.encodePng(decodedImage);

        // Obtener el directorio de almacenamiento
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath =
            '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
        File file = File(filePath);

        // Guardar la imagen como un archivo PNG
        await file.writeAsBytes(pngBytes);

        String? fileName = file.uri.pathSegments.last;

        // Obtener MIME type
        String? mimeType = lookupMimeType(file.path);

        // Convertir los bytes PNG a Base64
        String base64Data = base64Encode(pngBytes);

        print(fileName);
        print(mimeType);
        print(base64Data);
        // Retornar el nombre del archivo, MIME type y los datos en Base64
        ref.read(imagesProvider.notifier).setName(fileName);
        ref.read(imagesProvider.notifier).setMimeType(mimeType!);
        ref.read(imagesProvider.notifier).setData(base64Data);
      }
    }
    return {};
  }

  // Future<void> pickImage(ImageSource source) async {
  //   final XFile? image = await picker.pickImage(source: source);
  //   if (image != null) {
  //     setState(() {
  //       images.add(image);
  //     });
  //   }
  // }

  void showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.of(context).pop();
                    pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isFormFilled = controller.text.trim().isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('What would you like to move?')),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(15),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText:
                      'Let us know what items you\'re moving and how many of each, for example, "a table and two chairs"',
                  border: InputBorder.none,
                ),
                maxLines: null,
                minLines: 5,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: showImageSourceDialog,
                      child: SizedBox(
                        height: 120,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.purple,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add receipt or photos',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (images.isNotEmpty)
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(images[index].path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () => removeImage(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 200),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: ElevatedButton(
                onPressed: () async {
                  ref
                      .read(detailsProvider.notifier)
                      .setDescription(controller.text);
                  await context.push<Map<String, String>>(PaymentScreen.path);
                },
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),

                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      minHeight: 50,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
