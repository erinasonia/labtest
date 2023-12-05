import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double bmi = 0.0;
  String bmiStatus = '';
  String gender = 'male';

  void _calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    setState(() {
      bmi = weight /(height * height/1000)*10;
      if (gender == 'male') {
        if (bmi < 18.5) {
          bmiStatus = 'Underweight. Careful during strong wind!';
        } else if (bmi >= 18.6 && bmi <= 24.9) {
          bmiStatus = 'Thats ideal! Please maintan';
        } else if (bmi >= 25 && bmi <= 29.9) {
          bmiStatus = 'Overweight! Work out please';
        } else {
          bmiStatus = 'Whoa Obese! Dangerous mate!';
        }
      }
      else if (gender == 'female'){
        if (bmi < 16) {
          bmiStatus = 'Underweight. Careful during strong wind!';
        } else
        if (bmi >= 17 && bmi <= 22) {
          bmiStatus = 'Thats ideal! Please maintan';
        } else

        if (bmi >= 23 && bmi <= 27) {
          bmiStatus = 'Overweight! Work out please';
        } else {
          bmiStatus = 'Whoa Obese! Dangerous mate!';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: const Text('BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.bold)),),
          backgroundColor: Colors.blue,),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Your Fullname',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height in cm ',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight in kg',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                  labelText:'Your BMI is: $bmi',
                ),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Male'),
                    SizedBox(width: 20.0),
                    Radio<String>(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: Text('Calculate BMI and Save'),
                ),
                Text(
                  '$bmiStatus',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            ),
        );
    }
}
