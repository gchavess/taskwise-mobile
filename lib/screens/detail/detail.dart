import 'package:flutter/material.dart';
import 'package:task_wise_frontend/models/task.dart';
import 'package:task_wise_frontend/screens/detail/widgets/date_picker.dart';
import 'package:task_wise_frontend/screens/detail/widgets/task_title.dart';
import 'package:task_wise_frontend/screens/detail/widgets/task_timeline.dart';

class DetailPage extends StatelessWidget {
  final Task task;
  const DetailPage(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    final detialList = task.desc;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [DatePicker(), TaskTitle()],
                ),
              ),
            ),
            detialList == null
                ? SliverFillRemaining(
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text('Sem tarefas para hoje!')),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => TaskTimeline(detialList[index]),
                      childCount: detialList.length,
                    ),
                  ),
          ],
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: Colors.black,
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20),
      actions: const [
        Icon(
          Icons.more_vert,
          size: 30,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${task.title} Tasks',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Você tem ${task.left} Tasks para hoje!',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
