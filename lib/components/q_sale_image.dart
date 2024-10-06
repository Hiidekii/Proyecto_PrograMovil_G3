import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Importa Cupertino para los íconos

class QSaleImage extends StatelessWidget {
  final String imgUrlString;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit imgScale;

  const QSaleImage({
    super.key,
    this.imgUrlString = 'https://picsum.photos/200/200',
    this.height = 100.0,
    this.width = 100.0,
    this.borderRadius = 10.0,
    this.imgScale = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: FadeInImage(
          placeholder: const AssetImage('assets/placeholder.png'),
          image: NetworkImage(imgUrlString),
          width: width,
          height: height,
          fit: imgScale,
          imageErrorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300], // Fondo gris
              child: const Icon(
                CupertinoIcons.photo,
                color: Colors.grey,
                size: 20.0,
              ),
            );
          },
          fadeInDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
