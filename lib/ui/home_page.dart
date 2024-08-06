import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamp_platform_code/controller/lamp_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LampController>(
        builder: (context, controller, child) {
          return Center(
            child: GestureDetector(
              onTap: () {
                controller.toggleLamp();
              },
              child: Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: AvatarGlow(
                  startDelay: const Duration(milliseconds: 100),
                  glowColor:
                      controller.turnOn ? Colors.white54 : Colors.grey.shade500,
                  glowShape: BoxShape.circle,
                  animate: controller.turnOn,
                  glowRadiusFactor: 0.3,
                  curve: Curves.fastEaseInToSlowEaseOut,
                  child: controller.turnOn
                      ? const Icon(
                          CupertinoIcons.lightbulb_fill,
                          size: 60,
                          color: Colors.white,
                        )
                      : Icon(
                          CupertinoIcons.lightbulb,
                          size: 60,
                          color: Colors.grey.shade900,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
