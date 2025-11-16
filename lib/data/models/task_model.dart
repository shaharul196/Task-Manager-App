// "_id": "65b4a19c279fb0f60f610bb0",
// "title": "A",
// "description": "v",
// "status": "New",
// "email": "softenghasan25@gmail.com",
// "createdDate": "2024-01-27T06:24:25.316Z"

class TaskModel{
  late String id;
  late String title;
  late String description;
  late String status;
  late String createdDate;

  TaskModel.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['_id'];
    title = jsonData['title'];
    description = jsonData['description'];
    status = jsonData['status'];
    createdDate = jsonData['createdDate'];
  }
}