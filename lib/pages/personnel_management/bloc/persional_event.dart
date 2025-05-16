part of 'persional_bloc.dart';

class PersionalEvent extends Equatable {
  const PersionalEvent();

  @override
  List<Object?> get props => [];
}

class PersionalLoadEvent extends PersionalEvent {
  const PersionalLoadEvent();
  @override
  List<Object?> get props => [];
}

class PersionalCreateEvent extends PersionalEvent {
  final PersionalManagement personnelManagement;
  // final XFile? image;

  const PersionalCreateEvent(
    this.personnelManagement,
  );

  @override
  List<Object?> get props => [personnelManagement];
}

class PersionalUpdateEvent extends PersionalEvent {
  final PersionalManagement personnelManagement;
  // final XFile? image;

  const PersionalUpdateEvent(
    this.personnelManagement,
  );
  @override
  List<Object?> get props => [personnelManagement];
}

class PersionalDeleteEvent extends PersionalEvent {
  final String id;

  const PersionalDeleteEvent(this.id);
  @override
  List<Object?> get props => [id];
}
