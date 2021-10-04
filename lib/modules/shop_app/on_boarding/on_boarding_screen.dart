import 'package:flutter/material.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/network/local/cache_helper.dart';
import 'package:my_first_proj/Shared/stayles/colors.dart';
import 'package:my_first_proj/modules/basics_app/login/Login_Screen.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boaredController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/1.png',
      title: 'On Fire ',
      body: 'List of offers up to 70% off',
    ),
    BoardingModel(
      image: 'assets/images/2.png',
      title: 'Delivery Service',
      body: 'Fast home delivery within minutes in Cairo and hours in all other governorates',
    ),
    BoardingModel(
      image: 'assets/images/3.png',
      title: 'Otlab Service ',
      body: 'With us, you will eat all kinds of food around the world',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppCubit.get(context).changeAppMode();
              },
              icon: Icon(Icons.brightness_4_outlined)),
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text("SKIP"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if (index == boarding.length-1) {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boaredController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boaredController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,

                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit();
                    }
                    else {
                      boaredController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage("${model.image}"),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "${model.title}",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Text(
          "${model.body}",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void submit()
  {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value){
      if (value)
        {
          navigateAndFinish(context, ShopLogin());
        }
    });
  }
}
