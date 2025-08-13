import 'package:experiments/reusable_widget/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  const BottomNavigationBarWidget() ));
      }
    );
    return const Center(
      child: FlutterLogo(
        size: 60,
      ),
    );
  }
}