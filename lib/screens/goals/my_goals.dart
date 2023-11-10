import 'package:flutter/material.dart';

class MyGoals extends StatelessWidget {
  const MyGoals({super.key});

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
                  'Minhas Metas',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  icon: const Icon(Icons.add),
                  iconSize: 45,
                ),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Não há metas criadas!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}