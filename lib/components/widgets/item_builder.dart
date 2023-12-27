
import 'package:barter_it/models/product_model.dart';
import 'package:barter_it/resources/colors.dart';
import 'package:barter_it/screens/item_details_screen/item-details_view.dart';
import 'package:flutter/material.dart';
class ItemBuilder extends StatelessWidget {
  const ItemBuilder({Key? key,required this.context,required this.product}) : super(key: key);
  final context;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDetailsScreen(productModel: product),));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 8,
                // spreadRadius: 3.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:const  BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                  child: Hero(
                    tag: product.images![0].toString(),
                    child: Image.network(product.images![0],fit: BoxFit.cover,width: double.infinity,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 1.0),
                child: Text(
                  product.price!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 1.0),
                child: Text(
                  product.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
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
                    const Icon(Icons.location_on,size: 15,),
                    SizedBox(width: 5,),
                    Expanded(
                      child: Text(
                        product.owner!.location!.addressCity!+" , " +product.owner!.location!.addressStreet!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.blueGrey),
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
}
