import 'package:emc/constant.dart';
import 'package:flutter/material.dart';

class LecturerItem extends StatelessWidget {
  final String imageUri;
  final String name;
  final String qualification;
  final Widget trailingWidget;
  final Function onTap;

  const LecturerItem({
    this.imageUri,
    this.name,
    this.qualification,
    this.trailingWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => null,
      child: Container(
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
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: trailingWidget,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
