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

  Future<List<Map<String, dynamic>>>? _futureResultados;
  bool _isLoad = false;

  @override
  void initState() {
    super.initState();
    _atualizarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _decorator.appBar("Resultados Loteria", Colors.indigo),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBody(Colors.indigo),
    );
  }

  void _atualizarDados() async {

    if (_isLoad) {
      return;
    }

    setState(() {
      _futureResultados = Future.wait([
        _api.fetchGameLatest(TypeGame.QUINA),
        _api.fetchGameLatest(TypeGame.MEGASENA)
      ]);
    });

    try {
      await _futureResultados;
    } finally {
      _isLoad = false;
    }
  }

  Widget _body() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureResultados,
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
                Expanded(
                  child: _decorator.textModel("Erro Ao Carregar Dados: ${snapshot.error}", 20),
                )
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
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) => _modalSearchContest(title, colorTheme, game)
        )
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
                _decorator.textModel("Data do Próximo: ${data['dataProximoConcurso']}", 15),
              ],
            ),
        ],
      ),
    );
  }

  Widget _modalSearchContest(String title, Color colorTheme, TypeGame typeGame) {
    Map<String, dynamic>? _resultadoBusca;
    bool _carregando = false;
    String? _erro;
    final TextEditingController _controller = TextEditingController();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Buscar - ${title}", style: TextStyle(
                  color: colorTheme,
                  fontSize: 20
                )),
                const SizedBox(height: 20),

                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Digite o Número do Concurso",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search, color: colorTheme),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: colorTheme, shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                    onPressed: _carregando ? null : () async {
                      if (_controller.text.isEmpty) return;

                      setModalState(() {
                        _carregando = true;
                        _erro = null;
                        _resultadoBusca = null;
                      });

                      try {
                        final result = await _api.fetchGameContest(typeGame, _controller.text);

                        setModalState(() {
                          _resultadoBusca = result;
                          _carregando = false;
                        });
                      } catch (e) {
                        setModalState(() {
                          _erro = "Concurso não encontrado!";
                          _carregando = false;
                        });
                      }
                    },
                    child: _carregando
                        ? const CircularProgressIndicator(color: Colors.white)
                        : _decorator.textModel("Buscar Concurso", 20),
                  ),
                ),

                const SizedBox(height: 20),

                if (_erro != null)
                  Text(_erro!, style: TextStyle(color: Colors.red, fontSize: 18)),

                if (_resultadoBusca != null)
                  _cardGame(title, colorTheme, _resultadoBusca!, false),

                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _bottomNavigationBody(Color colorTheme) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: _isLoad ? null : () => _atualizarDados(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorTheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: _decorator.textModel("Atualizar Resultados", 20),
                ) 
            ),
          )
        ],
      )
    );
  }

}
