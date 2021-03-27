import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final Function onTap;
  ProfileButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Text("Profile"),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
      onTap: onTap != null ? onTap : null,
    );
  }
}
