import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controller/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../style/appColor.dart';

class MyFriends extends StatelessWidget {
   final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'My Friends',
                    style: TextStyle(
                      color: appColor.primaryText,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.FRIEND),
                    child: Text(
                      'more',
                      style: TextStyle(
                        color: appColor.primaryText,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: appColor.primaryText,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                  height: 300,
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: authCon.StreamFriends(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      var myFriends = (snapshot.data!.data()
                          as Map<String, dynamic>)['emailFriends'] as List;

                      return GridView.builder(
                          shrinkWrap: true,
                          // menghitung ada berapa banyak data di database
                          itemCount: myFriends.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            return StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: authCon.StreamUsers(myFriends[index]),
                                builder: (context, snapshot2) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  //varabel data untuk email sama poto
                                  var data = snapshot2.data!.data();
                                  return Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(90),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          radius: 60,
                                          foregroundImage: NetworkImage(
                                              data!['photo']),
                                        ),
                                      ),
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            color: appColor.primaryText),
                                      ),
                                    ],
                                  );
                                });
                          });
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
