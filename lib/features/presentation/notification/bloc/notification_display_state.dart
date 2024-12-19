class NotificationDisplayState {}

class NotificationDisplayLoaded extends NotificationDisplayState{
  final List<Map<String, dynamic>> data;

  NotificationDisplayLoaded({required this.data});
}

class NotificationDisplayLoading extends NotificationDisplayState{}

class NotificationDisplayLoadFailure extends NotificationDisplayState{}

class NotificationDisplayInitialState extends NotificationDisplayState{}