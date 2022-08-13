import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/controller/auth_controller.dart';

class peopleYouMayKnow extends StatelessWidget {
  final authCon = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: authCon.getPeople(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!.docs;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              clipBehavior: Clip.antiAlias,
              itemCount: data.length,
              itemBuilder: (context, index) {
                var hasil = data[index].data();

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(hasil['photo']),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 35,
                        child: Text(
                          hasil['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: ElevatedButton(
                            onPressed: () => authCon.addFriends(hasil['email']),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Icon(Icons.add_circle_outline),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
