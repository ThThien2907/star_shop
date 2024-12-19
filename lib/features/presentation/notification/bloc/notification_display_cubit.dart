import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_shop/features/presentation/notification/bloc/notification_display_state.dart';

class NotificationDisplayCubit extends Cubit<NotificationDisplayState> {
  NotificationDisplayCubit() : super(NotificationDisplayInitialState());

  StreamSubscription<QuerySnapshot>? _subscription;
  List<Map<String, dynamic>> listNotify = [];

  void listenToCollection(String userId) {
    emit(NotificationDisplayLoading());

    _subscription = FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {

        final data = snapshot.docs.map((doc) => doc.data()).toList();

        if(listNotify.isEmpty){
          listNotify = data;
        }

        emit(NotificationDisplayLoaded(data: data));
      },
      onError: (error) {
        emit(NotificationDisplayLoadFailure());
      },
    );
  }

  makeAsRead(String notificationID) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').doc(notificationID).update({
        'isRead': true,
      });
    }
    catch (e){
    }
  }

  void stopListening() {
    _subscription?.cancel();
    emit(NotificationDisplayInitialState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
