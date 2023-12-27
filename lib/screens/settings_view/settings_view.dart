
import 'package:barter_it/components/components.dart';
import 'package:barter_it/layout/cubit/cubit.dart';
import 'package:barter_it/layout/cubit/states.dart';
import 'package:barter_it/localization/localization_methods.dart';
import 'package:barter_it/main.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/address/add_address.dart';
import 'package:barter_it/screens/address/view_address.dart';
import 'package:barter_it/screens/my_products_screen/my_products_screen.dart';
import 'package:barter_it/shared/shared_pref.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingsView extends StatelessWidget {
   SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (context, state) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll){
          overScroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            Text(translate(context,"Settings")!, style: const TextStyle(color: Colors.black,fontSize: 25)),
            const SizedBox(height: 16),
            buildListTile(translate(context,'Theme')!, Icons.dark_mode, translate(context,'Light')!, Colors.purple, onTab: () {}/*=>showAppearanceModal()*/),
            const Divider(color: Colors.black),
            buildListTile(translate(context,'Language')!, Icons.language, translate(context, Shared.getString(key: LANG_CODE) ?? ENGLISH)!, Colors.orange, onTab: (){
                DropDownState(
                  DropDown(
                    data:[
                      SelectedListItem(name: translate(context, "en")!,value: "en"),
                      SelectedListItem(name: translate(context, "ar")! ,value: "ar"),
                    ],
                    isDismissible: true,
                    searchHintText: translate(context, "Search")!,
                    bottomSheetTitle:  Text(translate(context,"Select")!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    submitButtonChild: const Text('Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selectedItems: (List<dynamic> selectedList)async {
                      SelectedListItem selectedListItem = selectedList[0];
                      Locale _temp = await setLocale(selectedListItem.value!);
                      MyApp.setLocale( context, _temp);
                    },
                  ),
                ).showModal(context);
            }),
            const Divider(color: Colors.black),
            buildListTile(translate(context,'My products')!, Icons.list_alt, "", Colors.deepOrange, onTab: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProductsScreen(products:AppCubit.get(context).myProducts ,),),);
            }),
            const Divider(color: Colors.black),
            buildListTile(translate(context,'My Address')!, Icons.location_on, '', Colors.pink, onTab: (){
              if(AppCubit.get(context).userData!.location!.addressName == "initialLocation")
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddress(),));
              else
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAddress(userModel: AppCubit.get(context).userData!,),));
            }),
            const Divider(color: Colors.black),
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(0),
              leading: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withAlpha(30)
                ),
                child: const Center(
                  child: Icon(Icons.notifications_none_outlined, color: Colors.blue,),
                ),
              ),
              title: Text(translate(context,"Notifications")!, style: const TextStyle(color: Colors.black,fontSize: 17)),
              trailing: Switch(
                  value: true,//controller.notification,
                  activeColor: AppColors.primary,
                  onChanged: (value){
                    // controller.changeNotification();
                  }),
            ),
            const Divider(color: Colors.black),
            buildListTile(translate(context,'Help Center')!, Icons.help, '', Colors.green, onTab: () {}),
            const Divider(color: Colors.black),
            buildListTile(translate(context,'Log Out')!, Icons.exit_to_app, '', Colors.red, onTab: (){ alertToLogOut(context);}),
            const Divider(color: Colors.black),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    ), listener: (context, state){});
  }
}

