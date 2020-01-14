import 'package:flutter/cupertino.dart';

class SystemPadding extends StatelessWidget {
  final Widget child;
  SystemPadding({Key key, @required this.child}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: 300),
      child: child);
  }
}
