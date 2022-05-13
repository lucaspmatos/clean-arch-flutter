import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'package:clean_arch/app_module.dart';
import 'package:clean_arch/app_widget.dart';

void main() {
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
