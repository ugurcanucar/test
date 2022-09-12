class SendMessageModel {
  SendMessageModel({
    this.messageGroupId,
    this.text,
    this.file,
  });

  String? messageGroupId;
  String? text;
  FileClassModel? file;

  factory SendMessageModel.fromJson(Map<String, dynamic> json) =>
      SendMessageModel(
        messageGroupId: json["messageGroupId"],
        text: json["text"],
        file: FileClassModel.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "messageGroupId": messageGroupId,
        "text": text,
        "file": file != null ? file!.toJson() : null,
      };
}

class FileClassModel {
  FileClassModel({
    this.type,
    this.testId,
    this.file,
    this.fileExtension,
  });

  int? type;
  int? testId;
  String? file;
  String? fileExtension;

  factory FileClassModel.fromJson(Map<String, dynamic> json) => FileClassModel(
        type: json["type"],
        testId: json["testId"],
        file: json["file"],
        fileExtension: json["fileExtension"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "testId": testId,
        "file": file,
        "fileExtension": fileExtension,
      };
}
