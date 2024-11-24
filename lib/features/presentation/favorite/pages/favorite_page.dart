import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_state.dart';
import 'package:star_shop/common/widgets/app_bar/app_bar_notification_icon.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/product/products_grid_view.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/common/bloc/favorite/favorite_product_cubit.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarNotificationIcon(
        title: 'Favorites',
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteProductCubit, FavoriteProductState>(
        builder: (context, state) {
          if (state is FavoriteProductInitialState) {
            context.read<FavoriteProductCubit>().getFavorite();
          }

          if (state is FavoriteProductLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is FavoriteProductLoadFailure) {
            return AppErrorWidget(
              onPress: () {
                context.read<FavoriteProductCubit>().getFavorite();
              },
            );
          }

          if (state is FavoriteProductLoaded) {
            List<ProductEntity> products = state.products;
            if (products.isEmpty) {
              return _emptyFavorite(context);
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: ProductsGridView(products: products, itemCount: products.length,),
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _emptyFavorite(BuildContext context){
    return const Center(
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: AppColors.subtextColor,
              size: 92,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'No Saved Items!',
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'You don’t have any saved items. Go to home and add some.',
              style: TextStyle(
                color: AppColors.subtextColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
