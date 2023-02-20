
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/home_view/home_view.dart';
import 'package:flutter/material.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            borderRadius:BorderRadius.circular(25),
            onTap: (){
              print('search');
            },
            child: Container(
              height: 40,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  Text(
                    'Search on BarterIt',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                    ),
                  ),

                ],
              ),
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
                },
                icon: Icon(Icons.add_box_rounded),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find items to barter',
              style: TextStyle(
                fontSize: 25,

              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio:1,
                    ),
                    itemBuilder:(context , index)=>categoryBuilder(Colors.grey) ,
                    itemCount: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
