import 'package:flutter/cupertino.dart';

class Reusable extends StatelessWidget {
  Reusable({@required this.cardColor, this.cardChild});
  final Color cardColor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cardColor,
      ),
    );
  }
}

// class Reusable extends StatefulWidget {
//   Reusable({@required this.cardColor, this.cardChild});
//   final Color cardColor;
//   final Widget cardChild;
//
//   @override
//   _ReusableState createState() => _ReusableState();
// }
//
// class _ReusableState extends State<Reusable> {
//   get cardChild => cardChild;
//
//   get cardColor => cardColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: cardChild,
//       margin: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: cardColor,
//       ),
//     );
//   }
// }
