import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.person, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text('Perfil de Usuario', style: TextStyle(fontSize: 24)),
          Text('pendiente'),
        ],
      ),
    );
  }
}
