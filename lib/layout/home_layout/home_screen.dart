
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/select_sign_way/sign_ways_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../screens/add_item_screen/add_item_view.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
   //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

   var scaffoldKey=GlobalKey<ScaffoldState>();
   var _bottomNavigationKey=GlobalKey<CurvedNavigationBarState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              //height: 30,
              //width: 30,
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

      body: AppCubit.get(context).screens[AppCubit.get(context).pageIndex],

      drawer: Container(
        width: MediaQuery.of(context).size.width/2,
        child: Drawer(
          backgroundColor: AppColors.drawerColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image),
                    Text('BarterIt'),
                  ],
                ),
              ),
              ListTile(
                leading:Icon(Icons.notifications),
                title:Text('Notifications',
                style: TextStyle(fontSize: 18),
                ),
                onTap: (){},
              ),
              ListTile(
                leading:Icon(Icons.help_center_rounded),
                title:Text('Help',
                style: TextStyle(fontSize: 18),
                ),
                onTap: (){},
              ),
              ListTile(
                leading:Icon(Icons.logout),
                title:Text('Sing Out',
                style: TextStyle(fontSize: 18),
                ),
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => SelectSignWay(),),
                          (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 60,
        index: AppCubit.get(context).pageIndex,
        backgroundColor: Colors.white,
        color: AppColors.bottomNavColor,
        animationDuration: Duration(milliseconds:300),
        //animationCurve: Curves.easeInToLinear,
       // letIndexChange: (index)=>true,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 20),
          Icon(Icons.chat_bubble, size: 20),
          Icon(Icons.announcement, size: 20),
          Icon(Icons.person, size: 20),
        ],
        onTap: (index) {
          AppCubit.get(context).changeScreen(index);
        },
      ),
    );
  }
}
