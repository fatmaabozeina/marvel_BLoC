import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SpinKitRing(
          color: Color.fromRGBO(0, 116, 255, 1),
          size: 60,
        ),
      ),
    );
  }
}

void showLoading(BuildContext context) {
  print("context of $context");

  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false, // set to false
      pageBuilder: (_, __, ___) => Loading(),
    ),
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

class LoadMore extends StatelessWidget {
  const LoadMore({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(child: new CircularProgressIndicator()),
    );
  }
}
