part of 'contact_list_bloc.dart';

@freezed
class ContactListEvent with _$ContactListEvent {
  factory ContactListEvent.findAll() = _ContactListEventFindAll;
  factory ContactListEvent.delete({required ContactModel contact}) =
      _ContactListEventDelete;
}
