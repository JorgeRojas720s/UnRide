import 'package:bloc/bloc.dart';

enum UserRole { driver, client }

class RoleCubit extends Cubit<UserRole> {
  RoleCubit() : super(UserRole.client);

  void setClient() => emit(UserRole.client);
  void setDriver() => emit(UserRole.driver);
}
