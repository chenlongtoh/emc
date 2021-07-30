import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constant.dart';

class ConnectedStudentCard extends StatelessWidget {
  final String imageUri;
  final String name;
  final num connectedTimestamp;
  final Function onIconTap;

  ConnectedStudentCard({
    this.imageUri,
    this.name,
    this.connectedTimestamp,
    this.onIconTap,
  });

  Widget _getConnectedSinceText() {
    String dateString = "-";
    if (connectedTimestamp != null) {
      final String date = DateFormat("dd/MM/yyyy").format(new DateTime.fromMillisecondsSinceEpoch(connectedTimestamp));
      dateString = "Connected since $date";
    }
    return Text(
      dateString,
      overflow: TextOverflow.ellipsis,
      style: EmcTextStyle.listSubtitle,
    );
  }

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
                backgroundImage:
                    imageUri?.isNotEmpty ?? false ? NetworkImage(imageUri) : AssetImage("assets/images/default_avatar.png"),
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
                    _getConnectedSinceText(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: onIconTap ?? () => null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
