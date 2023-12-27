import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/local_notifications.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screens/add_item_screen/add_item_view.dart';

var scaffoldKey=GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(

        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 90,
            leadingWidth: 70,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.drawerColor,blurRadius: 10,),
                  ],
                ),
                child: IconButton(
                  onPressed: (){
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: AppColors.drawerColor,blurRadius: 10),
                    ],
                  ),
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewItemView(),));
                    },
                    icon: Icon(Icons.add_box_rounded),
                  ),
                ),
              ),
            ],

          ),

          body: WillPopScope(
              child: AppCubit.get(context).screens[AppCubit.get(context).pageIndex],
              onWillPop:() {
                alertToExit(context);
                return Future.value(false);
              },
          ),

          drawer: Container(
            width: MediaQuery.of(context).size.width/2,
            child: Drawer(
              backgroundColor: AppColors.drawerColor,
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.white),
                    child: Image.asset("assets/images/splash_icon.png",fit: BoxFit.cover),
                  ),
                  ListTile(
                    leading:Icon(Icons.notifications),
                    title:Text(translate(context,'Notifications')!,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                    onTap: (){
                      LocalNotifications.showSimpleNotification(
                          title: "local Notification",
                          body: "Notification for me",
                          payload: "this is simple data");
                    },
                  ),
                  ListTile(
                    leading:Icon(Icons.help_center_rounded),
                    title:Text(translate(context,'Help Center')!,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    leading:Icon(Icons.logout),
                    title:Text(translate(context,'Log Out')!,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                    onTap: (){
                      alertToLogOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: CurvedNavigationBar(
            height: 60,
            index: AppCubit.get(context).pageIndex,
            backgroundColor: Colors.white,
            color: AppColors.bottomNavColor,
            animationDuration: Duration(milliseconds:300),
            //animationCurve: Curves.easeInToLinear,
            // letIndexChange: (index)=>true,
            items: <Widget>[
              Icon(Icons.home_filled, size: 20),
              Icon(Icons.chat_bubble, size: 20),
              Icon(Icons.settings_rounded, size: 20),
              Icon(Icons.person, size: 20),
            ],
            onTap: (index) {
              AppCubit.get(context).changeScreen(index);
            },
          ),
        ),
    );
  }
}
