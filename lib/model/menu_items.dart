import 'package:aperture/route_manager/app_router.dart';
import 'package:aperture/supabase/auth_services.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You clicked on a menu item!'),
              ),
            );
            Navigator.of(context).pushNamed(AppRouter.profileRoute);
          },
          child: ListTile(
            leading: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            trailing: Icon(
              Icons.person_2_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          leading: Text(
            'Dark Mode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          trailing: Icon(
            Icons.toggle_off_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: Text('Are you sure you want to log out?'),
                children: [
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop()
                        ..pushNamed(AppRouter.loginRoute);
                    },
                  ),
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          child: ListTile(
            leading: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () async {
                final res = await AuthService().signOut();

                if (res == 'success') {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouter.loginRoute);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(res),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
