import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keeps/all_pages/add_note/add_note_page.dart';
import 'package:keeps/all_pages/edit_page/edit_page.dart';
import 'package:keeps/all_pages/home/home_component.dart';
import 'package:keeps/all_pages/home/home_controller.dart';
import 'package:keeps/all_pages/login/login_page.dart';
import 'package:keeps/all_pages/search_note/search_note_controller.dart';
import 'package:keeps/all_pages/search_note/search_note_page.dart';
import 'package:keeps/const/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final size = MediaQuery.sizeOf(context);
    final email = FirebaseAuth.instance.currentUser!.email;
    final searchController = Get.put(SearchNoteController());
    final controller = Get.put(HomeController());
    // ignore: unused_local_variable
    final _googleSignIn = GoogleSignIn();
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  await auth.signOut().then((value) async {
                    _googleSignIn.signOut().then((value) {
                      Get.offAll(() => const LoginPage());
                    }).onError((error, stackTrace) {
                      Get.snackbar('Error', "Log out error");
                    }).onError((error, stackTrace) {
                      Get.snackbar('Error', "Log out error");
                    });
                  });
                },
                leading: Icon(Icons.logout),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: AppColors.customWhite.withOpacity(0.9),
        title: InkWell(
          onTap: () {
            Get.to(() => SearchNote());
          },
          child: Container(
            height: size.height * 0.04,
            width: size.width * 0.35,
            alignment: Alignment.center,
            child: Text(
              'Search your notes',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        actions: [
          GetBuilder<HomeController>(builder: (conxt) {
            return InkWell(
                onTap: () {
                  controller.changeVeiw();
                },
                child: controller.veiw
                    ? Icon(
                        Icons.view_stream,
                        color: AppColors.backgroundDarkColor.withOpacity(.5),
                      )
                    : Icon(
                        Icons.border_all,
                        color: AppColors.backgroundDarkColor.withOpacity(.5),
                      ));
          }),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 13),
            child: InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundDarkColor.withOpacity(0.5),
        onPressed: () {
          Get.to(() => const AddNotePage());
        },
        child: Icon(
          Icons.add,
          color: AppColors.customWhite,
          size: 30,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(email!).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs;
              searchController.getData(data);
              return GetBuilder<HomeController>(builder: (contxt) {
                if (controller.veiw) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          // print(data[index]['note']);
                          return HomeComponent(
                              onTap: () {
                                Get.to(() => EditPage(data: data[index]));
                              },
                              title: data[index]['title'].toString(),
                              note: data[index]['note'].toString());
                        }),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                        padding: EdgeInsets.all(2),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return HomeComponent2(
                              onTap: () {
                                Get.to(() => EditPage(data: data[index]));
                              },
                              title: data[index]['title'].toString(),
                              note: data[index]['note'].toString());
                        }),
                  );
                }
              });
            } else if (snapshot.hasError) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.backgroundDarkColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.backgroundDarkColor,
              ));
            } else {
              return const Center(
                child: Text('No Notes Avalable'),
              );
            }
          }),
    );
  }
}
