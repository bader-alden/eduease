import 'package:eduease/icon/icomoon_icons.dart';
import 'package:eduease/utils/cache.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';

class OnBord extends StatefulWidget {
  const OnBord({Key? key}) : super(key: key);

  @override
  _OnBordState createState() => _OnBordState();
}

class _OnBordState extends State<OnBord> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient:LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colors.orange.shade400, Colors.white]),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/school.json'),
            SizedBox(height: 30,),
            Text("الحل الأمثل لجميع مشاكل إدارة المدارس ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text("التي تواجه المدارس اليوم ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 30,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(is_login: true,))),
              radius: 20,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login,color: Colors.green,),
                    SizedBox(width: 10,),
                    Text("تسجيل الدخول",style: TextStyle(color: Colors.white),)
                  ],
              ),
                ),),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(is_login: false,))),
              radius: 20,
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(20)),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_rounded,color: Colors.orange,),
                    SizedBox(width: 10,),
                    Text("إنشاء حساب جديد",style: TextStyle(color: Colors.white),)
                  ],
              ),
                ),),
            )
          ],
        ),
      ),
    ),);
  }
}
