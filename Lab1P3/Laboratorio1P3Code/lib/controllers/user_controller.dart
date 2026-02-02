import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

class UserState {
  final List<dynamic> users;
  final bool isLoading;
  final String? errorMessage;

  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  UserState copyWith({
    List<dynamic>? users,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class UserController extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final users = await ApiService.getPropietarios();
      state = state.copyWith(isLoading: false, users: users);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cargar usuarios: $e',
      );
    }
  }
}

final userControllerProvider = NotifierProvider<UserController, UserState>(() {
  return UserController();
});
