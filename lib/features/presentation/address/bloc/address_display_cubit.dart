import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/domain/auth/entities/user_address_entity.dart';
import 'package:star_shop/features/domain/auth/use_cases/get_address_use_case.dart';
import 'package:star_shop/features/domain/auth/use_cases/remove_address_use_case.dart';
import 'package:star_shop/features/domain/auth/use_cases/set_default_address_use_case.dart';
import 'package:star_shop/features/presentation/address/bloc/address_display_state.dart';

class AddressDisplayCubit extends Cubit<AddressDisplayState> {
  AddressDisplayCubit() : super(AddressDisplayInitialState());

  int defaultAddress = 0;
  List<UserAddressEntity> listAddress = [];

  getAddress() async {
    emit(AddressDisplayLoading());

    var currentUser = FirebaseAuth.instance.currentUser;
    var response = await GetAddressUseCase().call(params: currentUser!.uid);

    response.fold(
      (error) {
        emit(AddressDisplayLoadFailure(error: error));
      },
      (data) {
        listAddress = data;
        for (var i = 0; i < listAddress.length; i++) {
          if (listAddress[i].isDefault == true) {
            defaultAddress = i;
            break;
          }
        }
        emit(AddressDisplayLoaded(list: listAddress));
      },
    );
  }

  setDefaultAddress(String addressId) async {
    var response = await SetDefaultAddressUseCase().call(params: addressId);

    response.fold(
      (error) {},
      (data) {
        for (var i in listAddress) {
          if (i.isDefault == true) {
            i.isDefault = false;
            break;
          }
        }

        for (var i = 0; i < listAddress.length; i++) {
          if (listAddress[i].addressId == addressId) {
            listAddress[i].isDefault = true;
            defaultAddress = i;
            break;
          }
        }

        emit(AddressDisplayLoaded(list: listAddress));
      },
    );
  }

  Future<bool> removeAddress(UserAddressEntity userAddressEntity) async {
    if (userAddressEntity.isDefault == true) {
      return false;
    }

    var response =
        await RemoveAddressUseCase().call(params: userAddressEntity.addressId);
    return response.fold(
      (error) {
        return false;
      },
      (data) {
        listAddress.removeWhere((e) => e.addressId == userAddressEntity.addressId);
        emit(AddressDisplayLoaded(list: listAddress));
        return true;
      },
    );
  }
}
