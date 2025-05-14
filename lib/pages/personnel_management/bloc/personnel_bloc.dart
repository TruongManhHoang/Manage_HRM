// add_employee_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/model/personnel_management.dart';
import '../../../service/personnel_service.dart';
import 'personnel_state.dart';

class PersonelCubit extends Cubit<AddEmployeeState> {
  PersonelCubit() : super(AddEmployeeInitial());

  Future<void> addEmployee(
      PersonnelManagement employee, BuildContext context) async {
    emit(AddEmployeeLoading());
    try {
      PersonnelService().addPersonnel(employee, context);
      emit(AddEmployeeSuccess());
    } catch (e) {
      emit(AddEmployeeFailure(e.toString()));
    }
  }

  Future<List<PersonnelManagement>> getEmployee() async {
    emit(AddEmployeeLoading());
    try {
      List<PersonnelManagement> employees =
          await PersonnelService().getAllPersonnel();
      emit(GetEmployeeSuccess(employees));
      return employees;
    } catch (e) {
      emit(AddEmployeeFailure(e.toString()));
      return [];
    }
  }
}
