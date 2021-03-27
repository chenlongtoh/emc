import 'package:emc/constant.dart';
import 'package:flutter/material.dart';

class AcceptedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: EmcColors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1/1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: EmcColors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("12"),
                        Text("July"),
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sunday, 8am to 10am",
                      style: EmcTextStyle.listTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      "with Dr Rajesh",
                      overflow: TextOverflow.ellipsis,
                      style: EmcTextStyle.listSubtitle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/default_avatar.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
