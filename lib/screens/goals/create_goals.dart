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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = false;
        });
      },
      child: Scaffold(
        body: Padding(
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
                    'Minhas Tarefas',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    icon: const Icon(Icons.edit),
                    iconSize: 35,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  height: _isExpanded ? 240 : 154, // Alterei a altura para acomodar o botão
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 78, 78, 78),
                          offset: Offset(0, 2),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isExpanded)
                          TextFormField(
                            controller: _taskNameController,
                            decoration: const InputDecoration(
                              labelText: 'Nome da Tarefa',
                            ),
                          )
                        else
                          const Text(
                            'Nova tarefa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const SizedBox(height: 20.0),
                        if (_isExpanded)
                          TextFormField(
                            controller: _expirationController,
                            decoration: const InputDecoration(
                              labelText: 'Data, hora de expiração',
                            ),
                          )
                        else
                          const Text(
                            'Data, hora de expiração',
                            style: TextStyle(
                              color: Color.fromARGB(255, 173, 173, 173),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (_isExpanded)
                          const SizedBox(height: 20.0),
                        if (_isExpanded)
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
            ],
          ),
        ),
      ),
    );
  }
}
