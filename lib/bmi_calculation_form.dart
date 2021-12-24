import 'dart:math';
import 'package:flutter/material.dart';

class BmiCalculatorForm extends StatefulWidget {
  const BmiCalculatorForm({Key? key}) : super(key: key);

  @override
  _BmiCalclatorFormState createState() => _BmiCalclatorFormState();
}

class _BmiCalclatorFormState extends State<BmiCalculatorForm> {
  final _heightController = TextEditingController();
  final _wightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double bmiValue = 0;

  String neededWieghtValue = '';

  // ignore: non_constant_identifier_names
  double BMICalculator(double height, double weight) {
    double bmiValue = weight / pow(height, 2);
    return bmiValue;
  }

  String neededWeight(double bmi, double? height, double? weight) {
    if (height == null || weight == null) {
      return 'enter a value ';
    }
    if (bmi < 18) {
      double neededBmiIncrease = 18 - bmi;
      double neededWeight = neededBmiIncrease * pow(height / 100, 2);
      return 'under weight your weight need to increase by ${(neededWeight * 100).round() / 100.0} Kg';
    }
    if (bmi > 25) {
      double neededBmiDecrease = bmi - 25;
      var neededWeight = neededBmiDecrease * pow(height / 100, 2);
      return 'over weight your weight need to decrease by ${(neededWeight * 100).round() / 100.0} Kg';
    }
    if (bmi == 0) {
      return '';
    }
    return 'normal weight';
  }

  @override
  Widget build(BuildContext context) {
    //make a form for calculation the bmi
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3E8EE),
        appBar: AppBar(
          title: const Text(
            'BMI',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'ElMesssiri',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFCF7FF),
          shadowColor: Colors.white,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/Bmi.png'),
                    radius: 80,
                  )),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: _textField(
                                    _heightController, 'enter your height...',
                                    (value) {
                                  if (value.isEmpty||value==0) {
                                    return 'enter a number ';
                                  }
                                  return null;
                                })),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _textField(
                                  _wightController, 'enter your weight...',
                                  (value) {
                                if (value.isEmpty||value==0) {
                                  return 'enter a number ';
                                }
                                return null;
                              }),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xFF211940),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                offset: Offset(7, 7))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50.0, bottom: 10),
                              child: Text(
                                '${(bmiValue * 100).round() / 100.0}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 50.0, top: 10, left: 10, right: 9),
                              child: Text(
                                neededWieghtValue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'ElMesssiri',
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  bmiValue = BMICalculator(
                                      double.parse(_heightController.text) /
                                          100,
                                      double.parse(_wightController.text));
                                  neededWieghtValue = neededWeight(
                                      bmiValue,
                                      double.parse(_heightController.text),
                                      double.parse(_wightController.text));
                                } on FormatException {
                                  bmiValue = 0;
                                  neededWieghtValue =
                                      'enter your height and weight as Numbers ';
                                }
                              } else {
                                bmiValue = 0;
                                neededWieghtValue =
                                    'enter your height and weight';
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                right: 50.0, left: 50.0, top: 15, bottom: 15),
                            child: Text('calculate'),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController textEditingController,
      String labelText, validation) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      validator: validation,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(color: Colors.blue, width: 3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          )),
    );
  }
}
