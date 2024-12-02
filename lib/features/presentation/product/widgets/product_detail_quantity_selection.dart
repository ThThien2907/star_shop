import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/presentation/product/bloc/product_quantity_selection_cubit.dart';

class ProductDetailQuantitySelection extends StatelessWidget {
  const ProductDetailQuantitySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductQuantitySelectionCubit, int>(
      builder: (context, state) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                context.read<ProductQuantitySelectionCubit>().decrement();
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.black100,
                ),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: AppColors.textColor,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              state.toString(),
              style:
              const TextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                context.read<ProductQuantitySelectionCubit>().increment();
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.textColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
