import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar("Resultados Loteria", Colors.indigo),
      body: _body(),

    );
  }

  AppBar _appBar(String title, Color bgColor) {
    return AppBar(
      title: _textModel(title, 20),

      backgroundColor: bgColor,
      centerTitle: true,
    );
  }

  Widget _textModel(text, fSize) {
    return Text(text, style: TextStyle(
        fontSize: fSize,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ));

  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(10.0),
      children: [
        _cardGame("Quina", Colors.indigo),
        _cardGame("Mega-Sena", Colors.green)
      ],
    );

  }

  Widget _cardGame(String game, Color colorTheme) {
    return Container(
      color: colorTheme,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(5.0),

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textModel(game, 30),
              _textModel("13/01/2026", 20) // 13/01/2026 - 'date': data['dataApuracao']
            ],
          ),

          Column(
            children: [
              _textModel("Concurso: 9999", 20), // 9999 - 'contest': data['numero']
              _textModel("01 - 02 - 03 - 04 - 05", 20) // 01 - 02 - 03 - 04 - 05 - 'listDiscount': data['listaDezenas']
            ],
          ),

          Column(
            children: [
               _textModel("Próximo Concurso: 9999", 15), // 9999 - 'numberNextContest': data['numeroConcursoProximo']
               _textModel("14/01/2026", 15) // 14/01/2026 - 'dateNextContext': data['dataProximoConcurso']
             ],
          )
        ],
      ),
    );
  }

}