import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:management_taks_apps/app/utils/style/appColor.dart';
import 'package:management_taks_apps/app/utils/widget/peopleYouMayNow.dart';

import '../../../data/controller/auth_controller.dart';
import '../../../utils/widget/headers.dart';
import '../../../utils/widget/myFriendss.dart';
import '../../../utils/widget/myTask.dart';
import '../../../utils/widget/sidebar.dart';
import '../../../utils/widget/upCommingTasks.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
 final authCon = Get.find<AuthController>();


final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 150, child: SideBar()),
      backgroundColor: Color.fromARGB(255, 3, 28, 49),
      body: SafeArea(
        child: Row(
          children: [
            !context.isPhone
                ? const Expanded(flex: 2, child: SideBar())
                : const SizedBox(),
            Expanded(
              flex: 15,
              child: Column(
                children: [
                  //Bagian Header
                  !context.isPhone
                      ? const Header()
                      : Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _drawerKey.currentState!.openDrawer();
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: appColor.primaryText,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Task Management',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: appColor.primaryText,
                                    ),
                                  ),
                                  Text(
                                    'Menjadi mudah dengan Task Management',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: appColor.primaryText,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.notifications,
                                color: appColor.primaryText,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  radius: 25,
                                  foregroundImage: NetworkImage(
                                      authCon.auth.currentUser!.photoURL!),
                                ),
                              )
                            ],
                          ),
                        ),
                  // Bagian Isi
                  Expanded(
                    child: Container(
                      padding: !context.isPhone
                          ? const EdgeInsets.all(10)
                          : const EdgeInsets.all(2),
                      margin:
                          !context.isPhone ? const EdgeInsets.all(5) : null,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: !context.isPhone
                              ? BorderRadius.circular(50)
                              : BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          // start MY TASK
                          SizedBox(
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'People You May Now',
                                  style: TextStyle(
                                    color: appColor.primaryText,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // TASK
                                peopleYouMayKnow(),
                              ],
                            ),
                          ),
                          // end of MY TASK
                          ! context.isPhone 
                          ? Expanded(
                            child: Row(
                              children: [
                                MyTask(),
                                MyFriends()
                              ],
                            ),
                          )
                          : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 const Text(
                                  'My Task',
                                  style: TextStyle(
                                    color: appColor.primaryText,
                                    fontSize: 30,
                                  ),
                                ),
                                MyTask(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}