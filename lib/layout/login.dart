import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:eduease/utils/cache.dart';
import 'package:eduease/utils/const.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../main.dart';
import 'HomePage.dart';

bool is_loading = false;
var a = 100;
TextEditingController name_con = TextEditingController();
TextEditingController number_con = TextEditingController();
var pinputController = TextEditingController();
bool is_login = true;
bool is_student =true;
var rnd = Random().nextInt(999999999);
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/black.png"), fit: BoxFit.fill)),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    is_login = !is_login;
                  });
                },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.white,
                  child: Image.network("https://avatars.dicebear.com/api/identicon/$rnd.png"),
                )),
            Spacer(),
            if (cache.get_data("otp_id") != null)
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(child: Text("يرجى إدخال الرمز")),
                    SizedBox(
                      height: 30,
                    ),
                    Pinput(controller: pinputController, length: 6),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                      onPressed: () async {
                        if (!is_loading) {
                          setState(() {
                            is_loading = true;
                          });
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(verificationId: cache.get_data("otp_id"), smsCode: pinputController.text);
                          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
                            // Tost("okkkkkkkk", Colors.green);
                            // print(value.user);
                            // print(value.credential);
                            // Tost(cache.get_data("reg"), Colors.orange);
                            setState(() {
                              is_loading = false;
                            });
                            if (cache.get_data("is_login")) {
                              cache.save_data("number", cache.get_data("reg").toString().split("|")[0]);
                              cache.remove_data("otp_id");
                              cache.remove_data("is_login");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
                              cache.remove_data("req");
                              // FirebaseMessaging.instance.getToken().then((value) {
                              //   print(cache.get_data("num"));
                              //   print(cache.get_data("num"));
                              //   context.read<AccountBloc>().add(login_event(cache.get_data("num"), value));
                              //   cache.remove_data("otp_id");
                              //   // AccountBloc().add(login_event(number_con.text, value));
                              // });
                            } else {
                              var a = await FirebaseDatabase.instance.ref().ref.child("Edudy").child("users").ref;
                              DatabaseReference newPostRef = a.push();
                              newPostRef.set({
                                "name": json.encode(cache.get_data("reg").toString().split("|")[1]),
                                "number": json.encode(cache.get_data("reg").toString().split("|")[0]),
                                "type": is_student ? '"طالب"' : '"معلم"',
                                "Dst": "[]",
                                "Rdate": json.encode(DateTime.now().year.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().day.toString()),
                                "group": "[[],[]]",
                                "image": '"https://avatars.dicebear.com/api/identicon/$rnd.png"',
                                "location": "",
                                "school": '["_________","_________"]',
                                "subject": "_________",
                              }).then((value) {
                                cache.save_data("number", cache.get_data("reg").toString().split("|")[0]);
                                cache.remove_data("otp_id");
                                cache.remove_data("is_login");
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
                                cache.remove_data("req");
                              });
                              // FirebaseMessaging.instance.getToken().then((value) {
                              //   cache.remove_data("otp_id");
                              //   context.read<AccountBloc>().add(register_event(value));
                              // });
                            }
                          }).onError((error, stackTrace) {
                            print(error.toString());
                            print(stackTrace.toString());
                            Tost("الرمز خاطئ", Colors.red);
                            setState(() {
                              is_loading = false;
                              pinputController.clear();
                            });
                          });
                        }
                      },
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: is_loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(color: Colors.white),
                                      ))
                                  : const Text(
                                      "تأكيد",
                                      style: TextStyle(fontSize: 20),
                                    ))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          cache.remove_data("otp_id");
                          setState(() {});
                        },
                        child: Text("تغيير الرقم")),
                  ]),
                ),
              )
            else
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
                  width: double.infinity,
                  height: is_login ? 250 : 400,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Text(
                        is_login ? "تسجيل دخول" : "إنشاء حساب",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      if (!is_login)
                        Container(
                          child: Text(" الاسم الكامل", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
                          width: double.infinity,
                        ),
                      if (!is_login) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(controller: name_con,textDirection: TextDirection.rtl,),
                      ),
                      if (!is_login)
                        SizedBox(
                          height: 15,
                        ),
                      Container(
                        child: Text(" الرقم", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text("+964",style: TextStyle(fontSize: 20),),
                            Expanded(child: TextFormField(style: TextStyle(fontSize: 20),controller: number_con,keyboardType: TextInputType.phone,inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(10)],)),
                          ],
                        ),
                      ),
                      if (!is_login)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("معلم"),
                            Checkbox(value: (is_student) ?false:true, onChanged: (value) {setState(() {
                              is_student = false;
                            });}),
                            SizedBox(
                              width: 100,
                            ),
                            Text("طالب"),
                            Checkbox(value: is_student, onChanged: (value){setState(() {
                              is_student = true;
                            });}),
                          ],
                        ),
                      if (is_loading)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.black,
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Center(
                                child:CircularProgressIndicator(color:Colors.white ,)),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async {
                                //   if("a"=="b"){
                                if (await check_is_here(number_con.text) && is_login || !is_login && !await check_is_here(number_con.text)) {
                                  if(number_con.length==10&& is_login||name_con.length!=0&&number_con.length==10&& !is_login){
                                  if (is_login) {
                                    cache.save_data("reg", "${"+964" + number_con.text}|a");
                                    cache.save_data("is_login", true);
                                  }
                                  else {
                                    cache.save_data("reg", "${"+964" + number_con.text}|${name_con.text}");
                                    cache.save_data("is_login", false);
                                  }
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    //phoneNumber: '+963956956020',
                                    phoneNumber: "+964" + number_con.text,
                                    verificationCompleted: (PhoneAuthCredential credential) async {
                                      print("1");
                                      print(credential);
                                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
                                        if (cache.get_data("is_login")) {
                                          cache.save_data("number", cache.get_data("reg").toString().split("|")[0]);
                                          cache.remove_data("otp_id");
                                          cache.remove_data("is_login");

                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
                                          cache.remove_data("req");
                                          // FirebaseMessaging.instance.getToken().then((value) {
                                          //   print(cache.get_data("num"));
                                          //   print(cache.get_data("num"));
                                          //   context.read<AccountBloc>().add(login_event(cache.get_data("num"), value));
                                          //   cache.remove_data("otp_id");
                                          //   // AccountBloc().add(login_event(number_con.text, value));
                                          // });
                                        } else {
                                          var a = await FirebaseDatabase.instance.ref().ref.child("Edudy").child("users").ref;
                                          DatabaseReference newPostRef = a.push();
                                          newPostRef.set({
                                            "name": cache.get_data("reg").toString().split("|")[1],
                                            "number": cache.get_data("reg").toString().split("|")[0]
                                          }).then((value) {
                                            cache.save_data("number", cache.get_data("reg").toString().split("|")[0]);
                                            cache.remove_data("otp_id");
                                            cache.remove_data("is_login");
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage()), (route) => false);
                                            cache.remove_data("req");
                                          });
                                          // FirebaseMessaging.instance.getToken().then((value) {
                                          //   cache.remove_data("otp_id");
                                          //   context.read<AccountBloc>().add(register_event(value));
                                          // });
                                        }
                                      }).onError((error, stackTrace) {
                                        print(error.toString());
                                        print(stackTrace.toString());
                                        Tost("الرمز خاطئ", Colors.red);
                                        setState(() {
                                          // is_loading = false;
                                          // pinputController.clear();
                                        });
                                      });
                                    },
                                    verificationFailed: (FirebaseAuthException e) {
                                      print(e.message);
                                      Tost(e.message.toString(), Colors.red);
                                    },
                                    codeSent: (String verificationId, int? resendToken) {
                                      cache.save_data("otp_id", verificationId);
                                      setState(() {
                                        is_loading = false;
                                      });
                                      print("3");
                                      print(verificationId);
                                      print(resendToken);
                                    },
                                    codeAutoRetrievalTimeout: (String verificationId) {
                                      print("4");
                                      print(verificationId);
                                      cache.save_data("otp_id", verificationId);
                                     // Tost("تمت إعادة إرسال رمز التفعيل", Colors.grey);
                                    },
                                  );
                                  setState(() {
                                    is_loading = true;
                                  });}else{
                                    if(number_con.length!=10){
                                      Tost("يرجى كتابة رقم هاتف صالح", Colors.red);
                                    }
                                    else if(name_con.length==0){
                                      Tost("يرجى كتابة اسم", Colors.red);
                                    }else{
                                      Tost("حدث خطأ", Colors.red);
                                    }
                                  }
                                } else {
                                  if (is_login) {
                                    Tost("الرقم غير موجود", Colors.red);
                                  } else {
                                    Tost("الرقم مستخدم", Colors.red);
                                  }

                                }
                              },
                              child: Container(
                                color: Colors.black,
                                height: 50,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Center(
                                    child: Text(
                                  is_login ? "تسجيل دخول" : "إنشاء حساب",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                )),
                              )),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  is_login = !is_login;
                                });
                              },
                              child: Text(
                                !is_login ? "تسجيل دخول" : "إنشاء حساب",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(is_login ? "لا تمتلك حساب؟ " : "تمتلك حساب ؟")
                        ],
                      ),
                    ],
                  )),
            if (MediaQuery.of(context).viewInsets.bottom != 0)
              Container(
                height: 200,
                color: Colors.white,
              )
          ]),
        ),
      ),
    );
  }

  check_is_here(name) async {
    DataSnapshot a = await FirebaseDatabase.instance.ref().ref.child("Edudy").child("users").get();
    for (var element in a.children) {
      if ((element.value as Map)["number"] == '"+964$name"') {
        return true;
      }
    }
    return false;
  }
}
