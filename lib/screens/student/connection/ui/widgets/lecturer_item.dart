import 'package:emc/constant.dart';
import 'package:emc/screens/student/connection/constant.dart';
import 'package:flutter/material.dart';

class LecturerItem extends StatelessWidget {
  final String imageUri;
  final String name;
  final String qualification;
  final Widget trailingWidget;

  const LecturerItem({
    Key key,
    this.imageUri,
    this.name,
    this.qualification,
    this.trailingWidget,
  }) : super(key: key);

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
              child: CircleAvatar(
                radius: 30,
                backgroundImage: imageUri != null ? NetworkImage(imageUri) : AssetImage("assets/images/default_avatar.png"),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "-",
                      style: EmcTextStyle.listTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      qualification ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: EmcTextStyle.listSubtitle,
                    ),
                  ],
                ),
              ),
            ),
            if (trailingWidget != null)
              Expanded(
                flex: 3,
                child: trailingWidget,
                // child: Text(
                //   isConnected ? "Connected" : "Pending",
                //   style: isConnected
                //       ? TextStyle(
                //           color: Colors.green,
                //         )
                //       : null,
                // ),
              )
          ],
        ),
      ),
    );
  }
}
