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
      children: [
        _cardGame("Quina", Colors.indigo),
        _cardGame("Mega-Sena", Colors.green)
      ],
    );

  }

  Widget _cardGame(String game, Color colorCard) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => _modalSearchContest(game, colorCard)
        )
      },
      child: _boxDetailsGame(game, colorCard, true)

    );
  }

  Widget _boxDetailsGame(String game, Color colorTheme, bool isDetailed) {
    return Container(
      color: colorTheme,

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textModel(game, 30),
              _textModel("13/01/2026", 30)
            ],
          ),

          Column(
            children: [
              _textModel("Concurso: 9999", 20),
              _textModel("01 - 02 - 03 - 04 - 05", 20)
            ],
          ),

          if (isDetailed)
            Column(
              children: [
                _textModel("Próximo Concurso: 9999", 15),
                _textModel("14/01/2026", 15)
              ],
            )

        ],
      ),
    );
  }

  Widget _modalSearchContest(String game, Color colorTheme) {
    return Scaffold(
      appBar: _appBar(game, colorTheme),
      body: _modalBody(game, colorTheme),
    );
  }

  Widget _modalBody(String game, Color colorTheme) {
    TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      child: Column(
        children: [

          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Digite o Número do Concurso"
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorTheme,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                    )
                  ),

                  child: _textModel("Buscar Concurso", 20),

                ),
              )
            ],
          ),

          SizedBox(height: 20),

          _boxDetailsGame(game, colorTheme, false)

        ],
      ),
    );
  }

}