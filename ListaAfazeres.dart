import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controlador = TextEditingController();
  late Tarefa? _tarefaSelecionada;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.green.shade50,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Afazeres'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  final tarefa = _tarefas[index];
                  return ListTile(
                    title: Text(
                      tarefa.descricao,
                      style: TextStyle(
                        decoration: tarefa.status ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: tarefa.status,
                      onChanged: (novoValor) {
                        setState(() {
                          tarefa.status = novoValor ?? false;
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _controlador.text = tarefa.descricao;
                          _tarefaSelecionada = tarefa;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        tarefa.status = !tarefa.status;
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controlador,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: const Size(200, 60),
                    ),
                    child: Text(_tarefaSelecionada == null ? 'Adicionar Tarefa' : 'Salvar Edição'),
                    onPressed: () {
                      if (_controlador.text.isEmpty) {
                        return;
                      }
                      setState(() {
                        if (_tarefaSelecionada == null) {
                          _tarefas.add(
                            Tarefa(
                              descricao: _controlador.text,
                              status: false,
                            ),
                          );
                        } else {
                          _tarefaSelecionada!.descricao = _controlador.text;
                          _tarefaSelecionada = null;
                        }
                        _controlador.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Tarefa {
  String descricao;
  bool status;

  Tarefa({required this.descricao, required this.status});
}