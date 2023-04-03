import 'package:flutter/material.dart';
var a = 100 ;
bool is_login=true;
class Login extends StatefulWidget {
  const Login({Key? key, required this.is_login}) : super(key: key);
  final bool is_login;

  @override
  _LoginState createState() => _LoginState(is_login);
}

class _LoginState extends State<Login> {
   bool is_login;

  _LoginState(this.is_login);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/black.png"),fit: BoxFit.fill)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
            SizedBox(height: 50,),
            InkWell(onTap: (){
              setState(() {
                is_login=!is_login;
              });
            },child: Container(width: 150,height: 150,color: Colors.orange,)),
            Spacer(),
           AnimatedContainer(duration: Duration(milliseconds: 300),decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),width: double.infinity,height: is_login?250:400,child: ListView(
             physics: BouncingScrollPhysics(),
             children: [
             SizedBox(height: 15,),
             Center(child: Text(is_login?"تسجيل دخول":"إنشاء حساب",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
             if(!is_login)
             Container(child: Text(" الاسم الكامل",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),width: double.infinity,),
             if(!is_login)
             TextFormField(),
             if(!is_login)
             SizedBox(height: 15,),
             Container(child: Text(" الرقم",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),width: double.infinity,),
             TextFormField(),
               if(!is_login)
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("معلم"),
                     Checkbox(value: false, onChanged: (value){}),
                     SizedBox(width: 100,),
                     Text("طالب"),
                     Checkbox(value: false, onChanged: (value){}),
                   ],
                 ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(color: Colors.black,height: 50,width: MediaQuery.of(context).size.width/1.2,child: Center(child: Text(is_login?"تسجيل دخول":"إنشاء حساب",style: TextStyle(color: Colors.white,fontSize: 20),)),),
             ),
             SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 InkWell(
                     onTap: (){
                       setState(() {
                         is_login=!is_login;
                       });
                     },
                     child: Text(!is_login?"تسجيل دخول":"إنشاء حساب",style: TextStyle(fontWeight: FontWeight.bold),)),
                 SizedBox(width: 5,),
                 Text(is_login?"لا تمتلك حساب؟ ":"تمتلك حساب ؟")
               ],
             )
           ],))
          ]),
        ),
      ),
    );
  }
}
