import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/cubit.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/stayles/colors.dart';
import 'package:my_first_proj/modules/newsapp_modules/webview/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function function,
  required String text,
  double redius = 0,
  bool isUpperCase = true,
}) =>
    Container(
      height: 40,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmitted,
  required Function onChange,
  required Function onTap,
  required Function validate,
  required String label,
  String? hint,
  bool? isPassword = false,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  bool isVaildator = false,
  double ? focusedBorderReduis ,
  double ? enabledBorderReduis  ,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword!,
    enabled: isClickable,
    onFieldSubmitted: (String? s) {
      onSubmitted!(s);
    },
    onTap: onTap(),
    onChanged: onChange(),
    validator: (s) {
      if (isVaildator == true) if (s!.isEmpty && s.trim().length == 0) {
        return "${label} mustn't be empty";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
        ),
      ),
      border: OutlineInputBorder(),
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixPressed!();
              },
              icon: Icon(suffix),
            )
          : null,
    ),
  );
}

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              "${model['time']}",
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${model['title']}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${model['date']}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDatabase(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDatabase(status: 'archived', id: model['id']);
            },
            icon: Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteDatabase(id: model['id']);
    },
  );
}

Widget buildArticleItem(article, context, {bool isBisness = true}) {
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        WebViewScreen(article['url']),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 380,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            article['title'],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8),
          Text(
            article['description'] != null ? article['description'] : "",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    ),
  );
}

Widget articleBuilder(List list, context,
    {isSearch = false, isBisness = true}) {
  return list.length > 0
      ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context, isBisness: isBisness),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
        )
      : isSearch
          ? Container()
          : Center(child: CircularProgressIndicator());
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);
}

void defaultToastMsg({
  required String Message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: Message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget buildListProduct(model,context)
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
                  image: NetworkImage("${model.image}"),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
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
                  "${model.name}",
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
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        child: Icon(
                          ShopCubit.get(context).favorites![model.id]==true?Icons.favorite:Icons.favorite_border,
                          size: 14.0,
                          color: ShopCubit.get(context).favorites![model.id]==true?Colors.red:Colors.white,
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

