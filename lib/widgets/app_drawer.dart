import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final Function(ThemeMode) changeTheme;

  const AppDrawer({super.key, required this.changeTheme});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 350;

    return Drawer(
      width: size.width * 0.8,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'AbdulSaboor Sabzevari',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: isSmallScreen
                    ? theme.textTheme.titleSmall?.fontSize
                    : theme.textTheme.titleMedium?.fontSize,
              ),
            ),
            accountEmail: Text(
              'sabzevari456@gmail.com',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: isSmallScreen
                    ? theme.textTheme.bodySmall?.fontSize
                    : theme.textTheme.bodyMedium?.fontSize,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: isSmallScreen ? 36 : 48,
              ),
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () => Navigator.pop(context),
                  isSmallScreen: isSmallScreen,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {},
                  isSmallScreen: isSmallScreen,
                ),
                SwitchListTile(
                  title: Text(
                    'Dark Mode',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: isSmallScreen
                          ? theme.textTheme.bodyMedium?.fontSize
                          : theme.textTheme.bodyLarge?.fontSize,
                    ),
                  ),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() => _darkMode = value);
                    widget.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                  secondary: Icon(
                    _darkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    size: isSmallScreen ? 20 : 24,
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.share_outlined,
                  title: 'Share App',
                  onTap: () {},
                  isSmallScreen: isSmallScreen,
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () {},
                  isSmallScreen: isSmallScreen,
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.exit_to_app_outlined,
                  title: 'Logout',
                  onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        required bool isSmallScreen,
      }) {
    return ListTile(
      leading: Icon(
        icon,
        size: isSmallScreen ? 20 : 24,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: isSmallScreen
              ? Theme.of(context).textTheme.bodyMedium?.fontSize
              : Theme.of(context).textTheme.bodyLarge?.fontSize,
        ),
      ),
      onTap: onTap,
    );
  }
}