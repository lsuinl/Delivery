import 'package:flutter/material.dart';
import 'package:restaurant/common/const/colors.dart';
import 'package:restaurant/restaurant/model/restaurant_model.dart';
import 'package:restaurant/restaurant/model/restaurant_detail_model.dart';

class RestaurantCard extends StatelessWidget {
  //이미지
  final Widget image;

  //레스토랑이름
  final String name;

  //레스토랑 태그
  final List<String> tags;

  //평점 갯수
  final int ratingsCount;

  //배송시간
  final int deliveryTime;

  //배송 비용
  final int deliveryFee;

  //평균 평점
  final double ratings;

  //상세보기 페이지 여부 확인
  final bool isDetail;
  final String? Herokey;

  //상세내용
  final String? detail;

  const RestaurantCard(
      {required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      this.isDetail = false,
        this.Herokey,
      this.detail,
      Key? key})
      : super(key: key);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      Herokey: model.id,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(Herokey!=null)
        Hero(tag: ObjectKey(Herokey),
            child:
          ClipRRect(
            //이미지 깎아서 만들어요
            borderRadius: BorderRadius.circular(isDetail? 16.0:0),
            child: image,
          )),
        if(Herokey==null)
              ClipRRect(
                //이미지 깎아서 만들어요
                borderRadius: BorderRadius.circular(isDetail? 16.0:0),
                child: image,
              ),
        const SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(
                tags.join(' · '),
                style: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
              )
              //join을 통해 리스트를 분류하고 그 사잇값을 넣어줌
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _IconText(icon: Icons.star, label: ratings.toString()),
            renderDot(),
            _IconText(icon: Icons.receipt, label: ratingsCount.toString()),
            renderDot(),
            _IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime분'),
            renderDot(),
            _IconText(
                icon: Icons.monetization_on,
                label: deliveryFee == 0 ? "무료" : deliveryFee.toString()),
          ],
        ),
        if (detail != null && isDetail)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(detail!),
          )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ' · ',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({required this.icon, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: PRIMARY_COLOR, size: 14),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
