import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PhoneLoginEvent extends Equatable {
  const PhoneLoginEvent();
}

class NewPhoneLoginEvent extends PhoneLoginEvent{
  final String phoneNumber;
  NewPhoneLoginEvent({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

}
class VerifyOTP extends PhoneLoginEvent{
  final String otp;
  VerifyOTP({@required this.otp});

  @override
  List<Object> get props => [otp];

}
