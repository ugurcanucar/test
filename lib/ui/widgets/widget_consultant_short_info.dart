import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terapizone/ui/controllers/controller_play_vimeo_video.dart';
import 'package:terapizone/ui/shared/uicolor.dart';
import 'package:terapizone/ui/shared/uipath.dart';
import 'package:terapizone/ui/shared/uitext.dart';
import 'package:terapizone/ui/views/view_play_vimeo_video.dart';
import 'package:terapizone/ui/widgets/widget_star_rating.dart';
import 'package:terapizone/ui/widgets/widget_text.dart';

class ConsultantShortInfo extends StatelessWidget {
  final String img;
  final String name;
  final String specialty;
  final String year;
  final double rating;
  final double imgSize;
  final Widget? widgetButton;
  final String videoUrl;

  const ConsultantShortInfo({
    Key? key,
    required this.img,
    required this.name,
    required this.specialty,
    required this.year,
    required this.rating,
    required this.imgSize,
    this.widgetButton,
    required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            //consultant picture
            Container(
                width: imgSize,
                height: imgSize,
                decoration: BoxDecoration(
                  color: UIColor.chetwodeBlue.withOpacity(.15),
                  border: Border.all(
                      color: UIColor.chetwodeBlue.withOpacity(.15), width: 1),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: FadeInImage(
                    image: NetworkImage(img),
                    placeholder: AssetImage(UIPath.spinnerGif),
                    fit: BoxFit.cover,
                    placeholderErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(UIPath.placeholderProfile);
                    },
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(UIPath.placeholderProfile);
                    },
                    width: imgSize,
                    height: imgSize,
                  ),
                )),
            //play consultant video button
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: videoUrl.isNotEmpty
                      ? () {
                          vimeoUrl = videoUrl;
                          Get.to(() => const ViewPlayVimeoVideo());
                        }
                      : null,
                  child: SvgPicture.asset(
                    UIPath.playVideo,
                    width: imgSize / 4,
                    height: imgSize / 4,
                  ),
                ))
          ],
        ),
        const SizedBox(height: 4),
        //consultant name
        TextBasic(
          text: name,
          fontSize: 28,
        ),
        //consultant profession
        TextBasic(
          text: specialty,
          color: UIColor.tuna.withOpacity(.6),
          fontSize: 17,
        ),
        if (widgetButton != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: widgetButton!,
          ),
        // getRatingBar(),
      ],
    );
  }

  Widget getRatingBar() {
    return Column(
      children: [
        Divider(color: UIColor.tuna.withOpacity(.38), height: 20),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextBasic(
                    text: year,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  TextBasic(
                    text: UIText.meetConsultantExperience,
                    color: UIColor.tuna.withOpacity(.6),
                    fontSize: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 46,
                child: VerticalDivider(
                  color: UIColor.tuna.withOpacity(.6),
                )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextBasic(
                    text: rating.toString(),
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  StarRating(rating: 3.5, color: UIColor.tuna.withOpacity(.6))
                ],
              ),
            ),
          ],
        ),
        Divider(color: UIColor.tuna.withOpacity(.38), height: 20),
      ],
    );
  }
}
