import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:star_shop/common/bloc/button/button_cubit.dart';
import 'package:star_shop/common/bloc/button/button_state.dart';
import 'package:star_shop/common/constant/app_const.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/button/reactive_button.dart';
import 'package:star_shop/common/widgets/input_field/app_text_field.dart';
import 'package:star_shop/common/widgets/snack_bar/app_snack_bar.dart';
import 'package:star_shop/configs/assets/app_images.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/image/upload_image.dart';
import 'package:star_shop/features/domain/category/entities/category_entity.dart';
import 'package:star_shop/features/domain/category/use_cases/add_new_category_use_case.dart';
import 'package:star_shop/features/domain/category/use_cases/update_category_use_case.dart';

class AddOrUpdateCategoryPage extends StatefulWidget {
  const AddOrUpdateCategoryPage(
      {super.key, required this.isUpdate, this.categoryEntity});

  final bool isUpdate;
  final CategoryEntity? categoryEntity;

  @override
  State<AddOrUpdateCategoryPage> createState() =>
      _AddOrUpdateCategoryPageState();
}

class _AddOrUpdateCategoryPageState extends State<AddOrUpdateCategoryPage> {
  final TextEditingController categoryNameController = TextEditingController();

  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.categoryEntity != null) {
      categoryNameController.text = widget.categoryEntity!.title;
    }
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: widget.isUpdate ? 'Update Category' : 'Add New Category',
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
                                  ? NetworkImage(widget.categoryEntity!.image)
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
                        title: 'Category Name',
                        hintText: 'Enter Category Name',
                        controller: categoryNameController),
                    const SizedBox(
                      height: 32,
                    ),
                    Builder(builder: (context) {
                      return ReactiveButton(
                        onPressed: widget.isUpdate
                            ? () async {
                                if (_image != null) {
                                  if (categoryNameController.text.isNotEmpty) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final imageUrl =
                                        await UploadImage.uploadImage(
                                            imageFile: _image!,
                                            uploadPreset: 'categories');

                                    if (imageUrl != null) {
                                      CategoryEntity categoryEntity =
                                          CategoryEntity(
                                              categoryID: widget
                                                  .categoryEntity!.categoryID,
                                              image: imageUrl,
                                              title: categoryNameController.text
                                                  .trim());

                                      context.read<ButtonCubit>().execute(
                                          useCase: UpdateCategoryUseCase(),
                                          params: categoryEntity);
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
                                        title: 'Please enter category name');
                                  }
                                } else {
                                  CategoryEntity categoryEntity =
                                      CategoryEntity(
                                          categoryID:
                                              widget.categoryEntity!.categoryID,
                                          image: widget.categoryEntity!.image,
                                          title: categoryNameController.text
                                              .trim());

                                  context.read<ButtonCubit>().execute(
                                      useCase: UpdateCategoryUseCase(),
                                      params: categoryEntity);
                                }
                              }
                            : () async {
                                if (_image != null) {
                                  if (categoryNameController.text.isNotEmpty) {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    final imageUrl =
                                        await UploadImage.uploadImage(
                                            imageFile: _image!,
                                            uploadPreset: 'categories');

                                    if (imageUrl != null) {
                                      CategoryEntity categoryEntity =
                                          CategoryEntity(
                                              categoryID:
                                                  AppConst.generateRandomString(
                                                      20),
                                              image: imageUrl,
                                              title: categoryNameController.text
                                                  .trim());

                                      context.read<ButtonCubit>().execute(
                                          useCase: AddNewCategoryUseCase(),
                                          params: categoryEntity);
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
                                        title: 'Please enter category name');
                                  }
                                } else {
                                  AppSnackBar.showAppSnackBarFailure(
                                      context: context,
                                      title:
                                          'Please select 1 image for this category');
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
}
