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
      title: Text(title, style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white
      )),

      backgroundColor: bgColor,
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
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => _modalSearchContest(title, colorCard)
        )

      },

      child: Container(
        margin: EdgeInsets.all(7.0),
        padding: EdgeInsets.all(7.0),

        height: 180,
        color: colorCard,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textCard(title, 30),
                _textCard('13/01/2026', 20)
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textCard("Concurso: 9999", 20),
                _textCard("01 - 02 - 03 - 04 - 05", 20)
              ],
            ),

            Column(
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

  Widget _modalSearchContest(String game, Color colorTheme) {
    return Scaffold(

      appBar: _appBar(game, colorTheme),
      body: _modalBody(colorTheme),

    );

  }

  Widget _modalBody(Color colorTheme) {
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

                  child: Text("Buscar Concurso", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )),   
                ),
              )
            ],
          ),

          SizedBox(height: 20),

          Container(
            color: colorTheme,
            
            padding: EdgeInsets.all(20),

            child: Column(
              children: [

                _textCard("Concurso: 9999", 20),
                _textCard("13/01/2026", 20),
                _textCard("01 - 02 - 03 - 04 - 05 - 06", 30)

              ],
            ),

          )

        ],
      ),
    );
  }

}