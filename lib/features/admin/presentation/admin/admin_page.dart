import 'dart:math';

import 'package:flutter/material.dart';
import 'package:star_shop/features/data/auth/data_sources/auth_firebase_service.dart';
import 'package:star_shop/features/data/product/models/product_model.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/get_products_by_category_use_case.dart';
import 'package:star_shop/features/domain/product/use_cases/get_top_selling_use_case.dart';
import 'package:star_shop/service_locator.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  String a = '';

  @override
  Widget build(BuildContext context) {

    String generateRandomString(int length) {
      const characters =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();

      return List.generate(
              length, (index) => characters[random.nextInt(characters.length)])
          .join();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('title'),
            TextField(
              controller: controller1,
            ),
            Text('des'),
            TextField(
              controller: controller,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
            ),
            Text('cate'),
            TextField(
              controller: controller2,
            ),
            Text('price'),
            TextField(
              controller: controller3,
            ),
            Text('old price'),
            TextField(
              controller: controller4,
            ),
            ElevatedButton(
              onPressed: () async {
                // final randomString =
                // generateRandomString(20); // Change length as needed
                // //
                // // print(randomString);
                // a = controller.text.replaceAll('\n', '\\n');
                //
                // var pro = ProductModel(
                //   productID: randomString,
                //   title: controller1.text.trim(),
                //   description: a,
                //   categoryID: controller2.text.trim(),
                //   price: int.parse(controller3.text.trim()),
                //   oldPrice: int.parse(controller4.text.trim()),
                //   images: [],
                //   quantityInStock: 10,
                //   salesNumber: 0,
                //   rating: 5.0,
                //   reviews: [],
                // );
                // var res = await sl<AuthFirebaseService>().setPro(pro);
                // print(a);

                var res = await GetProductsByCategoryUseCase().call(params: 'category00');
                res.fold(
                  (ifLeft) {
                    print(ifLeft);
                  },
                  (ifRight) {
                    List<ProductEntity> products = ifRight;
                    print(products.length);
                  },
                );
              },
              child: Text('asd'),
            ),
            // Text(a.isEmpty ? '' : a),
          ],
        ),
      ),
    );
  }
}
