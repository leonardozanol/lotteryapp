import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lottery_app/views/TypeGame.dart';

class Connectionservice {
  Future<Map<String, dynamic>> fetchGameLatest(TypeGame game) async {
    final url = game == TypeGame.QUINA
        ? 'https://servicebus2.caixa.gov.br/portaldeloterias/api/quina'
        : 'https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return {
          'numero': data['numero'] ?? 0,
          'dataApuracao': data['dataApuracao'] ?? 'Data Não Informada',
          'listaDezenas':
              data['listaDezenas']?.join(" - ") ?? 'Nenhum Número Disponível',
          'numeroConcursoProximo': data['numeroConcursoProximo'] ?? 0,
          'dataProximoConcurso': data['dataProximoConcurso'] ?? 'À Definir',
        };
      } else {
        throw Exception(
          "Erro ao Carregar Dados: Status Response ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Falha: $e");
    }
  }

  Future<Map<String, dynamic>> fetchGameContest(
    TypeGame game,
    String contest,
  ) async {
    final url = game == TypeGame.QUINA
        ? "https://servicebus2.caixa.gov.br/portaldeloterias/api/quina/${contest}"
        : "https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena/${contest}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return {
          'numero': data['numero'] ?? 0,
          'dataApuracao': data['dataApuracao'] ?? 'Data Não Informada',
          'listaDezenas':
              data['listaDezenas']?.join(" - ") ?? 'Nenhum Número Disponível',
        };
      } else if (response.statusCode == 500 || response.statusCode == 404) {
        throw Exception("Concurso Não Encontrado!");
        
      } else {
        throw Exception(
          "Erro ao Carregar Dados: Status Response ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Falha: ${e}");
    }
  }
}
