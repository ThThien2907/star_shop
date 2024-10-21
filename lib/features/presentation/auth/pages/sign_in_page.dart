import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_shop/configs/assets/app_vectors.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/utils/widgets/button/app_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login to STARSHOP',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.googleIcon),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Login with Google',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
                  side: BorderSide(color: AppColors.primaryColor, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 16,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.appleIcon),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Login with Apple',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
                  side: BorderSide(color: AppColors.primaryColor, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 48,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.grey,
                    thickness: 2,
                    endIndent: 10,
                  ),
                ),
                Text(
                  "Or",
                  style: TextStyle(color: AppColors.grey, fontSize: 18),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.grey,
                    thickness: 2,
                    indent: 10,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            AppButton(
              onPressed: () {},
              title: 'Login with Email',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have any account yet?',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 5,),
                InkWell(
                  onTap: (){},
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
