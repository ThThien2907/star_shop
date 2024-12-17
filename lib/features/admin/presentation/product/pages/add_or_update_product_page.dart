import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:star_shop/common/bloc/categories/categories_display_state.dart';
import 'package:star_shop/common/constant/app_const.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/assets/app_images.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/image/upload_image.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/product/entities/product_entity.dart';
import 'package:star_shop/features/domain/product/use_cases/add_new_product_use_case.dart';
import 'package:star_shop/features/domain/product/use_cases/update_product_use_case.dart';

class AddOrUpdateProductPage extends StatefulWidget {
  const AddOrUpdateProductPage(
      {super.key, required this.isUpdate, this.productEntity});

  final bool isUpdate;
  final ProductEntity? productEntity;

  @override
  State<AddOrUpdateProductPage> createState() => _AddOrUpdateProductPageState();
}

class _AddOrUpdateProductPageState extends State<AddOrUpdateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController oldPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  String categoryID = '';

  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.productEntity != null) {
      nameController.text = widget.productEntity!.title;
      String productDescription =
          widget.productEntity!.description.replaceAll('\\n', '\n');
      descriptionController.text = productDescription;
      priceController.text = widget.productEntity!.price.toString();
      oldPriceController.text = widget.productEntity!.oldPrice.toString();
      quantityController.text =
          widget.productEntity!.quantityInStock.toString();

      categoryID = widget.productEntity!.categoryID;
      categoryController.text = context
          .read<CategoriesDisplayCubit>()
          .categories
          .firstWhere((e) => e.categoryID == categoryID)
          .title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: widget.isUpdate ? 'Update Product' : 'Add New Product',
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ButtonCubit(),
        child: BlocListener<ButtonCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pop(context, 'Data has changed');
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _image == null
                        ? Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: widget.isUpdate
                                  ? NetworkImage(
                                      widget.productEntity!.images[0])
                                  : const AssetImage(AppImages.imgNotFound),
                            )),
                          )
                        : Image.file(
                            _image!,
                            height: 200,
                            width: 200,
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Select Image"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                        title: 'Product Name',
                        hintText: 'Enter Product Name',
                        controller: nameController),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      title: 'Product Description',
                      hintText: 'Enter Product Description',
                      controller: descriptionController,
                      maxLines: 10,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _categoryField(context),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                        title: 'Product Price',
                        hintText: 'Enter Product Price',
                        controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                        title: 'Product Old Price',
                        hintText: 'Enter Product Old Price',
                        controller: oldPriceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                        title: 'Product Quantity',
                        hintText: 'Enter Product Quantity',
                        controller: quantityController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Builder(builder: (context) {
                      return ReactiveButton(
                        onPressed: widget.isUpdate
                            ? () async {
                                if (_image != null) {
                                  if (nameController.text.isNotEmpty ||
                                      descriptionController.text.isNotEmpty ||
                                      categoryController.text.isNotEmpty ||
                                      priceController.text.isNotEmpty ||
                                      oldPriceController.text.isNotEmpty ||
                                      quantityController.text.isNotEmpty) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final imageUrl =
                                        await UploadImage.uploadImage(
                                            imageFile: _image!,
                                            uploadPreset: 'products');

                                    if (imageUrl != null) {
                                      ProductEntity productEntity =
                                          ProductEntity(
                                        productID:
                                            widget.productEntity!.productID,
                                        title: nameController.text.trim(),
                                        description: descriptionController.text
                                            .trim()
                                            .replaceAll('\n', '\\n'),
                                        categoryID: categoryID,
                                        price: num.parse(
                                            priceController.text.trim()),
                                        oldPrice: num.parse(
                                            oldPriceController.text.trim()),
                                        images: [imageUrl],
                                        quantityInStock: num.parse(
                                            quantityController.text.trim()),
                                        salesNumber:
                                            widget.productEntity!.salesNumber,
                                        rating: widget.productEntity!.rating,
                                        reviews: widget.productEntity!.reviews,
                                        createdAt:
                                            widget.productEntity!.createdAt,
                                        updatedAt:
                                            Timestamp.fromDate(DateTime.now()),
                                      );

                                      context.read<ButtonCubit>().execute(
                                          useCase: UpdateProductUseCase(),
                                          params: productEntity);
                                    } else {
                                      AppSnackBar.showAppSnackBarFailure(
                                          context: context,
                                          title: 'Upload image failure');
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } else {
                                    AppSnackBar.showAppSnackBarFailure(
                                        context: context,
                                        title: 'Please enter all field');
                                  }
                                } else {
                                  ProductEntity productEntity = ProductEntity(
                                    productID: widget.productEntity!.productID,
                                    title: nameController.text.trim(),
                                    description: descriptionController.text
                                        .trim()
                                        .replaceAll('\n', '\\n'),
                                    categoryID: categoryID,
                                    price:
                                        num.parse(priceController.text.trim()),
                                    oldPrice: num.parse(
                                        oldPriceController.text.trim()),
                                    images: widget.productEntity!.images,
                                    quantityInStock: num.parse(
                                        quantityController.text.trim()),
                                    salesNumber:
                                        widget.productEntity!.salesNumber,
                                    rating: widget.productEntity!.rating,
                                    reviews: widget.productEntity!.reviews,
                                    createdAt: widget.productEntity!.createdAt,
                                    updatedAt:
                                        Timestamp.fromDate(DateTime.now()),
                                  );

                                  context.read<ButtonCubit>().execute(
                                      useCase: UpdateProductUseCase(),
                                      params: productEntity);
                                }
                              }
                            : () async {
                                if (_image != null) {
                                  if (nameController.text.isNotEmpty ||
                                      descriptionController.text.isNotEmpty ||
                                      categoryController.text.isNotEmpty ||
                                      priceController.text.isNotEmpty ||
                                      oldPriceController.text.isNotEmpty ||
                                      quantityController.text.isNotEmpty) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final imageUrl =
                                        await UploadImage.uploadImage(
                                            imageFile: _image!,
                                            uploadPreset: 'products');

                                    if (imageUrl != null) {
                                      ProductEntity productEntity =
                                          ProductEntity(
                                        productID:
                                            AppConst.generateRandomString(20),
                                        title: nameController.text.trim(),
                                        description: descriptionController.text
                                            .trim()
                                            .replaceAll('\n', '\\n'),
                                        categoryID: categoryID,
                                        price: num.parse(
                                            priceController.text.trim()),
                                        oldPrice: num.parse(
                                            oldPriceController.text.trim()),
                                        images: [imageUrl],
                                        quantityInStock: num.parse(
                                            quantityController.text.trim()),
                                        salesNumber: 0,
                                        rating: 5,
                                        reviews: [],
                                        createdAt:
                                            Timestamp.fromDate(DateTime.now()),
                                        updatedAt:
                                            Timestamp.fromDate(DateTime.now()),
                                      );

                                      context.read<ButtonCubit>().execute(
                                          useCase: AddNewProductUseCase(),
                                          params: productEntity);
                                    } else {
                                      AppSnackBar.showAppSnackBarFailure(
                                          context: context,
                                          title: 'Upload image failure');
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } else {
                                    AppSnackBar.showAppSnackBarFailure(
                                        context: context,
                                        title: 'Please enter all field');
                                  }
                                } else {
                                  AppSnackBar.showAppSnackBarFailure(
                                      context: context,
                                      title:
                                          'Please select 1 image for this product');
                                }
                              },
                        title: widget.isUpdate ? 'Save' : 'Add',
                      );
                    }),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryField(BuildContext context) {
    return AppTextField(
      title: 'Category',
      hintText: 'Select category',
      controller: categoryController,
      readOnly: true,
      suffixIcon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.textColor,
      ),
      onTap: () {
        AppBottomSheet.display(
          context: context,
          widget: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
            builder: (context, state) {
              if (state is CategoriesInitialState) {
                context.read<CategoriesDisplayCubit>().getCategories();
              }

              if (state is CategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (state is CategoriesLoadFailure) {
                return Center(child: AppErrorWidget(
                  onPress: () {
                    context.read<CategoriesDisplayCubit>().getCategories();
                  },
                ));
              }

              if (state is CategoriesLoaded) {
                List<CategoryEntity> categories = state.categories;
                return Column(
                  children: [
                    const Text(
                      'Select category',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.grey,
                      thickness: 2,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              categoryController.text = categories[index].title;
                              categoryID = categories[index].categoryID;
                              Navigator.pop(context);
                            },
                            title: Text(categories[index].title),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            color: AppColors.grey,
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 10,
                          );
                        },
                        itemCount: categories.length,
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
