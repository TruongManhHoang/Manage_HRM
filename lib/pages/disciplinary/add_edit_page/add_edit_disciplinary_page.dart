import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/common/widgets/text_form/text_form_field.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/data/model/disciplinary/disciplinary_model.dart';
import 'package:admin_hrm/pages/disciplinary/bloc/disciplinary_bloc.dart';
import 'package:admin_hrm/pages/disciplinary/bloc/disciplinary_event.dart';
import 'package:admin_hrm/pages/disciplinary/bloc/disciplinary_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddAndEditDisciplinaryPage extends StatefulWidget {
  final DisciplinaryModel? disciplinary;
  const AddAndEditDisciplinaryPage({super.key, this.disciplinary});

  @override
  State<AddAndEditDisciplinaryPage> createState() =>
      _AddAndEditDisciplinaryPageState();
}

class _AddAndEditDisciplinaryPageState
    extends State<AddAndEditDisciplinaryPage> {
  final _formKey = GlobalKey<FormState>();
  final employeeIdCtrl = TextEditingController();
  final employeeNameCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();
  final severityCtrl = TextEditingController();
  final approvedByCtrl = TextEditingController();
  final documentCtrl = TextEditingController();

  String disType = 'Tiền mặt';
  Timestamp disciplinaryDate = Timestamp.now();
  String status = 'Chờ duyệt';

  final disciplinaryTypes = ['Tiền mặt', 'Trừ KPI', 'Khác'];
  final statusOptions = ['Chờ duyệt', 'Đã duyệt', 'Từ chối'];

  @override
  void initState() {
    super.initState();
    if (widget.disciplinary != null) {
      final r = widget.disciplinary!;
      employeeIdCtrl.text = r.employeeId;
      employeeNameCtrl.text = r.employeeName;
      reasonCtrl.text = r.reason;
      severityCtrl.text = r.severity;
      approvedByCtrl.text = r.approvedBy;
      documentCtrl.text = r.document ?? '';
      disType = r.disciplinaryType;
      disciplinaryDate = r.disciplinaryDate;
      status = r.status;
    }
  }

  @override
  void dispose() {
    employeeIdCtrl.dispose();
    employeeNameCtrl.dispose();
    reasonCtrl.dispose();
    severityCtrl.dispose();
    approvedByCtrl.dispose();
    documentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickRewardDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: disciplinaryDate.toDate(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        disciplinaryDate = Timestamp.fromDate(date);
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final disciplinary = DisciplinaryModel(
      id: widget.disciplinary?.id ?? '',
      employeeId: employeeIdCtrl.text,
      employeeName: employeeNameCtrl.text,
      disciplinaryType: disType,
      disciplinaryDate: disciplinaryDate,
      reason: reasonCtrl.text,
      severity: severityCtrl.text,
      approvedBy: approvedByCtrl.text,
      status: status,
      document: documentCtrl.text.isEmpty ? null : documentCtrl.text,
    );

    if (widget.disciplinary != null) {
      context.read<DisciplinaryBloc>().add(UpdateDisciplinary(disciplinary));
    } else {
      context.read<DisciplinaryBloc>().add(AddDisciplinary(disciplinary));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DisciplinaryBloc, DisciplinaryState>(
      listener: (context, state) {
        if (state is DisciplinarySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.disciplinary != null
                  ? 'Cập nhật kỷ luật thành công'
                  : 'Thêm kỷ luật thành công'),
            ),
          );
          context.pop(true);
        } else if (state is DisciplinaryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${state.message}')),
          );
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
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TBreadcrumsWithHeading(
                                heading: widget.disciplinary != null
                                    ? 'Cập nhật kỷ luật'
                                    : 'Thêm kỷ luật',
                                breadcrumbItems: ['Kỷ luật'],
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
                                      TTextFormField(
                                        controller: employeeIdCtrl,
                                        textAlign: true,
                                        text: 'Mã nhân viên',
                                        hint: 'Nhập mã nhân viên',
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'Không được để trống'
                                                : null,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: employeeNameCtrl,
                                        textAlign: true,
                                        text: 'Tên nhân viên',
                                        hint: 'Nhập tên nhân viên',
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'Không được để trống'
                                                : null,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      Row(
                                        children: [
                                          const Text('Loại khen thưởng'),
                                          const Spacer(),
                                          DropdownButton(
                                            value: disType,
                                            items: disciplinaryTypes.map((s) {
                                              return DropdownMenuItem(
                                                value: s,
                                                child: Text(s),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  disType = value;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      ListTile(
                                        title: Text(
                                            'Ngày kỷ luật: ${disciplinaryDate.toDate().toLocal().toString().split(' ')[0]}'),
                                        trailing:
                                            const Icon(Icons.calendar_today),
                                        onTap: _pickRewardDate,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      DropdownButtonFormField(
                                        value: status,
                                        items: statusOptions.map((s) {
                                          return DropdownMenuItem(
                                            value: s,
                                            child: Text(s),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              status = value;
                                            });
                                          }
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Trạng thái'),
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: reasonCtrl,
                                        textAlign: true,
                                        text: 'Lý do',
                                        hint: 'Nhập lý do',
                                        maxLines: 2,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: severityCtrl,
                                        textAlign: true,
                                        text: 'Mức độ kỷ luật',
                                        hint: 'Nhập mức độ kỷ luật',
                                        validator: (val) => val == null
                                            ? 'Không được để trống'
                                            : null,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: approvedByCtrl,
                                        textAlign: true,
                                        text: 'Người phê duyệt',
                                        hint: 'Nhập người phê duyệt',
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: documentCtrl,
                                        textAlign: true,
                                        text: 'Tài liệu đính kèm',
                                        hint: 'Link hoặc ghi chú',
                                      ),
                                      const Gap(TSizes.spaceBtwSections),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: TSizes.defaultSpace * 2,
                                            vertical: 16,
                                          ),
                                        ),
                                        onPressed: _submitForm,
                                        child: Text(
                                          widget.disciplinary != null
                                              ? 'Cập nhật kỷ luật'
                                              : 'Thêm kỷ luật',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
