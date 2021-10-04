import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/stayles/colors.dart';
import 'package:my_first_proj/models/shop_app/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,states){} ,
      builder: (context,states){
        var cubit= ShopCubit.get(context);
        return Conditional.single(
            context: (context),
            conditionBuilder:(context)=>states is! ShopLoadingGetFavoritesState,
            widgetBuilder: (context)=> ShopCubit.get(context).favoritesModel!=null?
            ListView.separated(
              itemBuilder: (context, index)=>buildFavItem(ShopCubit.get(context).favoritesModel!.data.data[index],context),
              separatorBuilder: (context, index)=>myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
            ) :
            Center(
              child: Text(
                  "لسه مافيش حاجه في متجرنا عاجبه سيادتك ",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20.0,
                ),
              ),
            ),
            fallbackBuilder: (context)=> Center(child: CircularProgressIndicator()) ,
          );


      },
    );
  }

  Widget buildFavItem(FavoritesData model,context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage("${model.product.image}"),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.product.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          "${model.product.oldPrice.round()}" ,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.product.id);
                          print(model.product.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          child: Icon(
                            ShopCubit.get(context).favorites![model.product.id]==true?Icons.favorite:Icons.favorite_border,
                            size: 14.0,
                            color: ShopCubit.get(context).favorites![model.product.id]==true?Colors.red:Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
