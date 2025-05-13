class RouterName {
  static const schoolPage = '/school-page';
  static const dashboard = '/dashboard-page';
  static const commentManager = '/comment-manager-page';
  static const login = '/login';
  static const departmentPage = '/departmentPage';
  static const customSidebar = '/customSidebar';
  static const employeePage = '/employee-page';
  static const addEmployee = '/add-employee';
  static const addDepartment = '/add-department';
  static const contractPage = '/contract-page';
  static const addContract = '/add-contract';

  static const sidebarMenuItem = [
    dashboard,
    departmentPage,
    employeePage,
    contractPage
  ];
  static const sidebarMenuItemsShort = [
    dashboard,
    departmentPage,
    employeePage
  ];
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const logout = '/logout';

  static const sidebarMenuItemsFull = [
    schoolPage,
    dashboard,
    commentManager,
    departmentPage,
    logout,
  ];
}
