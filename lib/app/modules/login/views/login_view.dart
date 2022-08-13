import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/controller/auth_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 253, 253),
      body: Container(
        margin: EdgeInsets.all(Get.height * 0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white
        ),
        child: Row(
          children: [
            !context.isPhone? 
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
             decoration: BoxDecoration(
               color: Color.fromARGB(255, 64, 113, 153),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))
             ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HI, UCIC", style: TextStyle(color: Colors.white, fontSize: 30),),
                  Text("Selamat Datang", style: TextStyle(color: Colors.white, fontSize: 18),),
                  // Text("Yuk Login", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            )
            ): const SizedBox(),
            Expanded(
                child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50), topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),

          ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  Image.asset("assets/image/login.png", height: 400,),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: InkWell(
                      onTap: (){
                       authC.signInWithGoogle();
                      },
                      child: Ink(
                        
                        child: Text("Sign In With Google",style: TextStyle(color: Colors.white, fontSize: 12 ),),
                      ),
                    ),
                  )
                  ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

