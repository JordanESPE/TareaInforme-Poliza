import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Backend base URL - adjust if needed
  static const String baseUrl = 'http://localhost:9090/bdd_dto/api';

  /// Create a new policy
  /// Returns a Map with the policy response or throws an exception on error
  static Future<Map<String, dynamic>> createPolicy({
    required String propietario,
    required int edadPropietario,
    required String modeloAuto,
    required double valorSeguroAuto,
    required bool accidentes,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/poliza');

      final body = jsonEncode({
        'propietario': propietario,
        'edadPropietario': edadPropietario,
        'modeloAuto': modeloAuto.replaceAll(
          'Modelo ',
          '',
        ), // Send only "A", "B", "C"
        'valorSeguroAuto': valorSeguroAuto,
        'accidentes': accidentes ? 1 : 0, // Convert bool to int
      });

      print('🚀 Sending POST request to: $url');
      print('📦 Body: $body');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // Try to parse clean error message from backend JSON
        try {
          final errorJson = jsonDecode(response.body);
          if (errorJson is Map && errorJson.containsKey('message')) {
            throw Exception(errorJson['message']);
          }
        } catch (_) {}
        throw Exception('Error al crear póliza: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error en createPolicy: $e');
      rethrow;
    }
  }

  /// Search policy by owner name
  /// Returns a Map with the policy details or throws an exception on error
  static Future<Map<String, dynamic>> searchPolicyByOwnerName(
    String nombre,
  ) async {
    try {
      final url = Uri.parse(
        '$baseUrl/poliza/usuario?nombre=${Uri.encodeComponent(nombre)}',
      );

      print('🔍 Sending GET request to: $url');

      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print('📡 Response status: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        throw Exception('No se encontró póliza para el propietario: $nombre');
      } else {
        throw Exception(
          'Error al buscar póliza: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('❌ Error en searchPolicyByOwnerName: $e');
      rethrow;
    }
  }
}
