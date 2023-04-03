import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart' ;

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    Text("الاسم",style: TextStyle(fontSize: 22)),
                    SizedBox(width: 10,),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(radius: 40,),
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
              Update_pro_item("المدرسة",Icons.shopping_cart_outlined),
              Update_pro_item("الصف",Icons.add),
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
              Text("لايوجد إنجازات"),
              SizedBox(height: 10,),
              Container(height: 2,width: MediaQuery.of(context).size.width/1.2,color: Colors.grey.shade300,),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  FloatingActionButton(onPressed: () {  },
                      mini: true,
                      backgroundColor: Colors.white,
                  child: Icon(Icons.add,color: Colors.blue)),
                  Spacer(),
                  Text("الحالات المرضية",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  SizedBox(width: 5,),
                  Icon(MdiIcons.stethoscope,color: Colors.blue)
                ],
              ),
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
}
