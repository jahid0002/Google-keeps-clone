import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeps/all_pages/edit_page/edit_page.dart';
import 'package:keeps/all_pages/home/home_component.dart';
import 'package:keeps/all_pages/search_note/search_note_controller.dart';
import 'package:keeps/const/app_colors.dart';
import 'package:keeps/custom_widget/custom_textfield.dart';

class SearchNote extends StatefulWidget {
  const SearchNote({super.key});

  @override
  State<SearchNote> createState() => _SearchNoteState();
}

class _SearchNoteState extends State<SearchNote> {
  final searchController = TextEditingController();
  final controller = Get.put(SearchNoteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.backgroundDarkColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomTextfield(
            onChanged: (p0) {
              setState(() {});
            },
            controller: searchController,
            hintFontSize: 18,
            hintText: 'Search your notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: controller.data!.length,
            itemBuilder: (context, index) {
              print(controller.data!.length);
              if (controller.data![index]['title']
                  .toString()
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase())) {
                return HomeComponent(
                    title: controller.data![index]['title'],
                    note: controller.data![index]['note'],
                    onTap: () {
                      Get.to(() => EditPage(data: controller.data![index]));
                    });
              }
              return Container();
            }),
      ),
    );
  }
}
