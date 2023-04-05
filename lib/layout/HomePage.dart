import 'package:eduease/layout/login.dart';
import 'package:eduease/layout/update_profile.dart';
import 'package:eduease/utils/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/main_bloc/main_bloc.dart';
var text_list = ["XXXXXX","XXXXXX","XXXXXX","المتجر","XXXXXX","XXXXXX",];

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
  create: (context) => MainBloc()..add(init_event()),
  child: BlocConsumer<MainBloc, MainState>(
  listener: (context, state) {},
  builder: (context, state) {
    MainBloc bloc = context.read<MainBloc>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(context,bloc),
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
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile(user:bloc.user_mouduls))),
                    child: Row(
                      children: [
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(bloc.user_mouduls?.name??"",style: TextStyle(fontSize: 20),),
                            SizedBox(height: 5,),
                            Text(bloc.user_mouduls?.number??""),
                            SizedBox(height: 5,),
                            Text(bloc.user_mouduls?.type??""),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Card(elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(width: 40,child: bloc.user_mouduls?.image==null?CircularProgressIndicator():Image.network(bloc.user_mouduls?.image??"")),
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
  },
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
  Widget HomeDrawer(context,bloc){
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
                          child: SizedBox(width: 35,child: bloc.user_mouduls?.image==null?CircularProgressIndicator():Image.network(bloc.user_mouduls?.image??"")),
                        )),
                    Spacer(),
                    Text(bloc.user_mouduls?.name??"")
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
                onTap: (){
                  cache.remove_data("number");
                  cache.remove_data("otp_id");
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login(is_login: true)), (route) => false);
                },
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
