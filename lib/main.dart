import 'package:eduease/utils/cache.dart';
import 'package:eduease/layout/on_bord.dart';
import 'package:eduease/layout/update_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cache.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
var text_list = ["XXXXXX","XXXXXX","XXXXXX","المتجر","XXXXXX","XXXXXX",];
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu Ease',
      home: const OnBord(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
  drawer: HomeDrawer(context),
      floatingActionButton: Container(width: 160,decoration:BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(50)),child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("خدمة العملاء",style: TextStyle(fontSize: 20,color: Colors.white)),SizedBox(width: 5,),Icon(Icons.support_agent,color: Colors.white,size: 30,)],),
      )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 20,),
                IconButton(onPressed: (){
                 // Scaffold.of(_scaffoldKey.currentContext!).openDrawer();
                  _scaffoldKey.currentState?.openDrawer();
                },icon: Icon(Icons.menu)),
                Expanded(
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile())),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("name",style: TextStyle(fontSize: 20),),
                            SizedBox(height: 5,),
                            Text("email"),
                            SizedBox(height: 5,),
                            Text("طالب"),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Card(elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(width: 40,child: Image.network("https:\/\/avatars.dicebear.com\/api\/identicon\/816768506.png?")),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: 10,),
            Container(width: MediaQuery.of(context).size.width/1.3,color: Colors.grey.shade300,height: 2,),
            SizedBox(height: 40,),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 300)),
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 0,childAspectRatio: 0.9),
                itemCount: 6,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                return HomeItem(context,text_list[index],Container());
                },
              ),
            ),
            HomeItem(context,"XXXXXX",Container())
    ],
        ),
      ),
    );
  }
  Widget HomeItem(BuildContext context,String text,Widget path ){
    return  InkWell(
      onTap: ()=>text == "XXXXXX"?null:Navigator.push(context, MaterialPageRoute(builder: (context)=>path)),
      child: Column(
        children: [
          Icon(Icons.circle_notifications_outlined,size: 75,),
          SizedBox(height: 15,),
          Text(text,style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
  Widget HomeDrawer(context){
    return Container(decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))),height: MediaQuery.of(context).size.height/1.5,width: MediaQuery.of(context).size.width/1.5,
    child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("الإعدادت"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(width: 35,child: Image.network("https:\/\/avatars.dicebear.com\/api\/identicon\/816768506.png?")),
                    )),
                Spacer(),
                Text("name")
              ],
            ),
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 16,),
                  Icon(Icons.grid_view_rounded),
                  Spacer(),
                  Text("العروض"),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 16,),
                  Icon(Icons.person_pin_outlined),
                  Spacer(),
                  Text("المدير التنفيذي"),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 16,),
                  Icon(Icons.school),
                  Spacer(),
                  Text("طلب الأنتماء للمدرسة"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(child: Container(width: MediaQuery.of(context).size.width/1.8,color: Colors.black,height: 2,)),
          Spacer(),
          InkWell(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.output),
                  Spacer(),
                  Text("تسجيل الخروج"),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

