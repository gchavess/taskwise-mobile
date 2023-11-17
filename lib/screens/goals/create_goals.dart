import 'package:flutter/material.dart';

class CreateGoals extends StatefulWidget {
  const CreateGoals({Key? key}) : super(key: key);

  @override
  _CreateGoalsState createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  bool _isExpanded = false;

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
      elevation: 5,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
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
                          'Tarefas',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          icon: const Icon(Icons.done),
                          iconSize: 35,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // Cartões estáticos com menu de opções
                    buildListTileWithPopupMenu('Tarefa 1', 'Data de expiração: 20/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 2', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 3', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 4', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 5', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 6', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 7', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 8', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 9', 'Data de expiração: 25/11/2023'),
                    buildListTileWithPopupMenu('Tarefa 10', 'Data de expiração: 25/11/2023'),
                    // ... (código dos outros cartões estáticos com menu de opções)
                    // Fim dos cartões estáticos
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
                              onPressed: () {
                                // Adicione aqui a lógica para confirmar a criação da tarefa
                                // Por exemplo, chamar uma função para salvar a tarefa no banco de dados
                              },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: _isExpanded ? const Icon(Icons.remove) : const Icon(Icons.add),
      ),
    );
  }
}
