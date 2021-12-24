import 'package:flutter/material.dart';
import 'bmi_calculation_form.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashScreenFunction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
            child: Image.asset(
      'assets/Bmi2.png',
    )));
  }
}

_splashScreenFunction(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 1500), () {});
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (c) => const BmiCalculatorForm()));
}
