import 'package:flutter/material.dart';
import 'package:lamp_platform_code/controller/lamp_controller.dart';
import 'package:lamp_platform_code/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LampController(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LampController>(
      builder: (context, controller, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: controller.turnOn ? Brightness.light : Brightness.dark,
            scaffoldBackgroundColor:
                controller.turnOn ? Colors.grey[400] : Colors.grey[800],
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
