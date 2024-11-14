import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/app_button.dart';
import 'package:star_shop/configs/assets/app_images.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';
import 'package:star_shop/features/presentation/notification/pages/notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(
                color: AppColors.subtextColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Ta Thanh Thien',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        action: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
              },
              icon: Icon(
                Icons.notifications_none,
                size: 28,
                color: AppColors.textColor,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('aaa');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      size: 26,
                      color: AppColors.subtextColor,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    // AnimatedTextKit(
                    //   repeatForever: true,
                    //   animatedTexts: [
                    //     TypewriterAnimatedText('Find your favorite items',
                    //         textStyle: TextStyle(
                    //           fontSize: 16,
                    //           color: AppColors.subtextColor,
                    //         ),
                    //         speed: Duration(milliseconds: 80)),
                    //   ],
                    //   onTap: () {
                    //     print('aaaa');
                    //   },
                    // ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  backgroundColor: Color(0xff09090C),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.subtextColor,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AppButton(
                          onPressed: () {},
                          width: 60,
                          height: 60,
                          widget: SvgPicture.asset(
                            AppVectors.dressIcon,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Fashion',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.subtextColor,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 14,
                    );
                  },
                  itemCount: 10,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppImages.banner),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'Hot Deal',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(AppImages.imgNotFound),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Column(
                                children: [
                                  Text(
                                    'Portable Neck Fan Hands Free Fan, Portable Neck Fan Hands Free Fan,',
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$40',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '\$60',
                                        style: TextStyle(
                                          color: AppColors.subtextColor,
                                          fontSize: 16,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: AppColors.subtextColor,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          AppVectors.starCircleIcon),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '4.8',
                                        style: TextStyle(
                                          color: AppColors.subtextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '(120)',
                                        style: TextStyle(
                                          color: AppColors.subtextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),

                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: (){},
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Icon(Icons.favorite_border, color: AppColors.primaryColor, size: 18,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
