import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eduease/utils/cache.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

import '../../Moduals/user_moduls.dart';

part 'main_event.dart';
part 'main_state.dart';
class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<init_event>(init_void);
  }

  user_moduls? user_mouduls ;


  Future<FutureOr<void>> init_void(init_event event, Emitter<MainState> emit) async {
    print("start");
    DataSnapshot a = await FirebaseDatabase.instance.ref().ref.child("Edudy").child("users").get();
    for (var element in a.children) {
      if ((element.value as Map)["number"] == '"${cache.get_data("number")}"') {
        print(element.value);
        user_mouduls=user_moduls.fromjson(element.value);
        emit(init_state());
      }
    }
  }
}
