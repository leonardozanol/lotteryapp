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
      appBar: _appBar(),
      body: _body(),

    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("Resultados Loteria", style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white
      )),

      backgroundColor: Colors.indigo,
      centerTitle: true,
    );
  }

  Widget _body() {

    return ListView(
      children: [
        _cardGame("Quina", Colors.indigo),
        _cardGame("Mega-Sena", Colors.green)
      ],
    );

  }

  Widget _cardGame(String title, Color colorCard) {
    return GestureDetector(
      onTap: () => {
        // Atualizar Consulta
      },
      child: Container(
        margin: EdgeInsets.all(7.0),
        padding: EdgeInsets.all(7.0),

        height: 180,
        color: colorCard,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textCard(title, 30),
                _textCard('13/01/2026', 20)
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textCard("Concurso: 9999", 20),
                _textCard("01 - 02 - 03 - 04 - 05", 20)
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textCard("Próximo Concurso: 894894", 15),
                _textCard("13/01/2026", 15)
              ],
            )
          ],
        )

      )
    );
  }

  Widget _textCard(text, fSize) {
    return Text(text, style: TextStyle(
      fontSize: fSize,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ));

  }

}