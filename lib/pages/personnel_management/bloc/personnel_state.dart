import '../../../data/model/personnel_management.dart';

abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoading extends AddEmployeeState {}

class AddEmployeeSuccess extends AddEmployeeState {}


class GetEmployeeSuccess extends AddEmployeeState {
  final List<PersonnelManagement> employees;
  GetEmployeeSuccess(this.employees);
}

class AddEmployeeFailure extends AddEmployeeState {
  final String error;
  AddEmployeeFailure(this.error);
}

class DeleteEmployeeSuccess extends AddEmployeeState {}
class DeleteEmployeeFailure extends AddEmployeeState {
  final String error;
  DeleteEmployeeFailure(this.error);
}


class UpdateEmployeeSuccess extends AddEmployeeState {}
class UpdateEmployeeFailure extends AddEmployeeState {
  final String error;
  UpdateEmployeeFailure(this.error);
}
class UpdateEmployeeLoading extends AddEmployeeState {}