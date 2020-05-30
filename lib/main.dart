import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
    );
  }
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();

  Widget getImageAsset(_path) {
    AssetImage assetImage = AssetImage(_path);
    Image logo = Image(image: assetImage, width: 125, height: 125);
    return Container(child: logo);
  }

  var _currentValue = 'Naira';
  var _currencies = ['Naira', 'Dollars', 'Pounds', 'Others'];

  // collect input from text field
  TextEditingController principalC = TextEditingController();
  TextEditingController interestC = TextEditingController();
  TextEditingController termC = TextEditingController();

  void _reset() {
    principalC.text = '';
    interestC.text = '';
    termC.text = '';

    displayText = '';
    _currentValue = _currencies[0];
  }

  String _calculateReturn() {
    // parse text input to double
    double principal = double.parse(principalC.text);
    double interest = double.parse(interestC.text);
    double term = double.parse(termC.text);

    double amount = principal + (principal * interest * term) / 100;

    String result =
        'After $term years, your amount payable is $amount $_currentValue';
    return result;
  }

  String displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: Icon(Icons.monetization_on),
          title: Text("Simple Intrest App"),
          actions: <Widget>[Icon(Icons.laptop_mac)],
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(children: <Widget>[
                  getImageAsset('images/money.png'),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Principal';
                          }
                        },
                        controller: principalC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Principal",
                            hintText: "eg 1200",
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Interest';
                            }
                          },
                          controller: interestC,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Interest",
                              hintText: "in percent",
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))))),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Term';
                                  }
                                },
                                controller: termC,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: "Term",
                                    hintText: 'In years',
                                    errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))))),
                        Container(
                          width: 30,
                        ),
                        Expanded(
                            child: DropdownButton(
                          items: _currencies.map((String dropDownItem) {
                            return DropdownMenuItem(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          onChanged: (selectedValue) {
                            setState(() {
                              _currentValue = selectedValue;
                            });
                          },
                          value: _currentValue,
                          hint: Text('Select Currency'),
                        )),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Text("Calculate"),
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    this.displayText = _calculateReturn();
                                  });
                                }
                              },
                            ),
                          ),
                          Expanded(
                              child: RaisedButton(
                            child: Text("Reset"),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ))
                        ],
                      )),
                  Text(this.displayText)
                ]))));
  }
}
