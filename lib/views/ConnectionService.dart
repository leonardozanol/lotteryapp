import 'dart:convert';

import 'package:http/http.dart' as http;

class Connectionservice {

  Future<Map<String, dynamic>> fetchGameLatest(String game) async {
    final url = game == "Quina" ? 'https://servicebus2.caixa.gov.br/portaldeloterias/api/quina' : 'https://servicebus2.caixa.gov.br/portaldeloterias/api/megasena';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'contest': data['numero'],
        'date': data['dataApuracao'],
        'listDiscount': data['listaDezenas'],
        'numberNextContest': data['numeroConcursoProximo'],
        'dateNextContext': data['dataProximoConcurso']
      };

    } else {
      throw Exception("Erro ao Carregar Dados da API.");

    }
  }

}