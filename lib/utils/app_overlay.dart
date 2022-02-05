import 'package:flutter/material.dart';

class AppOverlay {
  static show(context, {Widget? child}) {
    child ??= const CircularProgressIndicator();
    showDialog(
      context: context,
      ///if outside of scaffold, we need to wrap material widget
      builder: (context) => Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.black.withOpacity(.1),
          child: child,
        ),
      ),
    );
  }

  static pop(context) => Navigator.pop(context);
}
