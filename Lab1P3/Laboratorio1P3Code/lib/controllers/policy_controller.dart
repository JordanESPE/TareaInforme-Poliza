import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_state.dart';
import '../services/api_service.dart';

class PolicyController extends Notifier<PolicyState> {
  @override
  PolicyState build() {
    return const PolicyState();
  }

  void setOwnerName(String name) {
    state = state.copyWith(ownerName: name);
  }

  void setInsuranceValue(String value) {
    final double? parsedValue = double.tryParse(value);
    if (parsedValue != null) {
      state = state.copyWith(insuranceValue: parsedValue);
    }
  }

  void setSelectedModel(String model) {
    state = state.copyWith(selectedModel: model);
  }

  void setAgeRange(String range) {
    state = state.copyWith(ageRange: range);
  }

  void toggleAccidents(bool? value) {
    state = state.copyWith(hasAccidents: value ?? false);
  }

  /// Create a new policy by calling the backend API
  Future<void> createPolicy() async {
    // Validation
    if (state.ownerName.trim().isEmpty) {
      state = state.copyWith(
        errorMessage: 'Por favor ingrese el nombre del propietario',
      );
      return;
    }

    if (state.insuranceValue <= 0) {
      state = state.copyWith(
        errorMessage: 'Por favor ingrese un valor de seguro válido',
      );
      return;
    }

    // Convert age range to a numeric value for the backend
    int edadPropietario;
    switch (state.ageRange) {
      case '18-23':
        edadPropietario = 20; // Representative age
        break;
      case '23-55':
        edadPropietario = 35; // Representative age
        break;
      case '>55':
        edadPropietario = 60; // Representative age
        break;
      default:
        edadPropietario = 20;
    }

    // Set loading state
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final response = await ApiService.createPolicy(
        propietario: state.ownerName,
        edadPropietario: edadPropietario,
        modeloAuto: state.selectedModel,
        valorSeguroAuto: state.insuranceValue,
        accidentes: state.hasAccidents,
      );

      // Extract cost from response
      final costoTotal = response['costoTotal'] as double? ?? 0.0;

      state = state.copyWith(
        isLoading: false,
        calculatedCost: costoTotal,
        successMessage:
            '✅ Póliza creada exitosamente! Costo: \$${costoTotal.toStringAsFixed(2)}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '❌ Error: ${e.toString()}',
      );
    }
  }

  /// Search for a policy by owner name
  Future<void> searchPolicy(String nombre) async {
    if (nombre.trim().isEmpty) {
      state = state.copyWith(
        errorMessage: 'Por favor ingrese un nombre para buscar',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
      searchResult: null,
    );

    try {
      final response = await ApiService.searchPolicyByOwnerName(nombre);

      state = state.copyWith(
        isLoading: false,
        searchResult: response,
        successMessage: '✅ Póliza encontrada',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '❌ ${e.toString()}',
      );
    }
  }

  void clearMessages() {
    state = state.clearMessages();
  }
}

final policyControllerProvider =
    NotifierProvider<PolicyController, PolicyState>(() {
      return PolicyController();
    });
