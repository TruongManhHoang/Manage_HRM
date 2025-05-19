import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:admin_hrm/pages/attendance/bloc/attendance_bloc.dart';
import 'package:admin_hrm/pages/attendance/bloc/attendance_event.dart';
import 'package:admin_hrm/pages/attendance/bloc/attendance_state.dart';
import 'package:admin_hrm/data/model/attendance/attendance_model.dart';

class AttendanceForm extends StatefulWidget {
  final AttendanceModel? attendance;
  const AttendanceForm({super.key, this.attendance});

  @override
  State<AttendanceForm> createState() => _AttendanceFormState();
}

class _AttendanceFormState extends State<AttendanceForm> {
  final _formKey = GlobalKey<FormState>();
  final userIdCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();
  final workLocationCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  DateTime date = DateTime.now();
  DateTime? checkInTime;
  DateTime? checkOutTime;
  bool isLate = false;
  bool isAbsent = false;

  List<Map<String, String>> personnelList = [];
  bool isLoadingPersonnel = true;

  @override
  void initState() {
    super.initState();
    _loadPersonnel();

    if (widget.attendance != null) {
      final a = widget.attendance!;
      userIdCtrl.text = a.userId;
      userNameCtrl.text = a.userName ?? '';
      workLocationCtrl.text = a.workLocation ?? '';
      notesCtrl.text = a.notes ?? '';
      date = a.date;
      checkInTime = a.checkInTime;
      checkOutTime = a.checkOutTime;
      isLate = a.isLate;
      isAbsent = a.isAbsent;
    }
  }

  Future<void> _loadPersonnel() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('personnel').get();

    personnelList = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'code': data['code'] as String,
        'name': data['name'] as String,
      };
    }).toList();

    setState(() {
      isLoadingPersonnel = false;
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => date = picked);
  }

  Future<void> _pickTime({required bool isCheckIn}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );
    if (picked != null) {
      final dt =
          DateTime(date.year, date.month, date.day, picked.hour, picked.minute);
      setState(() {
        if (isCheckIn) {
          checkInTime = dt;
        } else {
          checkOutTime = dt;
        }
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final model = AttendanceModel(
      id: widget.attendance?.id ?? '',
      userId: userIdCtrl.text.trim(),
      userName: userNameCtrl.text.trim(),
      date: date,
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      workLocation: workLocationCtrl.text.trim(),
      notes: notesCtrl.text.trim(),
      isLate: isLate,
      isAbsent: isAbsent,
      createdAt: widget.attendance?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final bloc = context.read<AttendanceBloc>();
    if (widget.attendance != null) {
      bloc.add(UpdateAttendance(model));
    } else {
      bloc.add(AddAttendance(model));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Lưu thành công')));
          context.pop(true);
        } else if (state is AttendanceError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              const Expanded(child: Sidebar()),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const Header(),
                    Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const TBreadcrumsWithHeading(
                              heading: 'Chấm công',
                              breadcrumbItems: [RouterName.addAttendance],
                            ),
                            Container(
                              width: 600,
                              padding:
                                  const EdgeInsets.all(TSizes.defaultSpace),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    isLoadingPersonnel
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : DropdownSearch<String>(
                                            items: personnelList
                                                .map((e) => e['code']!)
                                                .toList(),
                                            selectedItem:
                                                userIdCtrl.text.isNotEmpty
                                                    ? userIdCtrl.text
                                                    : null,
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                labelText: 'Mã nhân viên',
                                              ),
                                            ),
                                            popupProps: const PopupProps.menu(
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Tìm mã nhân viên...',
                                                ),
                                              ),
                                            ),
                                            onChanged: (selectedCode) {
                                              userIdCtrl.text = selectedCode!;
                                              final found =
                                                  personnelList.firstWhere(
                                                (e) =>
                                                    e['code'] == selectedCode,
                                                orElse: () => {},
                                              );
                                              userNameCtrl.text =
                                                  found['name'] ?? '';
                                            },
                                            validator: (value) =>
                                                value == null || value.isEmpty
                                                    ? 'Không để trống'
                                                    : null,
                                          ),
                                    const Gap(8),
                                    TextFormField(
                                      controller: userNameCtrl,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Tên nhân viên (tự động điền)'),
                                    ),
                                    const Gap(8),
                                    ListTile(
                                      title: Text(
                                          'Ngày: ${date.toLocal().toString().split(' ')[0]}'),
                                      trailing:
                                          const Icon(Icons.calendar_today),
                                      onTap: _pickDate,
                                    ),
                                    ListTile(
                                      title: Text(checkInTime != null
                                          ? 'Giờ vào: ${TimeOfDay.fromDateTime(checkInTime!).format(context)}'
                                          : 'Chọn giờ vào'),
                                      trailing: const Icon(Icons.access_time),
                                      onTap: () => _pickTime(isCheckIn: true),
                                    ),
                                    ListTile(
                                      title: Text(checkOutTime != null
                                          ? 'Giờ ra: ${TimeOfDay.fromDateTime(checkOutTime!).format(context)}'
                                          : 'Chọn giờ ra'),
                                      trailing: const Icon(Icons.access_time),
                                      onTap: () => _pickTime(isCheckIn: false),
                                    ),
                                    TextFormField(
                                      controller: workLocationCtrl,
                                      decoration: const InputDecoration(
                                          labelText: 'Địa điểm làm việc'),
                                    ),
                                    const Gap(8),
                                    TextFormField(
                                      controller: notesCtrl,
                                      decoration: const InputDecoration(
                                          labelText: 'Ghi chú'),
                                      maxLines: 2,
                                    ),
                                    const Gap(8),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: isLate,
                                            onChanged: (v) => setState(
                                                () => isLate = v ?? false)),
                                        const Text('Đi trễ'),
                                        const Gap(20),
                                        Checkbox(
                                            value: isAbsent,
                                            onChanged: (v) => setState(
                                                () => isAbsent = v ?? false)),
                                        const Text('Vắng mặt'),
                                      ],
                                    ),
                                    const Gap(16),
                                    ElevatedButton(
                                        onPressed: _submit,
                                        child: widget.attendance != null
                                            ? const Text('Sửa chấm công')
                                            : const Text('Thêm chấm công')),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
