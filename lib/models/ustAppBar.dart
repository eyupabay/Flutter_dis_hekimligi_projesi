import 'package:flutter/material.dart';

AppBar ustBar(
    {required BuildContext context,
    required String textYazisi,
    List<Widget>? aksiyon}) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.shadowColor,
    title: Center(
      child: Text(
        textYazisi,
        textAlign: TextAlign.center,
      ),
    ),
    actions: aksiyon,
  );
}
