import 'package:flutter/cupertino.dart';

class Reusable extends StatelessWidget {
  Reusable({@required this.cardColor, this.cardChild});
  final Color cardColor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cardColor,
      ),
    );
  }
}
