import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';
import 'package:star_shop/features/data/product/models/review_model.dart';
import 'package:star_shop/service_locator.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();

    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     maxLines: 20,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        // ),
        child: ElevatedButton(
          onPressed: () async {
            // final randomString =
            //     generateRandomString(20); // Change length as needed
            // //
            // // print(randomString);
            // var pro = ProductModel(
            //   productID: randomString,
            //   title: 'Laptop Lenovo V14 G4 IRU 83A000BHVN',
            //   description: 'description',
            //   price: 529,
            //   oldPrice: 599,
            //   images: [
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097926/z6052154659891_6812cf1b141ed11999964f349b17d893_t8i6hp.jpg',
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097927/z6052154659887_506aaef1783cf95b9a79e1a19046d22c_zsygdm.jpg',
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097927/z6052154659803_7a7bb3e6fc9fa892d5912ce47f5c34ec_zoupzn.jpg',
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097927/z6052154624257_d657223f5fe1cacaa8421914e83cc8d7_zdzisw.jpg',
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097927/z6052154624261_e27a326671307e9c620ca397378a9d51_o884xa.jpg',
            //     'https://res.cloudinary.com/starshop/image/upload/v1732097927/z6052154624250_291764e7125aecb6b4f9ce5c7954797a_yoykx5.jpg'
            //   ],
            //   quantity: 10,
            //   sold: 0,
            //   rating: 5.0,
            //   reviews: [],
            // );
            // var res = await sl<AuthFirebaseService>().setPro(pro);
          },
          child: Text('Cart page'),
        ),
      ),
    );
  }
}

class Cate {
  String title;
  String img;
  String id;

  Cate(this.title, this.img, this.id);
}
