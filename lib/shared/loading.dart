import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///Style for the loading wheel that is shown in the app
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.greenAccent,
          size: 50.0
        )
      )
    );
  }
}
