import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/settings/components/profile_card.dart';
import 'package:proyecto_programovil_g3/pages/settings/settings_view_model.dart';

class SettingsTab extends StatelessWidget {
  final Function onToggleTheme;

  SettingsTab({required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          body: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ProfileCard(
                name: viewModel.userName,
                email: viewModel.userEmail,
                imageUrl: viewModel.userImageUrl,
                isEditable: true,
                isFavorite: false,
                onEdit: () {},
                onShare: () {},
                onManage: () {},
              ),
              _buildSwitchListTile(
                context: context,
                icon: CupertinoIcons.bell,
                title: 'Notificaciones',
                value: viewModel.notificationsEnabled,
                onChanged: viewModel.toggleNotifications,
              ),
              _buildSwitchListTile(
                context: context,
                icon: CupertinoIcons.moon,
                title: 'Modo oscuro',
                value: viewModel.darkModeEnabled,
                onChanged: (value) {
                  viewModel.toggleDarkMode(value);
                  onToggleTheme();
                },
              ),
              _buildListTile(
                context: context,
                icon: CupertinoIcons.lock,
                title: 'Privacidad y seguridad',
                onTap: () {},
              ),
              _buildListTile(
                context: context,
                icon: CupertinoIcons.question_circle,
                title: 'Soporte',
                onTap: () {},
              ),
              _buildListTile(
                context: context,
                icon: CupertinoIcons.info,
                title: 'Acerca de',
                onTap: () {},
              ),
              _buildListTile(
                context: context,
                icon: CupertinoIcons.power,
                title: 'Cerrar sesión',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.getTextColor(context)),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildSwitchListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: AppColors.getTextColor(context)),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: isDarkMode
            ? Theme.of(context).primaryColor
            : const Color.fromARGB(221, 37, 47, 98),
      ),
    );
  }
}
