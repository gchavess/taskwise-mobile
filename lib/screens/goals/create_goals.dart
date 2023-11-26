import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/services.dart';

class CreateGoals extends StatefulWidget {
  final String goalId;
  final Function onScreenClosed;

  const CreateGoals(
      {Key? key, required this.goalId, required this.onScreenClosed})
      : super(key: key);

  @override
  _CreateGoalsState createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  bool _isExpanded = false;
  List<Map<String, dynamic>> taskDataList = [];

  Color inputDetailColor = Color(0xFF0047B2);
  Color textColor = Color.fromARGB(255, 63, 63, 63);

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  @override
  void dispose() {
    _taskNameController.dispose();
    _expirationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchDataTasks();
  }

  void fetchDataTasks() async {
    final response = await http.get(Uri.parse(
        'https://taskwise-backend.cyclic.cloud/tasks/${widget.goalId}'));
    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      taskDataList.clear();

      for (var data in dataList) {
        if (data is Map<String, dynamic>) {
          taskDataList.add({
            'id': data['id'] ?? '',
            'titulo': data['titulo'] ?? '',
            'data_vencimento': data['hora_fim'] ?? '',
            'concluido': data['concluido'] ?? '',
          });
        }
      }
      print(taskDataList);
      setState(() {});
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  }

  Widget buildListTileWithPopupMenu(
      String title, String subtitle, String id, bool concluido) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                if (concluido) // Mostrar apenas se concluído for falso
                  Text(
                    'Concluído',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'editar') {
              _editarCriar('editar', context, id, title, subtitle);
            } else if (value == 'excluir') {
              _confirmarExclusao(context, id);
            } else if (value == 'concluir' && !concluido) {
              _confirmarConcluir(context, id);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'editar',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'excluir',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Excluir'),
              ),
            ),
            if (!concluido) // Adicionar este bloco apenas se concluído for falso
              const PopupMenuItem<String>(
                value: 'concluir',
                child: ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Concluir'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _editarCriar(String acao, BuildContext context, String? id,
      String? titulo, String? dataVencimento) {
    var dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );

    if (titulo != null) {
      _taskNameController.text = titulo;
    } else {
      _taskNameController.text = '';
    }

    if (dataVencimento != null) {
      _expirationController.text = dataVencimento;
    } else {
      _expirationController.text = '';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRoundedTextField(
                controller: _taskNameController,
                labelText: 'Nome da Tarefa',
                detailColor: inputDetailColor,
              ),
              SizedBox(height: 20),
              _buildRoundedTextField(
                controller: _expirationController,
                labelText: 'Data de Vencimento',
                detailColor: inputDetailColor,
                inputFormatters: [dateMaskFormatter],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (acao == 'editar') {
                  _editarTarefa(id);
                } else {
                  _criarTarefa();
                }
              },
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarConcluir(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar conclusão'),
          content: Text('Tem certeza de que deseja concluir esta Tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _concluirTarefa(id);
              },
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarExclusao(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja excluir esta Tarefa?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _excluirTarefa(id);
              },
              style: TextButton.styleFrom(
                primary: inputDetailColor, // Cor do texto do botão
              ),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirTarefa(String id) async {
    final response = await http.delete(
      Uri.parse('https://taskwise-backend.cyclic.cloud/tasks/$id'),
    );

    print(id);
    if (response.statusCode == 200) {
      fetchDataTasks();
    } else {
      print('Erro na exclusão: ${response.statusCode}');
    }
  }

  void _concluirTarefa(String? id) async {
    final Map<String, dynamic> data = {
      'concluido': true,
    };

    final response = await http.put(
      Uri.parse('https://taskwise-backend.cyclic.cloud/tasks/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      fetchDataTasks();
    } else {
      print('Erro no edit: ${response.statusCode}');
    }
  }

  void _criarTarefa() async {
    final String taskName = _taskNameController.text;
    final String expirationDate = _expirationController.text;

    final Map<String, dynamic> data = {
      'titulo': taskName,
      'hora_fim': expirationDate,
      'goalId': widget.goalId,
    };

    final response = await http.post(
      Uri.parse('https://taskwise-backend.cyclic.cloud/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      fetchDataTasks();
    } else {
      print('Erro no edit: ${response.statusCode}');
    }
  }

  void _editarTarefa(String? id) async {
    final String taskName = _taskNameController.text;
    final String expirationDate = _expirationController.text;

    final Map<String, dynamic> data = {
      'titulo': taskName,
      'hora_fim': expirationDate,
    };

    print('chegouuuuuuuuuuuuuu');
    print(jsonEncode(data));
    print(id);

    final response = await http.put(
      Uri.parse('https://taskwise-backend.cyclic.cloud/tasks/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      fetchDataTasks();
    } else {
      print('Erro no edit: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.onScreenClosed();

                            // Fecha a tela
                            Navigator.of(context).pop(null);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                          iconSize: 30,
                        ),
                        const Text(
                          'Tarefas',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _editarCriar('criar', context, '', '', '');
                          },
                          icon: const Icon(Icons.add),
                          iconSize: 35,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    for (var goalData in taskDataList)
                      buildListTileWithPopupMenu(
                        goalData['titulo'] ?? '',
                        goalData['data_vencimento'] ?? '',
                        goalData['id'] ?? '',
                        goalData['concluido'] == "" ? false : true,
                      ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 16.0,
            right: 16.0,
            child: Visibility(
              visible: _isExpanded,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 50,
                        blurRadius: 100,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _taskNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome da Tarefa',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _expirationController,
                          decoration: const InputDecoration(
                            labelText: 'Data, hora de expiração',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.check),
                              iconSize: 30,
                              color: const Color.fromARGB(255, 0, 71, 178),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController? controller,
    required String labelText,
    bool isPassword = false,
    required Color detailColor,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: textColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: detailColor),
        ),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid $labelText';
        }
        return null;
      },
    );
  }
}
