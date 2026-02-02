import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/policy_controller.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search input
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Nombre del propietario',
              hintText: 'Ingrese el nombre para buscar',
              border: const OutlineInputBorder(),
              filled: true,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
            enabled: !policyState.isLoading,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          // Search button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: policyState.isLoading
                ? null
                : () async {
                    await policyController.searchPolicy(_searchController.text);
                  },
            icon: policyState.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.search),
            label: const Text('BUSCAR PÓLIZA', style: TextStyle(fontSize: 16)),
          ),

          const SizedBox(height: 24),

          // Results
          if (policyState.searchResult != null)
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '📋 Detalles de la Póliza',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Propietario',
                          policyState.searchResult!['propietario'] ?? 'N/A',
                          Icons.person,
                        ),
                        _buildDetailRow(
                          'Modelo',
                          policyState.searchResult!['modelo'] ?? 'N/A',
                          Icons.directions_car,
                        ),
                        _buildDetailRow(
                          'Valor del Auto',
                          '\$${policyState.searchResult!['valor']?.toStringAsFixed(2) ?? '0.00'}',
                          Icons.attach_money,
                        ),
                        _buildDetailRow(
                          'Edad',
                          '${policyState.searchResult!['edadPropietario']?.toString() ?? 'N/A'} años',
                          Icons.cake,
                        ),
                        _buildDetailRow(
                          'Accidentes',
                          policyState.searchResult!['accidentes'] == true
                              ? 'Sí'
                              : 'No',
                          Icons.warning,
                        ),
                        const Divider(height: 24),
                        _buildDetailRow(
                          'Costo Total',
                          '\$${policyState.searchResult!['costoTotal']?.toStringAsFixed(2) ?? '0.00'}',
                          Icons.monetization_on,
                          isHighlight: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else if (!policyState.isLoading)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 100, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      'Buscar Pólizas',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ingrese un nombre y presione buscar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: isHighlight ? Colors.green : Colors.deepPurple,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isHighlight ? 20 : 16,
                    fontWeight: isHighlight
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isHighlight ? Colors.green : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
