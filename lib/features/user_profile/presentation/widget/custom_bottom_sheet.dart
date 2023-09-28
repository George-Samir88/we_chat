import 'package:flutter/material.dart';

import '../../../../core/global_var.dart';
import '../../../../core/widgets/general_elevated_button.dart';

void showBottomSheetFun({required context}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.black,
        width: 0.5,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return ListView(
        padding: EdgeInsets.only(
            top: screenSize.height * 0.03, bottom: screenSize.height * 0.06),
        shrinkWrap: true,
        children: [
          Text(
            'Pick a photo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GeneralElevatedButton(
                onPressed: () {},
                imagePath: 'assets/images/add_photo.png',
              ),
              GeneralElevatedButton(
                onPressed: () {},
                imagePath: 'assets/images/gallery.png',
              ),
            ],
          ),
        ],
      );
    },
  );
}
