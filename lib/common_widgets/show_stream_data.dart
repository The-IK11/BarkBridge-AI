import 'package:flutter/material.dart';

import 'not_found_widget.dart';
import 'waiting_widget.dart';

Widget showStreamData({
  required AsyncSnapshot<dynamic> snapshot,
  required Widget child,
}) {
  if (snapshot.hasData) {
    return child;
  } else if (snapshot.connectionState == ConnectionState.waiting) {
    return const WaitingWidget();
  } else {
    return const NotFoundWidget();
  }
}
