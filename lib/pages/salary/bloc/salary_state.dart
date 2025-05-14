import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:equatable/equatable.dart';

abstract class SalaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

// class SalaryInitial extends SalaryState {}

// class SalaryLoading extends SalaryState {}

// class SalarySuccess extends SalaryState {
//   final List<SalaryModel> salaries;

//   SalarySuccess(this.salaries);

//   @override
//   List<Object?> get props => [salaries];
// }

// class SalaryLoaded extends SalaryState {
//   final List<SalaryModel> salaries;

//   SalaryLoaded(this.salaries);

//   @override
//   List<Object?> get props => [salaries];
// }

// class SalaryLoaded extends SalaryState {
//   final List<SalaryModel> salaries;

//   SalaryLoaded(this.salaries);

//   @override
//   List<Object?> get props => [salaries];
// }

// class SalaryFailure extends SalaryState {
//   final String error;

//   SalaryFailure(this.error);

//   @override
//   List<Object?> get props => [error];
// }
