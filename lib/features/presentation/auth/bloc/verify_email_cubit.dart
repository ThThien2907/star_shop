import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/domain/auth/use_cases/send_email_verify_email_use_case.dart';
import 'package:star_shop/features/presentation/auth/bloc/verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState>{
  VerifyEmailCubit() : super(NotVerifiedState());

  Timer? timer;
  Future<void> sendEmailToVerifyEmail() async {
    emit(NotVerifiedState());
    await SendEmailVerifyEmailUseCase().call();
    timer = Timer.periodic(const Duration(seconds: 3), (_){
      FirebaseAuth.instance.currentUser!.reload();
      bool isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      if(isVerify){
        emit(VerifiedState());
        timer!.cancel();
      }
    });
  }
}