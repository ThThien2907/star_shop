import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/utils/bloc/button/button_cubit.dart';
import 'package:star_shop/utils/bloc/button/button_state.dart';

class ReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final Widget? widget;
  final double? width;
  final double? height;

  const ReactiveButton({
    super.key,
    required this.onPressed,
    this.title,
    this.widget,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonCubit, ButtonState>(
      builder: (context, state) {
        if(state is ButtonLoadingState){
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _initial(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: widget ??
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
    );
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 60,
        ),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
