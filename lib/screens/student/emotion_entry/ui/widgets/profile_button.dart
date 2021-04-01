import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final Function onTap;
  final bool darkStyle;
  ProfileButton({this.onTap, this.darkStyle = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Text(
              "Profile",
              style: darkStyle
                  ? TextStyle(
                      color: Colors.black,
                    )
                  : null,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward,
              color: darkStyle ? Colors.black : IconTheme.of(context).color,
            )
          ],
        ),
      ),
      onTap: onTap != null ? onTap : null,
    );
  }
}
