import 'package:flutter/material.dart';

class FFMI extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FFMI> {
  TextEditingController bfpController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = '';

  void _resetFields() {
    bfpController.text = '';
    bmiController.text = '';
    setState(() {
      _infoText = 'Enter (BFP) & (BMI)';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      var bfp = double.parse(bfpController.text);
      var bmi = double.parse(bmiController.text) / 100;
      var ffmi = bmi * (bfp * 10);
      print(ffmi);
      if (ffmi < 18.0) {
        _infoText = 'Below Average (${ffmi.toStringAsPrecision(4)})';
      } else if (ffmi >= 18.0 && ffmi < 28.0) {
        _infoText = 'Average (${ffmi.toStringAsPrecision(4)})';
      } else if (ffmi >= 28.0 && ffmi < 38.0) {
        _infoText = 'Above Average (${ffmi.toStringAsPrecision(4)})';
      } else if (ffmi >= 38.0 && ffmi < 48.0) {
        _infoText = 'Excellent (${ffmi.toStringAsPrecision(4)})';
      } else if (ffmi >= 48.0 && ffmi < 58.0) {
        _infoText = 'Superior (${ffmi.toStringAsPrecision(4)})';
      } else if (ffmi >= 58.0) {
        _infoText = 'Abnormal (${ffmi.toStringAsPrecision(4)})';
      }
    });
  }

  static const _colorDefault = Color.fromARGB(255, 0, 0, 0);
  static const _colorFields = Color.fromARGB(255, 214, 198, 56);
  static const _colorBackground = Colors.blue;
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
        title: Text('FFMI Calculator', style: kLabelStyle),
        centerTitle: true,
        backgroundColor: _colorFields,
        actions: <Widget>[
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
                Icons.no_food,
                size: 100,
                color: _colorLight,
              ),
              _buildSizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  Text(
                    'Body Fat Percentage (%)',
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
                      controller: bfpController,
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
                    'Body Mass Index (BMI)',
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
                      controller: bmiController,
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
