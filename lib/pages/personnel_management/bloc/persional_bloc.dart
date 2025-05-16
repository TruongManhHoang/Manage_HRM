// add_employee_cubit.dart

import 'dart:io';

import 'package:admin_hrm/data/repository/persional_repository.dart';
import 'package:admin_hrm/local/hive_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/personnel_management.dart';

part 'persional_event.dart';
part 'persional_state.dart';

class PersionalBloc extends Bloc<PersionalEvent, PersionalState> {
  final PersionalRepository personnelRepository;
  final GlobalStorage globalStorage;
  PersionalBloc(
      {required this.personnelRepository, required this.globalStorage})
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

      globalStorage.fetchAllPersonalManagers(personnel);
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

  Future<String?> uploadImageToFirebase(XFile file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final avatarRef = storageRef.child(
          'avatars/${DateTime.now().millisecondsSinceEpoch}_${file.name}');
      final uploadTask = await avatarRef.putFile(File(file.path));
      final downloadUrl = await avatarRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
