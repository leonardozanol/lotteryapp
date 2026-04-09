import 'package:flutter/material.dart';
import 'package:lottery_app/views/ConnectionService.dart';
import 'package:lottery_app/views/TypeGame.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  final Connectionservice _api = Connectionservice();

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

  Widget _textModel(String text, double fSize) {
    return Text(text, style: TextStyle(
        fontSize: fSize,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ));

  }

  Widget _body() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Future.wait([
        _api.fetchGameLatest(TypeGame.QUINA),
        _api.fetchGameLatest(TypeGame.MEGASENA)
      ]),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            color: Colors.redAccent,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(15.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textModel("Erro Ao Carregar Dados: ${snapshot.error}", 20),
              ],
            ),

          );
        }

        final resultados = snapshot.data!;

        return ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            _cardGameButton("Quina", Colors.indigo, resultados[0]),
            _cardGameButton("Mega-Sena", Colors.green, resultados[1])
          ],
        );
      }
    );

  }

  Widget _cardGameButton(String title, Color colorTheme, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) => _modalSearchContest(title, colorTheme)
        )
      },
      child: _cardGame(title, colorTheme, data),
    );
  }

  Widget _cardGame(String title, Color colorTheme, Map<String, dynamic> data) {
    return Container(
      color: colorTheme,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(5.0),

      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textModel(title, 30),
              _textModel(data['dataApuracao'], 20)
            ],
          ),

          Column(
            children: [
              _textModel("Concurso: ${data['numero']}", 20),
              _textModel(data['listaDezenas'], 20)
            ],
          ),

          Column(
            children: [
              _textModel("Próximo Concurso: ${data['numeroConcursoProximo']}", 15), 
              _textModel(data['dataProximoConcurso'], 15)
            ],
          )
        ],
      ),
    );
  }

  Widget _modalSearchContest(String title, Color colorTheme) {
    return Scaffold(
      appBar: _appBar(title, colorTheme),
      body: _modalSearchBody(title, colorTheme),
    );
  }

  Widget _modalSearchBody(String title, Color colorTheme) {
    TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),

      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o Número do Concurso"
              ),
            )
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
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
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: _textModel("teste", 20),
          )

        ],
      ),
    );
  }

}