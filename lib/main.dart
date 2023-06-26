
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'common/common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pregcontroller = TextEditingController();
    TextEditingController glucosecontroller = TextEditingController();
    TextEditingController bpcontroller = TextEditingController();
    TextEditingController skincontroller = TextEditingController();
    TextEditingController insulincontroller = TextEditingController();
    TextEditingController bmicontroller = TextEditingController();
    TextEditingController dpfcontroller = TextEditingController();
    TextEditingController agecontroller = TextEditingController();

    String pred = '';


    rebuild() {
      if (mounted) {
        setState(() {});
      }
    }

    void predresult() async {
      var body = {
        "Pregnancies": int.parse(pregcontroller.text),
        "Glucose": int.parse(glucosecontroller.text),
        "BloodPressure": int.parse(bpcontroller.text),
        "SkinThickness": int.parse(skincontroller.text),
        "Insulin": int.parse(insulincontroller.text),
        "BMI": double.parse(bmicontroller.text),
        "DiabetesPedigreeFunction": double.parse(dpfcontroller.text),
        "Age": int.parse(agecontroller.text)
      };
      Common().postMap("predict", body, (data) {
        print(data);
        pred = data['prediction'];
        Get.snackbar("Result ", pred,
            backgroundColor: const Color(0xff252323),
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        rebuild();
      }, (errorCallback) {
        pred = 'Error occurred';
        Get.snackbar("Result ", pred,
            backgroundColor: const Color(0xff252323),
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        rebuild();
      });
    }
    bool _datavalidation() {
      if (pregcontroller.text.trim() == '') {
        Get.snackbar("Pregnancie's ", "Enter number of pregnancie's",
            backgroundColor: const Color(0xff252323),
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (glucosecontroller.text.trim() == '') {
        Get.snackbar("Glucose", "enter Glucose Level",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (bpcontroller.text.trim() == '') {
        Get.snackbar("Blood Pressure", "enter Bp Level",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (skincontroller.text.trim() == '') {
        Get.snackbar("Skin Thickness", "enter Skin thickness Level",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (insulincontroller.text.trim() == '') {
        Get.snackbar("Insulin", "enter Insulin Level",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (bmicontroller.text.trim() == '') {
        Get.snackbar("Body Mass Index", "enter BMI Value",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (dpfcontroller.text.trim() == '') {
        Get.snackbar(
            "DiabetesPedigreeFunction", "enter DiabetesPedigreeFunction Value",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else if (agecontroller.text.trim() == '') {
        Get.snackbar("Age", "enter Age ",
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30));
        return false;
      } else {
        return true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: pregcontroller,
                decoration: const InputDecoration(
                  labelText: 'Pregnancies',
                ),
              ),
              TextField(
                controller: glucosecontroller,
                decoration: const InputDecoration(labelText: 'Glucose'),
              ),
              TextField(
                controller: bpcontroller,
                decoration: const InputDecoration(labelText: 'Blood Pressure'),
              ),
              TextField(
                controller: skincontroller,
                decoration: const InputDecoration(labelText: 'Skin Thickness'),
              ),
              TextField(
                controller: insulincontroller,
                decoration: const InputDecoration(labelText: 'Insulin'),
              ),
              TextField(
                controller: bmicontroller,
                decoration: const InputDecoration(labelText: 'Bmi'),
              ),
              TextField(
                controller: dpfcontroller,
                decoration: const InputDecoration(
                    labelText: 'DiabetesPedigreeFunction'),
              ),
              TextField(
                controller: agecontroller,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // if (_datavalidation() == true) {
                    //   predresult();
                    // }
                    predresult();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Check ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}