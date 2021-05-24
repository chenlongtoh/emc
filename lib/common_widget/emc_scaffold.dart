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
    return Stack(
      children: [
        SingleChildScrollView(
          child: Image.asset(
              "assets/images/background-2.jpg",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: SafeArea(
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
          floatingActionButton: floatingActionButton,
        ),
      ],
    );
  }
}
