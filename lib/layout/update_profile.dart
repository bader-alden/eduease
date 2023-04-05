import 'dart:convert';

import 'package:eduease/Moduals/user_moduls.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:eduease/utils/cache.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' ;
List dst_list = [];
class UpdateProfile extends StatefulWidget {
  final user;
  const UpdateProfile({Key? key, this.user}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState(user);
}

class _UpdateProfileState extends State<UpdateProfile> {
  final user_moduls user;

  _UpdateProfileState(this.user);
  @override
  void initState() {
    super.initState();
    user.dst.forEach((element) {
      dst_list.add(json.encode(element));});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [BackButton(color: Colors.black,),
                Spacer(),
                  Text("تعديل الملف الشخصي",style: TextStyle(fontSize: 22),)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                  children: [
                    Spacer(),
                    Text(user.name??"",style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10,),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),child: CircleAvatar(backgroundColor: Colors.white,radius: 40,child: Image.network(user.image??"",width: 50,),)),
                        ),
                      CircleAvatar(radius: 15,backgroundColor: Colors.orange,child: Icon(Icons.edit,color: Colors.black),)
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 10,),
             // Container(height: 2,width: MediaQuery.of(context).size.width/1.2,color: Colors.grey.shade300,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Spacer(),
                  Text("المعلومات",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  SizedBox(width: 5,),
                  Icon(Icons.info_outline,color: Colors.blue,),
                ],
              ),
              Update_pro_item(user.school??"المدرسة",Icons.school_outlined),
              Update_pro_item(user.classe??"الصف",Icons.class_outlined),
              Update_pro_item("الايميل",Icons.mail_outline),
              Update_pro_item("الموقع",Icons.location_on_outlined),
              SizedBox(height: 10,),
              Container(height: 2,width: MediaQuery.of(context).size.width/1.2,color: Colors.grey.shade300,),
              SizedBox(height: 10,),
              Row(
                children: [
                  Spacer(),
                  Text("الأنجازات",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  SizedBox(width: 5,),
                  Icon(Icons.library_add_check_outlined,color: Colors.blue),
                ],
              ),
              Icon(Icons.stars_outlined),
              Center(child: Text("لايوجد إنجازات")),
              SizedBox(height: 10,),
              Container(height: 2,width: MediaQuery.of(context).size.width/1.2,color: Colors.grey.shade300,),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  FloatingActionButton(onPressed: () {
                    var con = TextEditingController();
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: Column(
                        children: [
                          Text("اكتب وصف الحالة المرضية"),
                          SizedBox(height: 20,),
                          Container(
                              color: Colors.grey.shade200,
                              height: 250,
                              child: TextFormField(decoration: InputDecoration(border: InputBorder.none),maxLines: null,keyboardType: TextInputType.multiline,controller: con,textDirection: TextDirection.rtl,)),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton(onPressed: (){

                                Navigator.pop(context);
                                setState(() {
                                  dst_list.add(json.encode(con.text));
                                  change_dst(dst_list);
                                });
                                }, child: Text("موافق"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),),
                              Spacer(),
                              ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("إلغاء"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ));
                  },
                      mini: true,
                      backgroundColor: Colors.white,
                  child: Icon(Icons.add,color: Colors.blue)),
                  Spacer(),
                  Text("الحالات المرضية",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  SizedBox(width: 5,),
                //  Icon(MdiIcons.stethoscope,color: Colors.blue)
                ],
              ),
              ...dst_list.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    var con = TextEditingController(text: json.decode(e));
                    showDialog(context: context, builder: (context)=>AlertDialog(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                                setState(() {
                                  dst_list.remove(e);
                                });
                              },icon: Icon(Icons.delete,color: Colors.red,)),
                              SizedBox(width: 10,),
                              Text("اكتب وصف الحالة المرضية"),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                              color: Colors.grey.shade200,
                              height: 250,
                              child: TextFormField(decoration: InputDecoration(border: InputBorder.none),maxLines: null,keyboardType: TextInputType.multiline,controller: con,textDirection: TextDirection.rtl,)),
                          Row(
                            children: [
                              Spacer(),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                                setState(() {
                                  dst_list.remove(e);
                                  dst_list.add(json.encode(con.text));
                                  change_dst(dst_list);
                                });
                              }, child: Text("تعديل"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),),
                              Spacer(),
                              ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("إلغاء"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ));
                  },
                  child: Container(color: Colors.grey.shade200,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(json.decode(e),style: TextStyle(fontSize: 18),textDirection: TextDirection.rtl,maxLines: 1,overflow: TextOverflow.ellipsis),
                  )),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget Update_pro_item (String text , icon){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Spacer(),
        Text(text,style: TextStyle(fontSize: 18),),
        SizedBox(width: 10,),
        Icon(icon)
        ],
      ),
    );
  }
  Future<void> change_dst(n_des) async {
    print("a");
    DataSnapshot a = await FirebaseDatabase.instance.ref().ref.child("Edudy").child("users").get();
    for (var element in a.children) {
      if ((element.value as Map)["number"] == '"${cache.get_data("number")}"') {
        print("b");
       element.ref.update({"Dst": n_des.toString()}).catchError((e){print(e.toString());});
      }
    }
  }
}
