class NotificationModel{
  int? id;
  String? title;
  String? dateTimeNoty;
  String? beforeTimeActive;
  bool? active;

  NotificationModel({this.id, this.title, this.dateTimeNoty, this.beforeTimeActive,
      this.active});
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if(id!=null){
      data['id'] = id;
    }
    if(title!=null){
      data['title'] = title;
    }
    if(dateTimeNoty!=null){
      data['dateTime'] = dateTimeNoty;
    }
    if(beforeTimeActive!=null){
      data['beforeTimeActive'] = beforeTimeActive;
    }
    if(active!=null){
      data['active'] = active;
    }
    return data;
  }

}