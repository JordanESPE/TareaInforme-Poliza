import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/user_controller.dart';

class UserView extends ConsumerStatefulWidget {
  const UserView({super.key});

  @override
  ConsumerState<UserView> createState() => _UserViewState();
}

class _UserViewState extends ConsumerState<UserView> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userControllerProvider.notifier).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Perfil de Usuario',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            if (userState.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (userState.errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userState.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(userControllerProvider.notifier)
                              .fetchUsers();
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              )
            else if (userState.users.isEmpty)
              const Expanded(
                child: Center(child: Text('No hay usuarios registrados')),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(userControllerProvider.notifier)
                        .fetchUsers();
                  },
                  child: ListView.builder(
                    itemCount: userState.users.length,
                    itemBuilder: (context, index) {
                      final user = userState.users[index];
                      // Safe extraction of fields
                      final nombre = user['nombre'] ?? 'Sin Nombre';
                      final apellido = user['apellido'] ?? '';
                      final edad = user['edad'] ?? 0;
                      final autos =
                          user['automovilIds'] as List<dynamic>? ?? [];
                      final modelos = user['modelos'] as List<dynamic>?;

                      String detallesAutos;
                      if (modelos != null && modelos.isNotEmpty) {
                        detallesAutos = modelos.join(', ');
                      } else {
                        detallesAutos = 'Autos registrados: ${autos.length}';
                      }

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple.shade100,
                            child: Text(
                              nombre.isNotEmpty ? nombre[0].toUpperCase() : '?',
                              style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            '$nombre $apellido',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Edad: $edad años'),
                              Text(
                                detallesAutos,
                                style: TextStyle(
                                  color:
                                      (modelos != null && modelos.isNotEmpty) ||
                                          autos.isNotEmpty
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
