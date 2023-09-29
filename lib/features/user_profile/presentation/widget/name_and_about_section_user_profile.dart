import 'package:flutter/cupertino.dart';

import '../../../../core/global_var.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class NameAndAboutSectionUserProfile extends StatelessWidget {
  const NameAndAboutSectionUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          onSaved: (value) {
            me.name = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required field';
            }
            return null;
          },
          labelText: 'Name',
          hintText: "ex: George Samir",
          maxLines: 1,
          prefixIcon: CupertinoIcons.person,
          initialValue: me.name,
        ),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
        CustomTextFormField(
          onSaved: (value) {
            me.about = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Required field';
            }
            return null;
          },
          labelText: 'About',
          hintText: "ex: i'm happy now",
          maxLines: 1,
          prefixIcon: CupertinoIcons.info_circle,
          initialValue: me.about,
        ),
      ],
    );
  }
}
