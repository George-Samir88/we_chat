import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_chat/core/function/update_user.dart';
import 'package:we_chat/core/widgets/custom_alert_message.dart';
import 'package:we_chat/core/widgets/custom_elevated_button_with_icon.dart';
import 'package:we_chat/features/user_profile/manager/user_profile_cubit.dart';
import 'package:we_chat/features/user_profile/presentation/widget/name_and_about_section_user_profile.dart';
import 'package:we_chat/features/user_profile/presentation/widget/photo_email_section_user_profile.dart';

import '../../../../core/global_var.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.01,
                  width: screenSize.width,
                ),
                PhotoEmailSectionUserProfile(),
                NameAndAboutSectionUserProfile(),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                CustomElevatedButtonWithIcon(
                    backgroundColor: Colors.blue,
                    icon: Icons.add_comment_rounded,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        updateUserprofile().then((value) {
                          customAlertMessage(
                              message: 'Updated Successfully',
                              backgroundColor: Colors.green);
                        });
                      }
                    },
                    textColor: Colors.white,
                    firstText: 'Edit'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
