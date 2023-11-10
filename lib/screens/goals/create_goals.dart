import 'package:flutter/material.dart';

class CreateGoals extends StatelessWidget {
  const CreateGoals({super.key});

  @override
   @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Nova Meta',
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
            Positioned(
              child: Container(
                alignment: Alignment.topLeft,
                height: 154,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 78, 78, 78),
                      offset: Offset(0, 2),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nova tarefa',
                            style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height:8.0),
                          const Text("teste",
                          ), 
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}