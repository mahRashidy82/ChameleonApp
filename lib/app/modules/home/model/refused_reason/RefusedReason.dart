import 'Result.dart';

class RefusedReason {
  RefusedReason({
    this.result,
    this.id,
    this.exception,
    this.status,
    this.isCanceled,
    this.isCompleted,
    this.isCompletedSuccessfully,
    this.creationOptions,
    this.asyncState,
    this.isFaulted,
  });

  RefusedReason.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Result? result;
  int? id;
  dynamic exception;
  int? status;
  bool? isCanceled;
  bool? isCompleted;
  bool? isCompletedSuccessfully;
  int? creationOptions;
  dynamic asyncState;
  bool? isFaulted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['id'] = id;
    map['exception'] = exception;
    map['status'] = status;
    map['isCanceled'] = isCanceled;
    map['isCompleted'] = isCompleted;
    map['isCompletedSuccessfully'] = isCompletedSuccessfully;
    map['creationOptions'] = creationOptions;
    map['asyncState'] = asyncState;
    map['isFaulted'] = isFaulted;
    return map;
  }
}
