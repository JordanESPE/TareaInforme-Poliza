import 'dart:convert';
import 'package:http/http.dart' as http;

class PolizaRequest {
  final String propietario;
  final String apellidoPropietario;
  final String edadPropietario;
  final String modeloAuto;
  final double valorSeguroAuto;
  final bool accidentes;

  PolizaRequest({
    required this.propietario,
    required this.apellidoPropietario,
    required this.edadPropietario,
    required this.modeloAuto,
    required this.valorSeguroAuto,
    required this.accidentes,
  });

  Map<String, dynamic> toJson() {
    return {
      'propietario': propietario,
      'apellidoPropietario': apellidoPropietario,
      'edadPropietario': edadPropietario,
      'modeloAuto': modeloAuto,
      'valorSeguroAuto': valorSeguroAuto,
      'accidentes': accidentes,
    };
  }
}

class PolizaResponse {
  final String propietario;
  final String apellidoPropietario;
  final String modelo;
  final double valor;
  final String edad;
  final bool accidentes;
  final double costoTotal;

  PolizaResponse({
    required this.propietario,
    required this.apellidoPropietario,
    required this.modelo,
    required this.valor,
    required this.edad,
    required this.accidentes,
    required this.costoTotal,
  });

  factory PolizaResponse.fromJson(Map<String, dynamic> json) {
    return PolizaResponse(
      propietario: json['propietario'],
      apellidoPropietario: json['apellidoPropietario'],
      modelo: json['modelo'],
      valor: json['valor'].toDouble(),
      edad: json['edad'],
      accidentes: json['accidentes'],
      costoTotal: json['costoTotal'].toDouble(),
    );
  }
}

class PolizaService {
  // URL base del backend - ajusta el puerto si es necesario
  static const String baseUrl = 'http://10.0.2.2:9090/bdd_dto';

  Future<PolizaResponse> crearPoliza(PolizaRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/poliza'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PolizaResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error al crear póliza: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<PolizaResponse> buscarPolizaPorNombre(String nombre) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/poliza/usuario?nombre=$nombre'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PolizaResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error al buscar póliza: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
