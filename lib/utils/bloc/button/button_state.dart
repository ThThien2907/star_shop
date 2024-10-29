abstract class ButtonState {}

class ButtonInitialState extends ButtonState {}

class ButtonLoadingState extends ButtonState {}

class ButtonSuccessState extends ButtonState {}

class ButtonFailureState extends ButtonState {
  final String errorCode;

  ButtonFailureState({required this.errorCode});
}