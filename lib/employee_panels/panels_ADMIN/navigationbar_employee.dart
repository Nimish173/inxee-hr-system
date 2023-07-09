import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inxee_hr_application/employee_panels/panels_ADMIN/employee_leave_page.dart';
import 'package:inxee_hr_application/employee_panels/panels_ADMIN/employee_panel.dart';
import 'package:inxee_hr_application/employee_panels/panels_ADMIN/employee_report_panel.dart';
import 'package:inxee_hr_application/employee_panels/panels_ADMIN/employee_salary_page.dart';
import 'package:inxee_hr_application/Common_panels/profile_page.dart';

class NavigationDrawerEmployee extends StatelessWidget {
  NavigationDrawerEmployee({super.key});
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    void navigateToAdminProfilePage() {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }

    return Drawer(
      width: 275,
      child: Material(
        color: Colors.grey[300],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: navigateToAdminProfilePage,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text('inxee'),
                accountEmail: Text('inxee@inxee.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1517423738875-5ce310acd3da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1970&q=80',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Home',
                icon: Icons.home,
                onClicked: () => selectedItem(context, 0),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Salary Details',
                icon: Icons.attach_money_outlined,
                onClicked: () => selectedItem(context, 1),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Leave Requests',
                icon: Icons.leave_bags_at_home_outlined,
                onClicked: () => selectedItem(context, 2),
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(color: Colors.black),
            ),
            SizedBox(height: 24),
            Padding(
              padding: padding,
              child: buildMenuIteam(
                text: 'Report',
                icon: Icons.report_gmailerrorred_outlined,
                onClicked: () => selectedItem(context, 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuIteam({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 25,
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(color: color, fontSize: 17),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeePanelHomeScreen(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeeSalaryPanel(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeeLeavePanel(),
          ),
        );
        break;

      case 5:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmployeeReportPanel(),
          ),
        );
        break;
      default:
    }
  }
}
