import 'package:flutter/cupertino.dart';
import 'system_padding.dart';

typedef TextValidatorCallback = bool Function(String);
typedef SubmitCallback = void Function(String);

class TextInputAlertDialog extends StatefulWidget {
  TextValidatorCallback textValidator;
  SubmitCallback onOK;

  String title;
  String body;
  String okActionTitle;
  String cancelActionTitle;
  String initialText;
  bool numericKeyboard;

  TextInputAlertDialog({
    Key key,
    TextValidatorCallback textValidator,
    @required this.title,
    @required this.body,
    this.okActionTitle,
    this.cancelActionTitle,
    this.initialText = "",
    this.numericKeyboard = false,
    @required this.onOK,
  }): super(key: key) {
    if(textValidator == null) {
      this.textValidator = (_) => true;
    } else {
      this.textValidator = textValidator;
    }
  }

  @override
  _TextInputAlertDialogState createState() => _TextInputAlertDialogState();

  static Future<void> show(BuildContext context, {
    TextValidatorCallback textValidator,
    @required String title,
    @required String body,
    String okActionTitle,
    String cancelActionTitle,
    @required SubmitCallback onOK,
    String initialText = "",
    bool numericKeyboard = false,
    }) async
  {
    showCupertinoDialog(context: context,
      builder: (BuildContext context) {
        return TextInputAlertDialog(
          textValidator: textValidator,
          title: title,
          okActionTitle: okActionTitle ?? "OK",
          cancelActionTitle: cancelActionTitle ?? "Cancel",
          body: body,
          initialText: initialText,
          numericKeyboard: numericKeyboard,
          onOK: onOK);
      });
  }
}

class _TextInputAlertDialogState extends State<TextInputAlertDialog> {
  String _buf;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    this._buf = this.widget.initialText;
    this._controller = TextEditingController(text: this.widget.initialText);
  }

  Widget _buildBody() {
    var _titleText1 = Text(this.widget.title,
      style: TextStyle(
        fontWeight: FontWeight.bold));

    var _paddedTitleText1 = Padding(padding: EdgeInsets.fromLTRB(4, 4, 4, 10), child: _titleText1);

    var _text1 = Text(this.widget.body);
    var _paddedText1 = Padding(padding: EdgeInsets.all(4), child: _text1);

    var _field1 = CupertinoTextField(
      autofocus: true,
      controller: this._controller,
      keyboardType: this.widget.numericKeyboard ? TextInputType.number : TextInputType.text,
      onChanged: (String msg) => setState(() { this._buf = msg; }),
    );
    var _paddedField1 = Padding(padding: EdgeInsets.all(4), child: _field1);

    var _addAction = CupertinoDialogAction(
      isDefaultAction: true,
      child: Text(this.widget.okActionTitle),
      onPressed: this.widget.textValidator(this._buf) ?
        () {
          this.widget.onOK(this._buf);
          Navigator.of(this.context).pop();
        } : null,
    );

    var _cancelAction = CupertinoDialogAction(
      child: Text(this.widget.cancelActionTitle),
      onPressed: () => Navigator.of(this.context).pop(),
    );

    var dialog = CupertinoAlertDialog(
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [
          _paddedTitleText1,
          _paddedText1,
          _paddedField1,
        ]),
      actions: <Widget>[
        _addAction,
        _cancelAction,
      ],
    );

    var padding = SystemPadding(child: dialog);
    return padding;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
