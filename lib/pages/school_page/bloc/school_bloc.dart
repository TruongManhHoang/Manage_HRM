
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enum.dart';

part 'school_state.dart';
part 'school_event.dart';


class SchoolBloc extends Bloc<SchoolEvent,SchoolState>{
   SchoolBloc() : super(const SchoolState());
}