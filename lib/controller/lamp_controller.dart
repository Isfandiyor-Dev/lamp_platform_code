// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LampController extends ChangeNotifier {
  bool _turnOn = false; 

  static const platform = MethodChannel("com.device.lamp_control/lamp");

  bool get turnOn => _turnOn;

  Future<void> toggleLamp() async {
    try {
      _turnOn = !_turnOn;
      final bool result = await platform.invokeMethod(
        "toggleLamp",
        {"turnOn": turnOn},
      );
      print('Lamp is now ${result ? 'ON' : 'OFF'}');
    } on PlatformException catch (e) {
      print("Failed to toggle lamp: '${e.message}'.");
    }
    notifyListeners();
  }
}
