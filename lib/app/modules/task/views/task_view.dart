import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:management_taks_apps/app/data/controller/auth_controller.dart';
import 'package:management_taks_apps/app/utils/style/appColor.dart';
import 'package:management_taks_apps/app/utils/widget/addEditTask.dart';
import 'package:management_taks_apps/app/utils/widget/myTask.dart';

import '../../../utils/widget/headers.dart';
import '../../../utils/widget/sidebar.dart';
import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
   final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final authCon = Get.find<AuthController>();

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
                                    'Menjadi Mudah dengan Task Management',
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
                          !context.isPhone ? const EdgeInsets.all(10) : null,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: !context.isPhone
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTask(),
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
      floatingActionButton: Align(
        alignment: const Alignment(0.9, 0.95),
        child: FloatingActionButton.extended(
          onPressed: () {
          // ketika ditekan
            addEditTask(context: context, type: 'Add', docId: '');
          },
          label: const Text("Add Task",),
          icon: const Icon(Icons.add),
          
        ),
      ),
    );
  }}
