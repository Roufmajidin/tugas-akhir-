import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controller/auth_controller.dart';
import '../style/appCOlor.dart';
import 'addEditTask.dart';

class MyTask extends StatelessWidget {
  final authCon = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: 
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              //strem user get task
              stream: authCon.StreamUsers(authCon.auth.currentUser!.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                //task Id get
                var taskId = (snapshot.data!.data()
                    as Map<String, dynamic>)['task_id'] as List;

                return ListView.builder(
                  itemCount: taskId.length,
                  clipBehavior: Clip.antiAlias,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: authCon.StreamTask(taskId[index]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          //data taskk
                          var dataTask = snapshot2.data!.data();
                          //data user ptot
                          var dataUserList = (snapshot2.data!.data()
                              as Map<String, dynamic>)['asign_to'] as List;

                          return GestureDetector(
                            //edit
                            onLongPress: () {
                              Get.defaultDialog(
                                  title: dataTask!['title'],
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //update

                                      TextButton.icon(
                                        onPressed: () {
                                          Get.back();
                                          authCon.titleController.text =
                                              dataTask['title'];
                                          authCon.descriptionController.text =
                                              dataTask['description'];
                                          authCon.dueDateController.text =
                                              dataTask['due_date'];
                                          addEditTask(
                                              context: context,
                                              type: 'Update',
                                              docId: taskId[index]);
                                        },
                                        icon: const Icon(Icons.edit),
                                        label: const Text('Update'),
                                      ),
                                      //delete ngarah ke authController
                                      TextButton.icon(
                                        onPressed: () {
                                          authCon.deleteTask(taskId[index]);
                                        },
                                        icon: const Icon(Icons.delete),
                                        label: const Text('Delete'),
                                      )
                                    ],
                                  ));
                              // addEditTask(
                              //     context: context,
                              //     type: 'Update',
                              //     docId:
                              //         '2022-08-10T23:44:35.645');
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 3, 28, 49),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: Expanded(
                                          child: ListView.builder(
                                            itemCount: dataUserList.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index2) {
                                              return StreamBuilder<
                                                      DocumentSnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                  stream: authCon.StreamUsers(
                                                      dataUserList[index2]),
                                                  builder:
                                                      (context, snapshot3) {
                                                    if (snapshot3
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }

                                                    //data user phoyo
                                                    var dataUserImage =
                                                        snapshot3.data!.data();
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.amber,
                                                        radius: 20,
                                                        foregroundImage:
                                                            NetworkImage(
                                                                dataUserImage![
                                                                    'photo']),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 25,
                                        width: 80,
                                        color: Color.fromARGB(255, 2, 90, 162),
                                        child: Center(
                                            child: Text(
                                          dataTask!['status'],
                                          style: TextStyle(
                                            color: appColor.primaryText,
                                          ),
                                        )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 20,
                                    width: 80,
                                  
                                    child: Center(
                                        child: Text(
                                      '${dataTask['total_task_finished']} / ${dataTask['total_task']} Task',
                                      style: TextStyle(
                                        color: appColor.primaryText,
                                      ),
                                    )),
                                  ),
                                  Text(
                                    dataTask!['title'],
                                    style: TextStyle(
                                        color: appColor.primaryText,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    dataTask['description'],
                                    style: TextStyle(
                                        color: appColor.primaryText,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                );
              }),
    );
        
      
    
  }
}
