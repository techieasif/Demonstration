import 'package:equatable/equatable.dart';

abstract class PhoneLoginState extends Equatable {
  const PhoneLoginState();
}

class InitialPhoneLoginState extends PhoneLoginState {
  @override
  List<Object> get props => [];
}
class LoadingPhoneLoginState extends PhoneLoginState {
  @override
  List<Object> get props => [];
}
class LoadedPhoneLoginState extends PhoneLoginState {
  ///TODO: define its data type.
  final loginData;
  LoadedPhoneLoginState(this.loginData);
  @override
  List<Object> get props => [loginData];
}
class OTPVerificationState extends PhoneLoginState {
  ///TODO: define its data type.
  final loginData;
  OTPVerificationState(this.loginData);
  @override
  List<Object> get props => [loginData];
}


class ErrorPhoneLoginState extends PhoneLoginState {
  final String error;

  ErrorPhoneLoginState(this.error);
  @override
  List<Object> get props => [error];
}
