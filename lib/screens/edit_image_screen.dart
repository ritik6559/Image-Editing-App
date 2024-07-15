import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/widgets/edit_image_viewmodel.dart';
import 'package:image_editing_app/widgets/image_text.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedImage;
  const EditImageScreen({
    super.key,
    required this.selectedImage,
  });

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addNewTextFab,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              _selectedImage,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                  left: texts[i].left,
                  top: texts[i].left,
                  child: GestureDetector(
                    onLongPress: () {},
                    onTap: () {},
                    child: Draggable(
                      feedback: ImageText(textInfo: texts[i]),
                      child: ImageText(textInfo: texts[i]),
                      onDragEnd: (drag) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        Offset off = renderBox.globalToLocal(drag.offset);
                        setState(() {
                          texts[i].top = off.dy;
                          texts[i].left = off.dx;
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _selectedImage => Center(
        child: Image.file(
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          File(
            widget.selectedImage,
          ),
        ),
      );

  Widget get _addNewTextFab => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
}
