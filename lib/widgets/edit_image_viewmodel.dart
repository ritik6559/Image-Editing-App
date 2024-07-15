import 'package:flutter/material.dart';
import 'package:image_editing_app/screens/edit_image_screen.dart';

abstract class EditImageViewmodel extends State<EditImageScreen> {
  TextEditingController controller = TextEditingController();
  addNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Add New Text",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
                suffix: Icon(
                  Icons.edit,
                ),
                filled: true,
                hintText: "Your Text here..."),
          ),
        );
      },
    );
  }
}
