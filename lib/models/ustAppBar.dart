import 'package:flutter/material.dart';

AppBar ustBar(
    {required BuildContext context,
    required String textYazisi,
    Widget? basIkon,
    List<Widget>? aksiyon}) {
  return AppBar(
    leading: basIkon,
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
