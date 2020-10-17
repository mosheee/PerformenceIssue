import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home : MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Widget> listOfTextFields;
  Map<String, bool> map = {};
  final _formKey = GlobalKey<FormState>();
  String place = '';
  TextEditingController placeController;
  final int numberOfPlayers = 10 ; // data which need to pass to this screen

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0XFF10C911),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'the place',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: placeController,
                      onChanged: (value) {
                        place = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'enter the name of the place',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                )),
            Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFF262B32),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'בחר מרגלים',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Color(0XFF262B32),
                        child: Form(
                          key: _formKey,
                          child: ListView.builder(
                            itemCount: numberOfPlayers,
                            itemBuilder: (context, int index) {
                              return
                                NameForListTile(
                                number: index + 1,
                                mapForList: map,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: RaisedButton(
                        child: Text('next'),
                        onPressed: () {
                          map.clear();
                          if (place != '') {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // Navigator to the next page and pass map
                            }
                          } else {
                            placeController.text = 'please enter place';
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class NameForListTile extends StatefulWidget {
  final int number;
  Map<String, bool> mapForList = {};
  NameForListTile(
      {@required this.number, @required this.mapForList});
  @override
  _NameForListTileState createState() => _NameForListTileState();
}

class _NameForListTileState extends State<NameForListTile> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        activeColor: Color(0XFF10C911),
        value: check,
        onChanged: (newValue) {
          setState(() {
            check = newValue;
          });
        },
        title: TextFormField(
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'enter name ${widget.number}',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
            validator: (input) => input == '' ? 'please enter a name' : null,
            onSaved: (input) {
              widget.mapForList[input] = check;
            }));
  }
}
