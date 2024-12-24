import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/local/cache_helper.dart';
import '../shop_register/shop_login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onBoardingController = PageController();

    List<OnBoardingContent> content = [
      OnBoardingContent(
          'First Title', 'First Desc', 'assets/images/onBoard.png'),
      OnBoardingContent(
          'Second Title', 'Second Desc', 'assets/images/onBoard.png'),
      OnBoardingContent(
          'Third Title', 'Third Desc', 'assets/images/onBoard.png'),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'skip',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: onBoardingController,
                onPageChanged: (index) {
                  if (index == content.length - 1) {
                    Future.delayed(Duration(seconds: 2), () {
                      submit(context);
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildItem(content[index]);
                },
                itemCount: content.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.deepOrange,
                      spacing: 5,
                      expansionFactor: 3),
                  count: content.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    onBoardingController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    CacheHelper.saveData(key: 'on_boarding', value: true)
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopLoginScreen(),
              ),
            ));
  }

  Widget buildItem(OnBoardingContent content) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(content.image)),
          SizedBox(
            height: 12,
          ),
          Text(content.title),
          SizedBox(
            height: 12,
          ),
          Text(content.description),
          //PageView.builder(itemBuilder: itemBuilder)
        ],
      );
}

class OnBoardingContent {
  String title, description, image;

  OnBoardingContent(this.title, this.description, this.image);
}
