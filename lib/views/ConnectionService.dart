import 'dart:convert';

import 'package:http/http.dart' as http;

class Connectionservice {

  Future<Map<String, dynamic>> fetchGameLatest(String game) async {
    final url = game == "quina" ? 'https://servicebus2.caixa.gov.br/portaldeloterias/api/quina' : 'https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'numero': data['numero'],
        'dataApuracao': data['dataApuracao'],
        'listaDezenas': data['listaDezenas'].join(" - "),
        'numeroConcursoProximo': data['numeroConcursoProximo'],
        'dataProximoConcurso': data['dataProximoConcurso']
      };

    } else {
      throw Exception("Erro ao Carregar Dados da API.");

    }
  }

}