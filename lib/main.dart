import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

void main() => runApp(MyFlutterApp());

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Interest Calculator",
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          accentColor: Colors.white),
    );
  }
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Taka', 'Rupee', 'Dollar', 'Pound'];
  var _currentSelectedItem = '';
  var _minimumPadding = 5.0;

  void initState() {
    super.initState();
    _currentSelectedItem = _currencies[0];
  }

  TextEditingController principle = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController term = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getimageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principle,
                    validator: (String value) {
                      if (value.isEmpty) return 'Please Enter Principle Amount';
                    },
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter Principle e.g. 12000',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: interest,
                    validator: (String value) {
                      if (value.isEmpty) return 'Please Enter Interest Rate';
                    },
                    decoration: InputDecoration(
                        labelText: 'Interest Rate',
                        hintText: 'Enter Interest Rate in Parcentage',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(fontSize: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: term,
                        validator: (String value) {
                          if (value.isEmpty) return 'Please Enter Term';
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Enter in Years',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(fontSize: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                      )),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currencies.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        value: _currentSelectedItem,
                        onChanged: (String newValuesSelected) {
                          _onDropDownSelected(newValuesSelected);
                        },
                      )),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.green,
                            child: Text(
                              'Calculate',
                              style: textStyle,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayResult = _calculateReturn();
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          width: _minimumPadding,
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'Reset',
                              style: textStyle,
                            ),
                            onPressed: () {
                              setState(() {
                                _resetButton();
                              });
                            },
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 3),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getimageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownSelected(String newValuesSelected) {
    setState(() {
      this._currentSelectedItem = newValuesSelected;
    });
  }

  String _calculateReturn() {
    double principleValue = double.parse(principle.text);
    double interestValue = double.parse(interest.text);
    int termValue = int.parse(term.text);

    double total =
        (principleValue + (principleValue * interestValue * termValue) / 100);
    String result =
        'After $termValue years, your investment will be worth $total $_currentSelectedItem';

    return result;
  }

  void _resetButton() {
    principle.text = '';
    interest.text = '';
    term.text = '';
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}
