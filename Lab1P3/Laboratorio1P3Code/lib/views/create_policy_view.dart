import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'policy_form.dart';
import 'search_view.dart';
import 'user_view.dart';

class CreatePolicyView extends ConsumerStatefulWidget {
  const CreatePolicyView({super.key});

  @override
  ConsumerState<CreatePolicyView> createState() => _CreatePolicyViewState();
}

class _CreatePolicyViewState extends ConsumerState<CreatePolicyView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const PolicyForm(),
    const SearchView(),
    const UserView(),
  ];

  static final List<String> _titles = [
    'Crear Póliza',
    'Buscar Pólizas',
    'Usuarios',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuarios'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
