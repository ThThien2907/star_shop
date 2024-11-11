import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_shop/features/presentation/auth/pages/sign_in_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Profile page'),
          Text(FirebaseAuth.instance.currentUser!.email ?? ''),
          ElevatedButton(onPressed: (){
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
            FirebaseAuth.instance.signOut();
          }, child: Text('log out'))
        ],
      ),
    );
  }
}
