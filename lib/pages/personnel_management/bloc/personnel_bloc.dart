// add_employee_cubit.dart
import 'dart:math';

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

  Future<void> deleteEmployee(String id, BuildContext context) async {
    emit(AddEmployeeLoading());
    try {
      PersonnelService().deletePersonnel(id);
      emit(DeleteEmployeeSuccess());
    } catch (e) {
      emit(DeleteEmployeeFailure(e.toString()));
    }
  }

  Future<void> updateEmployee(
      String id, PersonnelManagement employee) async {
    emit(UpdateEmployeeLoading());
    try {
      PersonnelService().updatePersonnel(id, employee);
      emit(UpdateEmployeeSuccess());
    } catch (e) {
      emit(UpdateEmployeeFailure(e.toString()));
    }
  }
}
