import 'package:flutter/material.dart';
import 'package:lottery_app/services/ConnectionService.dart';
import 'package:lottery_app/utils/TypeGame.dart';
import 'package:lottery_app/utils/UtilsDecorator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Connectionservice _api = Connectionservice();
  final UtilsDecorator _decorator = UtilsDecorator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _decorator.appBar("Resultados Loteria", Colors.indigo),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait([
        _api.fetchGameLatest(TypeGame.QUINA),
        _api.fetchGameLatest(TypeGame.MEGASENA),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            color: Colors.redAccent,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _decorator.textModel("Erro Ao Carregar Dados: ${snapshot.error}", 20),
              ],
            ),
          );
        }

        final resultados = snapshot.data!;

        return ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            _cardGameButton(
              "Quina",
              Colors.indigo,
              resultados[0],
              TypeGame.QUINA,
            ),
            _cardGameButton(
              "Mega-Sena",
              Colors.green,
              resultados[1],
              TypeGame.MEGASENA,
            ),
          ],
        );
      },
    );
  }

  Widget _cardGameButton(
    String title,
    Color colorTheme,
    Map<String, dynamic> data,
    TypeGame game,
  ) {
    return GestureDetector(
      onTap: () => {
        //showModalBottomSheet(
        // context: context,
        //isScrollControlled: true,
        //useSafeArea: true,
        //builder: (context) =>
        //)
      },
      child: _cardGame(title, colorTheme, data, true),
    );
  }

  Widget _cardGame(
    String title,
    Color colorTheme,
    Map<String, dynamic> data,
    bool isDetaild,
  ) {
    return Container(
      color: colorTheme,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(5.0),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _decorator.textModel(title, 30),
              _decorator.textModel(data['dataApuracao'], 20),
            ],
          ),

          Column(
            children: [
              _decorator.textModel("Concurso: ${data['numero']}", 20),
              _decorator.textModel(data['listaDezenas'], 20),
            ],
          ),

          if (isDetaild)
            Column(
              children: [
                _decorator.textModel(
                  "Próximo Concurso: ${data['numeroConcursoProximo']}",
                  15,
                ),
                _decorator.textModel(data['dataProximoConcurso'], 15),
              ],
            ),
        ],
      ),
    );
  }
}
