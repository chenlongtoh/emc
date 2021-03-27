import 'package:flutter/material.dart';
import 'package:emc/constant.dart';

class EmcScaffold extends StatelessWidget {
  final AppBar appBar;
  final bool maskBackground;
  final FloatingActionButton floatingActionButton;
  @required
  final Widget body;
  EmcScaffold({this.appBar, this.maskBackground = true, this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: maskBackground
              ? Container(
                  decoration: BoxDecoration(
                    color: EmcColors.whiteOverlay,
                  ),
                  constraints: BoxConstraints.expand(),
                  child: body,
                )
              : body,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
