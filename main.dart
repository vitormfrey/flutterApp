import 'package:flutter/material.dart';

class Vinho {
  // Atributos
  String _nome;
  String _estilo;
  String _pais; 
  int _safra = 0;
  int _valor = 0;

  

  // Construtor
  Vinho(this._nome, this._pais, this._safra, this._valor) {
    this._estilo = "R\$ " + this._valor.toString() + ",00";
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Vinho> lista = [];

  // Construtor
  MyApp() {
    Vinho vinho1 = Vinho("Villa lobos", "Brasil", 2000, 325);
    Vinho vinho2 = Vinho("Dúvida", "Portugal", 2008, 854);
    Vinho vinho3 = Vinho("Mundvs", "Argentina", 2006, 450);

    lista.add(vinho1);
    lista.add(vinho2);
    lista.add(vinho3);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Adega Pessoal",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFBA68C8),
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Vinho> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Vinho> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Vinhos em sua Adega (${lista.length})",
        style: TextStyle(
           fontSize: 22.0, 
           color: Colors.orange[50],
           fontFamily: 'RobotoMono',
          ),             
        ),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}:  Safra ${lista[index]._safra}  Valor ${lista[index]._estilo}",
                style: TextStyle(
                  fontSize: 18.0, 
                  color: Colors.orange[50],
                  fontFamily: 'RobotoMono',
                  fontStyle: FontStyle.italic,
                ),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.refresh),
        backgroundColor: const Color(0x8A000000),
        splashColor: Colors.purple,
      ),
    );
  }
}

/*Sidebar lateral*/
class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          
          DrawerHeader(
            child: Text(
              "Vinhos",
              style: TextStyle(color: Colors.orange[50], fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.purple),
          ),
          ListTile(
            leading: Icon(Icons.tapas_outlined, color: Colors.orange[50]),
            title: Text(
              "Informações dos Vinhos",
              style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
            ),
             
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoVinho(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline_outlined, color: Colors.orange[50]),
            title: Text(
              "Cadastrar um Novo Vinho",
              style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarVinho(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Colors.orange[50]),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaSobre(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Vinho
//-----------------------------------------------------------------------------

class TelaInformacoesDoVinho extends StatefulWidget {
  final List<Vinho> lista;

  // Construtor
  TelaInformacoesDoVinho(this.lista);

  @override
  _TelaInformacoesDoVinho createState() =>
      _TelaInformacoesDoVinho(lista);
}

class _TelaInformacoesDoVinho
    extends State<TelaInformacoesDoVinho> {
  // Atributos
  final List lista;
  Vinho vinho;
  int index = -1;
  double _fontSize = 18.0;

  final nomeController = TextEditingController();
  final paisController = TextEditingController();
  final safraController = TextEditingController();
  final valorController = TextEditingController();
  

  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoVinho(this.lista) {
    if (lista.length > 0) {
      index = 0;
      vinho = lista[0];

      nomeController.text = vinho._nome;
      paisController.text = vinho._pais;
      safraController.text = vinho._safra.toString();
      valorController.text = vinho._estilo;
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      vinho = lista[index];

      nomeController.text = vinho._nome;
      paisController.text = vinho._pais;
      safraController.text = vinho._safra.toString();
      valorController.text = vinho._estilo;
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._pais = paisController.text;
      lista[index]._safra = int.parse(safraController.text);
      lista[index]._estilo = valorController.text;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Vinho";
    if (vinho == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum Vinho encontrado!"),
            Container(
              color: Colors.purple,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do Vinho",
                
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: nomeController,
              ),
            ),

            
             Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pais",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: paisController,
              ),
            ),







            // {Valor do Vinho}
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Valor",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: valorController,
              ),
            ),

            
            //  {Safra}
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Safra",
                  hintText: "Safra do Vinho",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: safraController,
              ),
            ),

          //Botão de habilitar edição
            Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    child: Text(
                      "Habilitar Edição",
                      style: TextStyle(fontSize: _fontSize, ),
                    ),
                    color: const Color(0x8A000000),
                    textColor: Colors.orange[50],
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.purple,
                    onPressed: () {
                      _edicaoHabilitada = true;
                      setState(() {});
                    })),




            //Botão de atualizar dados
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              color: const Color(0x8A000000),
              textColor: Colors.orange[50],
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.purple,
              onPressed: _atualizarDados,
            ),
            Text(
              "${index + 1}/${lista.length}",
              style: TextStyle(fontSize: 20.0, color: Colors.orange[50],),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page, color: Colors.orange[50]),
                    backgroundColor: const Color(0x8A000000),
                    splashColor: Colors.purple,
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before, color: Colors.orange[50]),
                    backgroundColor: const Color(0x8A000000),
                    splashColor: Colors.purple,

                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next, color: Colors.orange[50]),
                    backgroundColor: const Color(0x8A000000),
                    splashColor: Colors.purple,

                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page, color: Colors.orange[50],),
                    backgroundColor: const Color(0x8A000000),
                    splashColor: Colors.purple,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Sobre
// ----------------------------------------------------------------------------

class TelaSobre extends StatefulWidget {
  @override
  _TelaSobreState createState() => _TelaSobreState();
}

class _TelaSobreState extends State<TelaSobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sobre")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Aplicação:", 
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.00, color: Colors.orange[50])
                 ),

              Text(
                "Aplicativo com foco em salvar vinhos em sua adega pessoal.", 
                 style: TextStyle(fontSize: 18.00, color: Colors.deepOrange[100])
                 ),

              Text(
                  "Aplicativo criado por:",
                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.00, color: Colors.orange[50])
                   ),

              Text(
                  "Vitor Moisés de Freitas Rey",
                   style: TextStyle(fontSize: 18.00, color: Colors.deepOrange[100])
                   ),

              Text(
                "RA:", 
                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.00, color: Colors.orange[50])
                 ),

              Text(
                "190008455",
                 style: TextStyle(fontSize: 18.00, color: Colors.deepOrange[100])
                ),

                Text(
                "Turma:",
                 style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold, color: Colors.orange[50])
                ),

                Text(
                "ADS - 4° Semestre",
                 style: TextStyle(fontSize: 18.00, color: Colors.deepOrange[100])
                )




            ],
          ),
        ));
  }
}

//-----------------------------------------------------------------------------
// Tela: Cadastrar Vinhos na Adega
// ----------------------------------------------------------------------------

class TelaCadastrarVinho extends StatefulWidget {
  final List<Vinho> lista;

  // Construtor
  TelaCadastrarVinho(this.lista);

  @override
  _TelaCadastrarVinhoState createState() =>
      _TelaCadastrarVinhoState(lista);
}

class _TelaCadastrarVinhoState extends State<TelaCadastrarVinho> {
  // Atributos
  final List<Vinho> lista;
  String _nome = "";
  String _pais = "";
  int _safra = 0;
  int _valor = 0;
  double _fontSize = 20.0;
  
  final nomeController = TextEditingController();
  final paisController = TextEditingController();
  final safraController = TextEditingController();
  final valorController = TextEditingController();
  

  // Construtor
  _TelaCadastrarVinhoState(this.lista);

  // Métodos
  void _cadastrarVinho() {
    _nome = nomeController.text;
    _pais = paisController.text;
    _safra = int.parse(safraController.text);
    _valor = int.parse(valorController.text);
    
    if (_nome != "" && _pais != "" && _safra > 0 &&_valor > 0 ) {
      var vinho = Vinho(_nome, _pais, _safra, _valor);
      lista.add(vinho);
      nomeController.text = "";
      paisController.text = "";
      valorController.text = "";
      safraController.text ="";
      _vinhoCadastrado();
    }
  }

  void _vinhoCadastrado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Cadastro Finalizado"),
          content: new Text("Vinho adicionado a Adega!!"),
          actions: <Widget>[
            
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Vinho"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Vinho",
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
              ),
            ),
            // { Nome do Vinho} 
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do Vinho",
                  
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: nomeController,
              ),
            ),

            // {País do Vinho}

            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "País",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: paisController,
              ),
            ),


            // {Safra do Vinho} 
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Safra",
                  hintText: "Exemplo: 1885",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: safraController,
              ),
            ),

            // {valor }
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Valor",
                ),
                style: TextStyle(fontSize: _fontSize, color: Colors.orange[50]),
                controller: valorController,
              ),
            ),
            
            // Saída
            RaisedButton(
              child: Text(
                "Adicionar Vinho a Adega",
                style: TextStyle(fontSize: _fontSize),
              ),

              color: const Color(0x8A000000),
              textColor: Colors.orange[50],
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              splashColor: Colors.purple,
              onPressed: _cadastrarVinho,
            ),
          ],
        ),
      ),
    );
  }
}


