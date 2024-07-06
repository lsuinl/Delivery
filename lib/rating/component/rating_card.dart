import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:collection/collection.dart'; //map에서 인덱스도 보는 방법

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage; //네트워크이미지, 에셋이미지,circleavatar
  final List<Image> images; //, f리스트로 위젯 이미지를 보여줄 때
  final int rating; //별점
  final String email; //이메일
  final String content; //리뷰내용

  const RatingCard(
      {required this.avatarImage,
      required this.images,
      required this.rating,
      required this.email,
      required this.content,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(avaterImage: avatarImage, rating: rating, email: email),
        const SizedBox(height: 8.0),
        _Body(content: content),
       if(images.length>0)
        SizedBox(
          height: 100,
          child:
        _Images(
          images: images,
        ))
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avaterImage;
  final int rating;
  final String email;

  const _Header(
      {required this.avaterImage,
      required this.rating,
      required this.email,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avaterImage,
          radius: 12.0,
        ),
        const SizedBox(width: 8.0),
        Expanded(
            child: Text(email,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500))),
        ...List.generate(
            5,
            (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border_outlined,
                  color: PRIMARY_COLOR,
                ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //텍스트가 넘치면 다음줄로 넘어가게해준다 이 Flexible가
      Flexible(
        child: Text(
          content,
          style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
        ),
      )
    ]);
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: images
            .mapIndexed((index, e) => Padding(
                //마지막 인덱스의 사진에는 패딩을 넣지 않음
                padding:
                    EdgeInsets.only(right: index == images.length - 1 ? 0 : 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: e,
                )))
            .toList());
  }
}
