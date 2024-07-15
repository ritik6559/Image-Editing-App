import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editing_app/models/text_info.dart';
import 'package:image_editing_app/screens/edit_image_screen.dart';
import 'package:image_editing_app/utils/utils.dart';
import 'package:image_editing_app/widgets/default_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditImageViewmodel extends State<EditImageScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  int currentIndex = 0;

  List<TextInfo> texts = [];

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Image saved"),
          ),
        );
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List image) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time"; //creating a unique image name

    await requestPermission(
        Permission.storage); //asking for permission from user.
    await ImageGallerySaver.saveImage(image,
        name: name); //saving image to gallery.
  }

  setCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Selected for styling",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  deleteText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Text deleted"),
      ),
    );
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          text: controller.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left,
        ),
      );
      Navigator.of(context).pop();
    });
  }

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
              onPressed: () => addNewText(context),
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
