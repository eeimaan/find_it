import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:finder_app/constants/constants.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String location;
  final Color? backgroundColor;
  final double customAppBarHeight;
  final String imagepath;

  AppBarCustom({
    Key? key,
    this.backgroundColor,
    required this.name,
    required this.location,
    this.customAppBarHeight = kToolbarHeight + 30,
    required this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: customAppBarHeight,
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name,
              size: 22,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.red,
                  size: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: location,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagepath),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(customAppBarHeight);
}
