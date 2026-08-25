import 'package:flutter/material.dart';

import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final app = await bootstrap();
  runApp(app);
}
