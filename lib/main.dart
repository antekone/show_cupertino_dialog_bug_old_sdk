import 'package:flutter/cupertino.dart';
import 'text_input_alert_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void showCupertinoDlg() {
    TextInputAlertDialog.show(context, title: "Title", body: "Body", onOK: (t) {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: _incrementCounter,
          child: Icon(CupertinoIcons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the "plus" button this many times:'),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Text('Hit this button to show a Cupertino dialog:'),
            CupertinoButton(
              onPressed: () => {
                this.showCupertinoDlg()
              },
              color: CupertinoColors.activeBlue,
              child: Text("Press me")
            )
          ],
        ),
      ),
    );
  }
}
