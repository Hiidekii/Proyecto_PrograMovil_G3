import 'dart:convert';
import 'package:image/image.dart' as img;

Future<String> compressBase64Image(String base64Image) async {
  // 1. Decodifica el Base64 a bytes
  final bytes = base64Decode(base64Image);

  // 2. Decodifica los bytes a una imagen
  final image = img.decodeImage(bytes);

  if (image == null) {
    throw Exception("No se pudo decodificar la imagen.");
  }

  // 3. Comprime la imagen (ajusta la calidad según tus necesidades)
  final compressedImage =
      img.encodeJpg(image, quality: 30); // Calidad de 0 a 100

  // 4. Convierte la imagen comprimida de nuevo a Base64
  final compressedBase64 = base64Encode(compressedImage);

  return compressedBase64;
}
