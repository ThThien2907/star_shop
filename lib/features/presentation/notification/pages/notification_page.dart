import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/common/bloc/auth/user_info_display_cubit.dart';
import 'package:star_shop/common/widgets/app_bar/basic_app_bar.dart';
import 'package:star_shop/common/widgets/error/app_error_widget.dart';
import 'package:star_shop/configs/theme/app_colors.dart';
import 'package:star_shop/features/admin/presentation/navigation_drawer/pages/navigation_drawer_page.dart';
import 'package:star_shop/features/presentation/notification/bloc/notification_display_cubit.dart';
import 'package:star_shop/features/presentation/notification/bloc/notification_display_state.dart';
import 'package:star_shop/features/presentation/order/pages/order_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppBar(
        title: 'Notifications',
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationDisplayCubit, NotificationDisplayState>(
        builder: (context, state) {
          if (state is NotificationDisplayLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is NotificationDisplayLoadFailure) {
            return Center(
              child: AppErrorWidget(
                onPress: () {
                  context.read<NotificationDisplayCubit>().listenToCollection(
                      FirebaseAuth.instance.currentUser!.uid);
                },
              ),
            );
          }

          if (state is NotificationDisplayLoaded) {
            List<Map<String, dynamic>> data = state.data;

            if (data.isEmpty) {
              return const Center(
                child: Text('No Notification'),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: (){
                    if(data[index]['isRead'] == false){
                      context.read<NotificationDisplayCubit>().makeAsRead(data[index]['notificationID']);
                    }
                    var userEntity = context.read<UserInfoDisplayCubit>().userEntity;
                    if(userEntity.role == 'AD') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationDrawerPage(userEntity: userEntity, activePage: 3)));
                    }
                    else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPage()));
                    }
                  },
                  title: Text(
                    data[index]['title'],
                    style: TextStyle(
                        color: !data[index]['isRead'] ? AppColors.textColor : AppColors.textColor.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      data[index]['message'],
                      style: TextStyle(
                        color: !data[index]['isRead'] ? AppColors.subtextColor : AppColors.subtextColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: AppColors.grey,
                  indent: 10,
                  endIndent: 10,
                );
              },
              itemCount: state.data.length,
            );
          }

          return Container();
        },
      ),
    );
  }
}
