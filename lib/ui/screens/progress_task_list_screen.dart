import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widget/centered_circular_progress_indicator.dart';
import '../widget/snackbar_massage.dart';
import '../widget/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProgressTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Expanded(
        child: Visibility(
          visible: _getProgressTasksInProgress == false,
          replacement: CenteredCircularProgressIndicator(),
          child: ListView.builder(
            itemCount: _progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskType: TaskType.progress,
                taskModel: _progressTaskList[index],
                onStatusUpdate: () {
                  _getProgressTaskList();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urlss.getProgressTaskUrl,
    );

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      if(mounted){
        showSnackBarMassage(context, response.errorMassage!);

      }
    }

    _getProgressTasksInProgress = false;
    setState(() {});
  }
}
