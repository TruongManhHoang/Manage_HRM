
part of 'school_bloc.dart';

class SchoolState extends Equatable {
  final List<double> weeklySales;
  final Map<OrderStatus, int> orderStatusData;
  final Map<OrderStatus,double> totalAmountData;



  const SchoolState({
    this.weeklySales = const [],
    this.orderStatusData = const {},
    this.totalAmountData = const {},
  });

  @override
  List<Object?> get props => [];


}