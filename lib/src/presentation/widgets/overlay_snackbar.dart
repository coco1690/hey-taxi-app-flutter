import 'package:flutter/material.dart';

class CustomSnackbar {
  final BuildContext context;
  late OverlayEntry _overlayEntry;

  CustomSnackbar(this.context);

  void show({
    required String message,
    Color backgroundColor = Colors.black87,
    TextStyle textStyle = const TextStyle(color: Colors.white),
    Duration duration = const Duration(seconds: 3),
    EdgeInsets padding = const EdgeInsets.all(50.0),
    // BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    double topOffset = 0,
  }) {
    // Crear el OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: topOffset,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
           
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              // borderRadius: borderRadius,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Text(
              message,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    // Insertar el OverlayEntry
    Overlay.of(context).insert(_overlayEntry);

    // Quitar el OverlayEntry después de la duración
    Future.delayed(duration, () {
      _overlayEntry.remove();
    });
  }
}
