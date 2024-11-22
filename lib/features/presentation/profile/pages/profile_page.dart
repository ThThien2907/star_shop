import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/auth/entities/user_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/get_user_use_case.dart';
import 'package:star_shop/features/domain/auth/use_cases/update_profile_use_case.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Profile page'),
          // Text(FirebaseAuth.instance.currentUser!.uid ?? ''),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                    (route) => false);
                if (FirebaseAuth.instance.currentUser != null) {
                  FirebaseAuth.instance.signOut();
                }
              },
              child: Text('log out')),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                var user = UserEntity(
                  userId: 'hehe',
                  fullName: 'Than 123h Thien',
                  email: 'thien@gmail.com',
                  dob: '29/7/2003',
                  phoneNumber: '0768628508',
                  address: '11  bang',
                  city: 'HCM',
                  district: 'Tan ',
                  ward: ' 14',
                  gender: 'Male',
                  role: 'UR',
                );

                var response = await UpdateProfileUseCase().call(params: user);
                response.fold(
                  (ifLeft) {},
                  (ifRight) {
                    var snackBar = SnackBar(
                      content: Text(
                        ifRight,
                        style: TextStyle(color: AppColors.textColor, fontSize: 16),
                      ),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
              child: Text('log out')),

          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                var response = await GetUserUseCase().call(params: FirebaseAuth.instance.currentUser!.uid);
                response.fold((ifLeft){}, (ifRight){
                  UserEntity user = ifRight;
                  print(user.toString());
                },);
              },
              child: Text('log out')),
        ],
      ),
    );
  }
}
