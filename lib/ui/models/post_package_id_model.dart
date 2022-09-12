class PostPackageIdModel {
    PostPackageIdModel({
        this.packageId,
    });

    String? packageId;

    factory PostPackageIdModel.fromJson(Map<String, dynamic> json) => PostPackageIdModel(
        packageId: json["packageId"],
    );

    Map<String, dynamic> toJson() => {
        "packageId": packageId,
    };
}