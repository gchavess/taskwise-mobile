import 'package:flutter/material.dart';
import 'package:task_wise_frontend/screens/goals/create_goals.dart';

class MyGoals extends StatefulWidget {
  const MyGoals({Key? key}) : super(key: key);

  @override
  _MyGoalsState createState() => _MyGoalsState();
}

class _MyGoalsState extends State<MyGoals> {
  final bool _isExpanded = false;

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  @override
  void dispose() {
    _taskNameController.dispose();
    _expirationController.dispose();
    super.dispose();
  }

  // Função para gerar o ListTile com PopupMenuButton
  Widget buildListTileWithPopupMenu(String title, String subtitle) {
    return Card(
      elevation: 7,
      color: const Color.fromARGB(255, 0, 71, 178),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white), // Define a cor do título como branco
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white), // Define a cor do subtítulo como branco
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            // Lógica para editar ou excluir a tarefa de acordo com a opção selecionada
            if (value == 'editar') {
              // Adicionar a lógica de edição aqui
            } else if (value == 'excluir') {
              // Adicionar a lógica de exclusão aqui
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'editar',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar', style: TextStyle(color: Color.fromARGB(255, 15, 15, 15))), // Define a cor do texto como branco
              ),
            ),
            const PopupMenuItem<String>(
              value: 'excluir',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Excluir', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))), // Define a cor do texto como branco
              ),
            ),
          ],
        ),
      ),
    );
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
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const CreateGoals()),
                              );
                            },
                          icon: const Icon(Icons.add),
                          iconSize: 35,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Cartões estáticos com menu de opções
                    buildListTileWithPopupMenu('Meta 1',''),
                    buildListTileWithPopupMenu('meta 2',''),
                    buildListTileWithPopupMenu('Meta 3',''),
                    buildListTileWithPopupMenu('Meta 4',''),
                    // ... (código dos outros cartões estáticos com menu de opções)
                    // Fim dos cartões estáticos
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
