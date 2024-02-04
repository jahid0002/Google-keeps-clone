import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keeps/all_pages/add_note/add_note_page_controller.dart';
import 'package:keeps/const/app_colors.dart';
import 'package:keeps/custom_widget/bottom_sheet.dart';
import 'package:keeps/custom_widget/custom_textfield.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNotePageController());
    final titleController = TextEditingController();
    final noteController = TextEditingController();
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (controller.image != null ||
            noteController.text.isNotEmpty ||
            titleController.text.isNotEmpty) {
          controller.sendNote(
              titleController.text.toString(), noteController.text.toString());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.customWhite.withOpacity(0.9),
          leading: IconButton(
            onPressed: () {
              if (controller.image != null ||
                  noteController.text.isNotEmpty ||
                  titleController.text.isNotEmpty) {
                Get.back();
                controller.sendNote(titleController.text.toString(),
                    noteController.text.toString());
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              right: 20,
              left: 20,
            ),
            child: GetBuilder<AddNotePageController>(builder: (contet) {
              return Column(
                children: [
                  controller.image != null
                      ? Image.file(File(controller.image!.path))
                      : const SizedBox(),
                  CustomTextfield(
                      styleSize: 24,
                      controller: titleController,
                      hintFontSize: 24,
                      hintText: 'Title'),
                  SizedBox(
                    height: size.height * 0.000001,
                  ),
                  CustomTextfield(
                    styleSize: 20,
                    controller: noteController,
                    hintFontSize: 20,
                    hintText: 'Note',
                    maxLines: 15,
                  )
                ],
              );
            }),
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  AddBottomSheet.showBotomSheet(context: context, children: [
                    ListTile(
                      onTap: () {
                        controller.getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.camera),
                      title: Text(
                        'Camera',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        controller.getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.image),
                      title: Text(
                        'Gallary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.backgroundDarkColor, width: 1),
                    // color: AppColors.backgroundDarkColor,
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.backgroundDarkColor,
                    size: 30,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AddBottomSheet.showBotomSheet(context: context, children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        noteController.clear();
                        titleController.clear();
                        Get.back();
                      },
                      leading: const Icon(Icons.delete),
                      title: Text(
                        'Delete',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.copy),
                      title: Text(
                        'Select',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ]);
                },
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.backgroundDarkColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
