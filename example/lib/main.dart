import 'package:flutter/material.dart';

import 'package:sunmi_lamp_service/sunmi_lamp_service.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Sunmi Lamp'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('LOOP TYPE'),
          Row(
            children: <Widget>[
              Expanded(
                child: AppButton(
                  color: Colors.red,
                  title: 'RED LOOP',
                  onPressed: () => loop('Led-1'),
                ),
              ),
              Expanded(
                child: AppButton(
                  color: Colors.green,
                  title: 'GREEN LOOP',
                  onPressed: () => loop('Led-2'),
                ),
              ),
              Expanded(
                child: AppButton(
                  color: Colors.blue,
                  title: 'BLUE LOOP',
                  onPressed: () => loop('Led-3'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('SINGLE TYPE'),
          Row(
            children: <Widget>[
              Expanded(
                child: AppButton(
                  color: Colors.red,
                  title: 'RED SINGLE',
                  onPressed: () => single('Led-1'),
                ),
              ),
              Expanded(
                child: AppButton(
                  color: Colors.green,
                  title: 'GREEN SINGLE',
                  onPressed: () => single('Led-2'),
                ),
              ),
              Expanded(
                child: AppButton(
                  color: Colors.blue,
                  title: 'BLUE SINGLE',
                  onPressed: () => single('Led-3'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            color: Colors.deepPurple,
            title: 'CLOSE ALL',
            onPressed: closeAllLamp,
          ),
        ],
      ),
    );
  }

  void _showError(dynamic e) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: SingleChildScrollView(child: Text(e.toString())),
          actions: [
            AppButton(
              title: 'OK',
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );

  Future<void> loop(String data) async {
    try {
      await SunmiLampService.startForLoop(1, data);
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> single(String data) async {
    try {
      await SunmiLampService.startForSigle(1, data);
    } catch (e) {
      _showError(e);
    }
  }

  Future<void> closeAllLamp() async {
    try {
      await SunmiLampService.closeAllLamp();
    } catch (e) {
      _showError(e);
    }
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key key,
    this.onPressed,
    this.title,
    this.color,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      borderSide: BorderSide(color: color, width: 1),
      child: Text(
        title,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
