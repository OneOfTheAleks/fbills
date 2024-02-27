


import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String? _column1;
  String? _column2;

    @override
  void initState() {
    super.initState();
    _column1 = '';
    _column2 = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Column 1'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              _column1 = value;
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Column 2'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              _column2 = value;
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final Database db = await openDatabase('my_database.db');
                await db.execute('INSERT INTO my_table (column1, column2) VALUES (?, ?)', [_column1, _column2]);
                await db.close();
              //  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Data saved')));
                _formKey.currentState?.reset();
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}