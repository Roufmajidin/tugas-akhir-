
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_taks_apps/app/data/controller/auth_controller.dart';
import 'package:management_taks_apps/app/utils/style/appColor.dart';

class ProfilWidget extends StatelessWidget {
  final authCon = Get.find<AuthController>();
 
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ! context.isPhone ? Row(
      children: [
        Expanded(
          flex: 1,
          child: 
          ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CircleAvatar(
          backgroundColor: Colors.amber, 
          radius: 150,
          foregroundImage: NetworkImage(
           authCon.auth.currentUser!.photoURL!),
         ),                              
       ),
      ),
       //SizedBox(width: 20,

      Expanded(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
                authCon.auth.currentUser!.displayName!,
                  style: TextStyle(
                  color: appColor.primaryText,
                  fontSize: 35,
                 ),
              ),
            Text(
                authCon.auth.currentUser!.email!,
                  style: TextStyle(
                  color: appColor.primaryText,
                  fontSize: 15,
                 ),
              ),
          ],
        ),
      ),
      ],
  ): Center(
    child: Column(
        children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child:  CircleAvatar(
          backgroundColor: Colors.amber, 
          radius: 110,
          foregroundImage: NetworkImage(
            authCon.auth.currentUser!.photoURL!),),
         ),
         SizedBox(height: 20,),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                   authCon.auth.currentUser!.displayName!,
                    style: TextStyle(
                    color: appColor.primaryText,
                    fontSize: 35,
                   ),
                ),
              Text(
                   authCon.auth.currentUser!.email!,
                    style: TextStyle(
                    color: appColor.primaryText,
                    fontSize: 15,
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