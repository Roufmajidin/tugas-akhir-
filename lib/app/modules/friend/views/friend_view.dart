import 'dart:html';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:management_taks_apps/app/data/controller/auth_controller.dart';
import 'package:management_taks_apps/app/utils/style/appColor.dart';

import '../../../utils/widget/headers.dart';
import '../../../utils/widget/myFriendss.dart';
import '../../../utils/widget/sidebar.dart';
import '../controllers/friend_controller.dart';

class FriendView extends GetView<FriendController> {
  
  final GlobalKey<ScaffoldState> _drawwerKey = GlobalKey();
  final authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawwerKey,
      drawer: const SizedBox(width: 150, child: SideBar()),
      backgroundColor: Color.fromARGB(255, 3, 28, 49),
      body: SafeArea(
        child: Row(
          children: [
            !context.isPhone
                ? const Expanded(
                    flex: 2,
                    child: const SideBar(),
                  )
                : const SizedBox(),
            Expanded(
              flex: 15,
              child: Column(
                children: [
                  !context.isPhone
                      ? const Header()
                      : Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _drawwerKey.currentState!
                                                .openDrawer();
                                          },
                                          icon: Icon(Icons.menu,
                                              color: appColor.primaryText)),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Task Management',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: appColor.primaryText),
                                          ),
                                          Text(
                                              'Menjadi mudah bersama Task Management',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: appColor.primaryText))
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.notifications,
                                        color: appColor.primaryText,
                                        size: 30,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          radius: 25,
                                          foregroundImage: NetworkImage(authCon
                                              .auth.currentUser!.photoURL!),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // inputan serach
                                  context.isPhone
                                      ? TextField(
                                      //ketika tampilam mobile phone device
                                          //akasi
                                          onChanged: (value) =>
                                              authCon.searchFriends(value),
                                          controller:
                                              authCon.searchFriendsController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 40, right: 10),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                  color: Colors.blue),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: 'Cari Temanmu !',
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                  //content / isipage /screen
                  Expanded(
                    child: Container(
                      padding: !context.isPhone
                          ? const EdgeInsets.all(10)
                          : const EdgeInsets.all(2),
                      margin:
                          !context.isPhone ? const EdgeInsets.all(10) : null,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: !context.isPhone
                              ? BorderRadius.circular(50)
                              : BorderRadius.circular(30)),
                      child: Obx(
                        () => authCon.hasilPencarian.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const Text(
                                      'People You May Know',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: appColor.primaryText,
                                      ),
                                    ),
                                    // peopleYouMayKnow(),
                                    MyFriends(),
                                  ])
                            : ListView.builder(
                                padding: EdgeInsets.all(5),
                                shrinkWrap: true,
                                itemCount: authCon.hasilPencarian.length,
                                itemBuilder: (context, index) => ListTile(
                                  onTap: () => authCon.addFriends(
                                      authCon.hasilPencarian[index]['email']),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage(authCon
                                          .hasilPencarian[index]['photo']),
                                    ),
                                  ),
                                  title: Text(
                                      authCon.hasilPencarian[index]['name']),
                                  subtitle: Text(
                                      authCon.hasilPencarian[index]['email']),
                                  trailing: Icon(Icons.add),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
 }
}

