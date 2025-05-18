import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/data/model/kpi/kpi_metric/kpi_metric.dart';
import 'package:admin_hrm/data/model/kpi/kpi_model.dart';
import 'package:admin_hrm/data/model/personnel_management.dart';
import 'package:admin_hrm/pages/kpi/bloc/kpi_bloc.dart';
import 'package:admin_hrm/pages/kpi/bloc/kpi_event.dart';
import 'package:admin_hrm/pages/kpi/bloc/kpi_state.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class KPIFormPage extends StatefulWidget {
  const KPIFormPage({super.key, this.initialKPI});
  final KPIModel? initialKPI;

  @override
  State<KPIFormPage> createState() => _KPIFormPageState();
}

class _KPIFormPageState extends State<KPIFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _departmentIdController = TextEditingController();
  final _periodController = TextEditingController();
  final _evaluatorIdController = TextEditingController();
  final _notesController = TextEditingController();

  List<PersionalManagement> _users = [];
  PersionalManagement? _selectedUser;
  List<KPIMetric> _metrics = [];

  bool _isLoadingUsers = true;

  @override
  void initState() {
    super.initState();
    _loadUsers().then((_) {
      if (widget.initialKPI != null) {
        final initial = widget.initialKPI!;
        _selectedUser = _users.firstWhere((u) => u.id == initial.userId,
            orElse: () => PersionalManagement(
                  id: '',
                  name: '',
                  code: '',
                  departmentId: '',
                  positionId: '',
                  email: '',
                  phone: '',
                  address: '',
                  dateOfBirth: '',
                  gender: '',
                  experience: '',
                  date: '',
                  status: '',
                ));
        _departmentIdController.text = initial.departmentId;
        _periodController.text = initial.period;
        _evaluatorIdController.text = initial.evaluatorId ?? '';
        _notesController.text = initial.notes ?? '';
        _metrics = List<KPIMetric>.from(initial.metrics);
      }
    });
  }

  void _addMetricField() {
    setState(() {
      _metrics.add(KPIMetric(name: '', description: '', weight: 0, score: 0));
    });
  }

  void _removeMetricField(int index) {
    setState(() {
      _metrics.removeAt(index);
    });
  }

  Future<void> _loadUsers() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('personnel').get();
    setState(() {
      _users = snapshot.docs
          .map((doc) => PersionalManagement.fromJson(doc.data()))
          .toList();
      _isLoadingUsers = false;
    });
  }

  double _calculateTotalScore() {
    return _metrics.fold(0.0, (sum, m) => sum + m.score * m.weight);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedUser != null) {
      final now = DateTime.now();
      final newKPI = KPIModel(
        id: widget.initialKPI?.id ?? '',
        userId: _selectedUser!.code!,
        departmentId: _selectedUser!.departmentId,
        period: _periodController.text,
        metrics: _metrics,
        totalScore: _calculateTotalScore(),
        evaluatorId: _evaluatorIdController.text.isNotEmpty
            ? _evaluatorIdController.text
            : null,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        createdAt: widget.initialKPI?.createdAt ?? now,
        updatedAt: now,
      );
      if (widget.initialKPI != null) {
        BlocProvider.of<KPIBloc>(context).add(UpdateKPI(newKPI));
      } else {
        BlocProvider.of<KPIBloc>(context).add(AddKPI(newKPI));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KPIBloc, KPIState>(
      listener: (context, state) {
        if (state is KPISuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Lưu thành công')));
          context.pop(true);
        } else if (state is KPIError) {
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
                    const TBreadcrumsWithHeading(
                      heading: 'KPI',
                      breadcrumbItems: [RouterName.addKpi],
                    ),
                    Container(
                      width: 600,
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _isLoadingUsers
                                ? const CircularProgressIndicator()
                                : DropdownButtonFormField<PersionalManagement>(
                                    value: _selectedUser,
                                    decoration: const InputDecoration(
                                        labelText: 'Chọn nhân sự'),
                                    items: _users.map((user) {
                                      return DropdownMenuItem(
                                        value: user,
                                        child:
                                            Text('${user.name} (${user.id})'),
                                      );
                                    }).toList(),
                                    onChanged: (user) {
                                      setState(() {
                                        _selectedUser = user!;
                                        _departmentIdController.text =
                                            user.departmentId;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Vui lòng chọn nhân sự'
                                        : null,
                                  ),
                            const Gap(8),
                            TextFormField(
                              controller: _departmentIdController,
                              decoration:
                                  const InputDecoration(labelText: 'Phòng ban'),
                              enabled: false, // Không cho nhập
                            ),
                            const Gap(8),
                            TextFormField(
                              controller: _periodController,
                              decoration: const InputDecoration(
                                  labelText: 'Thời gian (VD: 05/2024)'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Bắt buộc' : null,
                            ),
                            const Gap(8),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Chỉ số KPI',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextButton.icon(
                                  onPressed: _addMetricField,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Thêm chỉ số'),
                                )
                              ],
                            ),
                            ..._metrics.asMap().entries.map((entry) {
                              final index = entry.key;
                              final metric = entry.value;
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: metric.name,
                                        decoration: const InputDecoration(
                                            labelText: 'Tên chỉ số'),
                                        onChanged: (val) => _metrics[index] =
                                            _metrics[index].copyWith(name: val),
                                        validator: (value) =>
                                            value!.isEmpty ? 'Bắt buộc' : null,
                                      ),
                                      const Gap(8),
                                      TextFormField(
                                        initialValue: metric.description,
                                        decoration: const InputDecoration(
                                            labelText: 'Mô tả'),
                                        onChanged: (val) => _metrics[index] =
                                            _metrics[index]
                                                .copyWith(description: val),
                                      ),
                                      const Gap(8),
                                      TextFormField(
                                        initialValue: metric.weight.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'Trọng số'),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) => _metrics[index] =
                                            _metrics[index].copyWith(
                                                weight:
                                                    double.tryParse(val) ?? 0),
                                        validator: (value) =>
                                            value!.isEmpty ? 'Bắt buộc' : null,
                                      ),
                                      const Gap(8),
                                      TextFormField(
                                        initialValue: metric.score.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'Điểm số'),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) => _metrics[index] =
                                            _metrics[index].copyWith(
                                                score:
                                                    double.tryParse(val) ?? 0),
                                        validator: (value) =>
                                            value!.isEmpty ? 'Bắt buộc' : null,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(Icons.delete_forever,
                                              color: Colors.red),
                                          onPressed: () =>
                                              _removeMetricField(index),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            const Gap(16),
                            TextFormField(
                              controller: _evaluatorIdController,
                              decoration: const InputDecoration(
                                  labelText: 'Người đánh giá'),
                            ),
                            const Gap(8),
                            TextFormField(
                              controller: _notesController,
                              decoration:
                                  const InputDecoration(labelText: 'Ghi chú'),
                              maxLines: 3,
                            ),
                            const Gap(8),
                            ElevatedButton(
                                onPressed: _submitForm,
                                child: widget.initialKPI != null
                                    ? const Text('Sửa KPI')
                                    : const Text('Thêm KPI')),
                          ],
                        ),
                      ),
                    )
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
