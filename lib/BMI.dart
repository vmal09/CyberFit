import 'package:cf/FFMI.dart';
import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<BMI> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = '';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Enter Height & Weight';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      var weight = double.parse(weightController.text);
      var height = double.parse(heightController.text) / 100;
      var imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = 'Under Weight (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Ideal Weight (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Slightly Overweight (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesity Degree I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesity Degree I II (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        _infoText = 'Obesity Degree I III (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  static const _colorDefault = Color.fromARGB(255, 0, 0, 0);
  static const _colorFields = Color.fromARGB(255, 45, 126, 255);
  static const _colorBackground = Color.fromARGB(255, 214, 198, 56);
  static const _colorLight = Color.fromARGB(255, 0, 0, 0);

  final kLabelStyle = TextStyle(
    color: _colorDefault,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  final kLightLabelStyle = TextStyle(
    color: _colorLight,
    fontSize: 20,
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: _colorFields,
    borderRadius: BorderRadius.circular(50),
    boxShadow: [
      BoxShadow(color: _colorDefault, spreadRadius: .2),
    ],
  );

  final _snackBar = SnackBar(
    backgroundColor: Colors.red,
    duration: Duration(seconds: 3),
    content: Text(
      'Fill in the empty field.',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    ),
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildSizedBox() => Divider(
        color: _colorDefault,
        thickness: 1.5,
        indent: 75,
        endIndent: 75,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _colorBackground,
      appBar: AppBar(
        title: Text('BMI calculator', style: kLabelStyle),
        centerTitle: true,
        backgroundColor: _colorFields,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FFMI()),
              );
            },
            icon: Icon(Icons.no_food, color: _colorDefault),
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: _colorDefault),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 100,
                color: _colorLight,
              ),
              _buildSizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  Text(
                    'Weight (kg)',
                    style: kLabelStyle,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                    decoration: kBoxDecorationStyle,
                    child: TextFormField(
                      style: kLightLabelStyle,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: weightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Height (cm)',
                    style: kLabelStyle,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                    decoration: kBoxDecorationStyle,
                    child: TextFormField(
                      style: kLightLabelStyle,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: heightController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              _buildSizedBox(),
              SizedBox(height: 16),
              Container(
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _colorFields,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(
                        width: 1.5,
                        color: _colorDefault,
                      ),
                    ),
                  ),
                  child: Text(
                    'Calculate',
                    style: kLabelStyle,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculate();
                    }
                  },
                ),
              ),
              SizedBox(height: 24),
              Text(
                _infoText,
                style: kLabelStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
