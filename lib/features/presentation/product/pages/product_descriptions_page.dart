import 'package:flutter/material.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/configs/theme/app_colors.dart';

class ProductDescriptionsPage extends StatelessWidget {
  const ProductDescriptionsPage({super.key, required this.productDescription});

  final String productDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: 'Product Descriptions',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Text(
            productDescription,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.subtextColor,
            ),
          ),
        ),
      ),
    );
  }
}
