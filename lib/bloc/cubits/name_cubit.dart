import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit({required String name}) : super(name);

  void change(String name) => emit(name);
}
