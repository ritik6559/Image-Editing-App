import 'package:flutter/material.dart';
import 'package:image_editing_app/screens/edit_image_screen.dart';
import 'package:image_editing_app/widgets/default_button.dart';

abstract class EditImageViewmodel extends State<EditImageScreen> {
  TextEditingController controller = TextEditingController();
  addNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              textColor: Colors.black,
              child: const Text("Back"),
            ),
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
              textColor: Colors.black,
              child: const Text("Add Text"),
            ),
          ],
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
