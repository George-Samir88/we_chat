import 'package:flutter/material.dart';

import '../../manager/functions.dart';
import '../../manager/models/message_model.dart';

void showAlertDialogForUpdateMessage(
    {required MessageModel message, required context}) {
  var formKey = GlobalKey<FormState>();
  var textEditingController = TextEditingController();
  textEditingController.text = message.msg;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.only(
            top: 20,
            bottom: 10,
            left: 24,
            right: 20,
          ),
          title: Row(
            children: [
              Icon(
                Icons.message,
                color: Colors.blue,
                size: 28,
              ),
              Text(
                '  Update message',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 5,
              controller: textEditingController,
              minLines: 1,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Can't send an empty message";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  updateMessage(
                    messageModel: message,
                    newMessage: textEditingController.text,
                  );
                }
              },
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      });
}
