// add_employee_cubit.dart

import 'package:admin_hrm/data/repository/persional_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/personnel_management.dart';

part 'persional_event.dart';
part 'persional_state.dart';

class PersionalBloc extends Bloc<PersionalEvent, PersionalState> {
  final PersionalRepository personnelRepository;
  PersionalBloc({required this.personnelRepository})
      : super(const PersionalState()) {
    on<PersionalCreateEvent>(_onCreateEvent);
    on<PersionalLoadEvent>(_onLoadEvent);
    on<PersionalUpdateEvent>(_onUpdateEvent);
    on<PersionalDeleteEvent>(_onDeleteEvent);
  }

  void _onCreateEvent(
      PersionalCreateEvent event, Emitter<PersionalState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      await personnelRepository.createPersonnel(event.personnelManagement);
      add(const PersionalLoadEvent());
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, errorMessage: e.toString()));
    }
  }

  void _onLoadEvent(
      PersionalLoadEvent event, Emitter<PersionalState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      final personnel = await personnelRepository.getAllPersonnel();
      emit(state.copyWith(
          isLoading: false, personnel: personnel, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, errorMessage: e.toString()));
    }
  }

  void _onUpdateEvent(
      PersionalUpdateEvent event, Emitter<PersionalState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      await personnelRepository.updatePersional(event.personnelManagement);
      add(const PersionalLoadEvent());
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, errorMessage: e.toString()));
    }
  }

  void _onDeleteEvent(
      PersionalDeleteEvent event, Emitter<PersionalState> emit) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      await personnelRepository.deletePersonnel(event.id);
      add(const PersionalLoadEvent());
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, errorMessage: e.toString()));
    }
  }
}
