import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:admin_hrm/data/model/position/position_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GlobalStorageKey {
  const GlobalStorageKey._();

  static const globalStorage = 'globalStorage';
  static const userId = 'user_id';
  static const displayName = 'display_name';
  static const accessToken = 'access_token';
  static const isLoggedIn = 'is_logged_in';
  static const isDarkMode = 'isDarkMode';
  static const languageCode = 'languageCode';
  static const role = 'role';
  static const userData = 'userData';
  static const positions = "positions";
  static const departments = "departments";
}

abstract class GlobalStorage {
  Future<void> init();
  List<PositionModel>? get positions;
  Future<void> addToPosition(PositionModel position);
  Future<void> removeFromPositionById(String id);
  Future<void> removeAllPosition();

  List<DepartmentModel>? get departments;
  Future<void> addToDepartment(DepartmentModel department);
  Future<void> removeFromDepartmentById(String id);
  Future<void> removeAllDepartment();

  // New authentication methods
  String? get accessToken;

  String? get userId;

  String? get displayName;

  String? get role;

  bool get isLoggedIn;

  Locale get languageCode;

  set languageCode(Locale languageCode);

  bool get darkMode;

  set darkMode(bool isDarkMode);

  Future<void> updateAuthenticationState({
    required String? displayName,
    // required String? userId,
    required String? role,
  });

  Future<void> clearAuthenticationState();

  Map<String, dynamic> get userData;

  set userData(dynamic data);
}

class GlobalStorageImpl implements GlobalStorage {
  late Box _box;

  @override
  Locale get languageCode {
    String lang = _box.get(GlobalStorageKey.languageCode, defaultValue: 'en');
    return Locale(lang);
  }

  @override
  set languageCode(Locale languageCode) {
    _box.put(GlobalStorageKey.languageCode, languageCode.languageCode);
  }

  @override
  Future<void> init() async {
    _box = await Hive.openBox('globalStorage');
  }

  @override
  String? get accessToken {
    return _box.get(GlobalStorageKey.accessToken);
  }

  @override
  String? get role {
    return _box.get(GlobalStorageKey.role);
  }

  @override
  String? get userId {
    return _box.get(GlobalStorageKey.userId);
  }

  @override
  bool get isLoggedIn {
    return _box.get(GlobalStorageKey.isLoggedIn, defaultValue: false);
  }

  @override
  bool get darkMode {
    return _box.get(GlobalStorageKey.isDarkMode, defaultValue: false);
  }

  @override
  set darkMode(bool isDarkMode) {
    _box.put(GlobalStorageKey.isDarkMode, isDarkMode);
  }

  @override
  Future<void> updateAuthenticationState({
    required String? displayName,
    // required String? userId,
    required String? role,
  }) async {
    if (displayName == null) {
      await clearAuthenticationState();
      return;
    }
    await Future.wait([
      // _box.put(GlobalStorageKey.accessToken, token),
      _box.put(GlobalStorageKey.displayName, displayName),
      // _box.put(GlobalStorageKey.isLoggedIn, true),
      _box.put(GlobalStorageKey.role, role),
    ]);
    debugPrint(
        "UpdateAuthentication: ${_box.get(GlobalStorageKey.displayName)} ${_box.get(GlobalStorageKey.role)}");
  }

  @override
  Future<void> clearAuthenticationState() async {
    await Future.wait([
      // _box.delete(GlobalStorageKey.accessToken),
      // _box.delete(GlobalStorageKey.userId),
      // _box.delete(GlobalStorageKey.isLoggedIn),
      _box.delete(GlobalStorageKey.role),
      _box.delete(GlobalStorageKey.displayName)
      // _box.delete(GlobalStorageKey.userData),
    ]);

    debugPrint(
        "Cleared authentication state: ${_box.get(GlobalStorageKey.displayName)} ${_box.get(GlobalStorageKey.role)}");
  }

  @override
  Map<String, dynamic> get userData {
    return _box.get(GlobalStorageKey.userData) ??
        {
          'accessToken': '',
          'refreshToken': '',
          'user': null,
        };
  }

  @override
  set userData(dynamic data) {
    _box.put(GlobalStorageKey.userData, data);
  }

  @override
  // TODO: implement departments
  List<DepartmentModel>? get departments {
    final jsonList = _box.get(GlobalStorageKey.departments, defaultValue: []);
    if (jsonList is List) {
      return jsonList
          .map((e) => DepartmentModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }
  }

  @override
  Future<void> addToDepartment(DepartmentModel department) async {
    List<DepartmentModel> departmentList = departments!;
    departmentList.add(department);
    await _box.put(
        GlobalStorageKey.departments, departmentList.map((e) => e.toMap()));
  }

  @override
  Future<void> addToPosition(PositionModel position) async {
    List<PositionModel> positionList = positions!;
    positionList.add(position);
    await _box.put(
        GlobalStorageKey.positions, positionList.map((e) => e.toMap()));
  }

  @override
  List<PositionModel>? get positions {
    final jsonList = _box.get(GlobalStorageKey.positions, defaultValue: []);
    if (jsonList is List) {
      return jsonList
          .map((e) => PositionModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }
  }

  @override
  Future<void> removeAllDepartment() {
    return _box.put(GlobalStorageKey.departments, []);
  }

  @override
  Future<void> removeAllPosition() {
    return _box.put(GlobalStorageKey.positions, []);
  }

  @override
  Future<void> removeFromDepartmentById(String id) async {
    List<DepartmentModel> departmentList = departments!;
    departmentList.removeWhere((department) => department.id == id);
    await _box.put(
        GlobalStorageKey.departments, departmentList.map((e) => e.toMap()));
  }

  @override
  Future<void> removeFromPositionById(String id) async {
    List<PositionModel> positionList = positions!;
    positionList.removeWhere((position) => position.id == id);
    await _box.put(
        GlobalStorageKey.positions, positionList.map((e) => e.toMap()));
  }

  @override
  // TODO: implement displayName
  String? get displayName => _box.get(GlobalStorageKey.displayName);
}
