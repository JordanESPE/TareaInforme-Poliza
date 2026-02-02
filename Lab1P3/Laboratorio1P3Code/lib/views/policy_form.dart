import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/policy_controller.dart';

class PolicyForm extends ConsumerWidget {
  const PolicyForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyState = ref.watch(policyControllerProvider);
    final policyController = ref.read(policyControllerProvider.notifier);

    // Show error message if exists
    if (policyState.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(policyState.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        policyController.clearMessages();
      });
    }

    // Show success message if exists
    if (policyState.successMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(policyState.successMessage!),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
        policyController.clearMessages();
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ImageView
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/55/55283.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Inputs
          TextField(
            decoration: const InputDecoration(
              labelText: 'Propietario',
              border: OutlineInputBorder(),
              filled: true,
            ),
            enabled: !policyState.isLoading,
            onChanged: policyController.setOwnerName,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Apellido Propietario',
              border: OutlineInputBorder(),
              filled: true,
            ),
            enabled: !policyState.isLoading,
            onChanged: policyController.setOwnerLastName,
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Valor del seguro',
              border: OutlineInputBorder(),
              filled: true,
            ),
            enabled: !policyState.isLoading,
            onChanged: policyController.setInsuranceValue,
          ),
          const SizedBox(height: 20),

          // RadioButtons
          const Text(
            'Modelo de auto:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Modelo A'),
            value: 'Modelo A',
            groupValue: policyState.selectedModel,
            onChanged: policyState.isLoading
                ? null
                : (val) => policyController.setSelectedModel(val!),
          ),
          RadioListTile<String>(
            title: const Text('Modelo B'),
            value: 'Modelo B',
            groupValue: policyState.selectedModel,
            onChanged: policyState.isLoading
                ? null
                : (val) => policyController.setSelectedModel(val!),
          ),
          RadioListTile<String>(
            title: const Text('Modelo C'),
            value: 'Modelo C',
            groupValue: policyState.selectedModel,
            onChanged: policyState.isLoading
                ? null
                : (val) => policyController.setSelectedModel(val!),
          ),

          const SizedBox(height: 10),

          // RadioGroup: Edad
          const Text(
            'Edad propietario:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Mayor igual a 18 y menor a 23'),
            value: '18-23',
            groupValue: policyState.ageRange,
            onChanged: policyState.isLoading
                ? null
                : (value) => policyController.setAgeRange(value!),
          ),
          RadioListTile<String>(
            title: const Text('Mayor igual a 23 y menor a 55'),
            value: '23-55',
            groupValue: policyState.ageRange,
            onChanged: policyState.isLoading
                ? null
                : (value) => policyController.setAgeRange(value!),
          ),
          RadioListTile<String>(
            title: const Text('Mayor igual 55'),
            value: '>55',
            groupValue: policyState.ageRange,
            onChanged: policyState.isLoading
                ? null
                : (value) => policyController.setAgeRange(value!),
          ),

          const SizedBox(height: 10),
          // Accidents Input (Changed from Switch to TextField)
          TextField(
            decoration: const InputDecoration(
              labelText: 'Número de Accidentes',
              hintText: 'Ingrese el número de accidentes',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.warning),
            ),
            keyboardType: TextInputType.number,
            enabled: !policyState.isLoading,
            // Initial value could be handled if necessary, but controller manages state
            // controller: TextEditingController(text: policyState.accidents.toString()),
            // Using onChanged to update state directly
            onChanged: (value) => policyController.setAccidents(value),
          ),

          const SizedBox(height: 20),

          // Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: policyState.isLoading
                ? null
                : () async {
                    await policyController.createPolicy();
                  },
            child: policyState.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('CREAR PÓLIZA', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
