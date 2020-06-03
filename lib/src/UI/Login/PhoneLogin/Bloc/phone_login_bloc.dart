import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PhoneLoginBloc extends Bloc<PhoneLoginEvent, PhoneLoginState> {
  @override
  PhoneLoginState get initialState => InitialPhoneLoginState();

  @override
  Stream<PhoneLoginState> mapEventToState(
    PhoneLoginEvent event,
  ) async* {
  if(event is NewPhoneLoginEvent){
    yield LoadingPhoneLoginState();
    final data = await Future.delayed(Duration(seconds: 2),(){
      return "Logged In with ${event.phoneNumber}";
    });
    yield LoadedPhoneLoginState(data);
  }
  }
}
