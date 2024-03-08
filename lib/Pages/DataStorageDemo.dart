import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataStorageDemo extends StatefulWidget {
  @override
  _DataStorageDemoState createState() => _DataStorageDemoState();
}

class _DataStorageDemoState extends State<DataStorageDemo> {
  TextEditingController _controller = TextEditingController();
  String _savedData = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void saveData(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savedData', value);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedData = prefs.getString('nomeEsercizio') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Storage Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter data',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                saveData(_controller.text);
                setState(() {
                  _savedData = _controller.text;
                });
              },
              child: Text('Save'),
            ),
            SizedBox(height: 20.0),
            Text('Saved Data: $_savedData'),
          ],
        ),
      ),
    );
  }
}
