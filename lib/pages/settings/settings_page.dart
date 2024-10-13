import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/settings/components/profile_card.dart';

class SettingsTab extends StatefulWidget {
  final Function onToggleTheme;

  SettingsTab({required this.onToggleTheme});

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  final String userName = "Nombre del Usuario";
  final String userEmail = "usuario@example.com";
  final String userImageUrl = "assets/img/E1.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ProfileCard(
            name: userName,
            email: userEmail,
            imageUrl: userImageUrl,
            isEditable: true,
            isFavorite: false,
            onEdit: () {},
            onShare: () {},
            onManage: () {},
          ),
          _buildSwitchListTile(
            icon: CupertinoIcons.bell,
            title: 'Notificaciones',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          _buildSwitchListTile(
            icon: CupertinoIcons.moon,
            title: 'Modo oscuro',
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
                widget.onToggleTheme();
              });
            },
          ),
          _buildListTile(
            icon: CupertinoIcons.lock,
            title: 'Privacidad y seguridad',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.question_circle,
            title: 'Soporte',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.info,
            title: 'Acerca de',
            onTap: () {},
          ),
          _buildListTile(
            icon: CupertinoIcons.power,
            title: 'Cerrar sesión',
            onTap: () {
              // Navegar a la pantalla de "Iniciar sesión"
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(), // Reemplaza LoginPage con tu página de inicio de sesión
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
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
