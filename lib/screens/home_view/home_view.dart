
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/categories_screen/categories_view.dart';
import 'package:barter_it/screens/item_details_screen/item-details_view.dart';
import 'package:flutter/material.dart';
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back ,Abdo',
              style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  borderRadius:BorderRadius.circular(25),
                  onTap: (){
                    print('search');
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
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
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(),));
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.buttonColor,
                      ),
                    ),
                )
              ],
            ),
            Container(
              height: 110,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => categoryBuilder(AppColors.bottomNavColor),
                itemCount: 6,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: GridView.builder(
                  shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 3/4,
                  ),
                itemBuilder:(context , index)=>itemBuilder(context) ,
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}


Widget categoryBuilder(Color color)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 5,
           // spreadRadius: 3.0,
          ),
        ],
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image),
          Text('Item'),
        ],
      ),
    ),
  );
}

Widget itemBuilder(context)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsScreen(),));
        print('details');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              // spreadRadius: 3.0,
            ),
          ],
        ),
      //  height: 250,
       // width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                  child: Image.asset(
                      'assets/images/item.jpg',
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "\$50,000",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Hyundai plug',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,size: 15,),
                  Expanded(
                    child: Text(
                      'Egypt ,cairo,street 12',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}