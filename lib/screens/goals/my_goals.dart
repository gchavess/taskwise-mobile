import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:task_wise_frontend/screens/goals/create_goals.dart';

class MyGoals extends StatefulWidget {
  final String userId;
  final String userToken;
  final bool isPopupMenuShowing = false;

  const MyGoals({
    Key? key,
    required this.userId,
    required this.userToken,
  }) : super(key: key);

  @override
  _MyGoalsState createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  Color inputDetailColor = Color(0xFF0047B2);
  Color textColor = Color.fromARGB(255, 63, 63, 63);

  List<Map<String, dynamic>> goalDataList = [];

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  void refreshData() {
    fetchDataGoals();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _expirationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Fetch data when the screen is first loaded
    fetchDataGoals();

    // Add a post-frame callback to fetch data whenever the screen comes into focus
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      fetchDataGoals();
    });
  }

  void fetchDataGoals() async {
    final response = await http.get(Uri.parse(
        'https://taskwise-backend.cyclic.cloud/goals/${widget.userId}'));

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      goalDataList.clear();

      for (var data in dataList) {
        if (data is Map<String, dynamic>) {
          List<dynamic>? tasks = data['tasks'];

          List<Map<String, dynamic>> tasksList = [];

          if (tasks != null) {
            tasksList = List<Map<String, dynamic>>.from(tasks);
          }

          goalDataList.add({
            'id': data['id'] ?? '',
            'titulo': data['titulo'] ?? '',
            'data_vencimento': data['data_vencimento'] ?? '',
            'totalTarefa': data['totalTasks'] ?? '',
            'totalTarefaConcluida': data['tasksConcluidoTrue'] ?? '',
            'tasks': tasksList,
          });
        }
      }
      setState(() {});
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  }

  // Função para gerar o ListTile com PopupMenuButton
  Widget buildListTileWithPopupMenu(String title, String subtitle,
      int totalTarefa, int totalTarefaConcluida, String id) {
    return Builder(
      builder: (BuildContext context) {
        return Card(
          elevation: 7,
          color: const Color.fromARGB(255, 0, 71, 178),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$totalTarefaConcluida de $totalTarefa',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'editar') {
                  _editarCriar('editar', context, id, title, subtitle);
                } else if (value == 'excluir') {
                  _confirmarExclusao(context, id);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'editar',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text(
                      'Editar',
                      style: TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'excluir',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(
                      'Excluir',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              if (!Scaffold.of(context).isEndDrawerOpen) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateGoals(
                      goalId: id,
                      userId: widget.userId,
                      onScreenClosed: () {
                        // Este é o callback que será chamado quando CreateGoals for fechada
                        fetchDataGoals();
                      },
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Trigger fetchDataGoals when the user presses the back button
        fetchDataGoals();
        return true; // Allow the pop to happen
      },
      child: Scaffold(
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
                            onPressed: () => Navigator.of(context).pop(null),
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 30,
                          ),
                          const Text(
                            'Minhas Metas',
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
                      for (var goalData in goalDataList)
                        buildListTileWithPopupMenu(
                          goalData['titulo'] ?? '',
                          goalData['data_vencimento'] ?? '',
                          goalData['totalTarefa'] ?? '',
                          goalData['totalTarefaConcluida'] ?? '',
                          goalData['id'] ?? '',
                        ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
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
          title: Text('Editar Meta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRoundedTextField(
                controller: _taskNameController,
                labelText: 'Nome da Meta',
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
                  _editarMeta(id);
                } else {
                  _criarMeta();
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

  void _confirmarExclusao(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Tem certeza de que deseja excluir esta meta?'),
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
                _excluirMeta(id);
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

  void _excluirMeta(String id) async {
    final response = await http.delete(
      Uri.parse('https://taskwise-backend.cyclic.cloud/goals/$id'),
    );

    print(id);
    if (response.statusCode == 200) {
      fetchDataGoals();
    } else {
      print('Erro na exclusão: ${response.statusCode}');
    }
  }

  void _criarMeta() async {
    final String taskName = _taskNameController.text;
    final String expirationDate = _expirationController.text;

    final Map<String, dynamic> data = {
      'titulo': taskName,
      'data_vencimento': expirationDate,
      'userId': widget.userId,
    };

    final response = await http.post(
      Uri.parse('https://taskwise-backend.cyclic.cloud/goals'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      fetchDataGoals();
    } else {
      print('Erro no edit: ${response.statusCode}');
    }
  }

  void _editarMeta(String? id) async {
    final String taskName = _taskNameController.text;
    final String expirationDate = _expirationController.text;

    final Map<String, dynamic> data = {
      'titulo': taskName,
      'data_vencimento': expirationDate,
    };

    print(jsonEncode(data));

    final response = await http.put(
      Uri.parse('https://taskwise-backend.cyclic.cloud/goals/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      fetchDataGoals();
    } else {
      print('Erro no edit: ${response.statusCode}');
    }
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
