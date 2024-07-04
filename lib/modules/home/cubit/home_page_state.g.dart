// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageState _$HomePageStateFromJson(Map<String, dynamic> json) =>
    HomePageState(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => BarcodeItem.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$HomePageStateToJson(HomePageState instance) =>
    <String, dynamic>{
      'items': instance.items.toList(),
    };
