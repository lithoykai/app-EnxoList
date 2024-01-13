// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map json) => ProductModel(
      name: json['name'] as String,
      wasBought: json['wasBought'] as bool,
      price: (json['price'] as num).toDouble(),
      idCategory: json['idCategory'] as int,
      id: json['id'] as String?,
      image: json['image'] as String?,
      urlLink: json['urlLink'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'wasBought': instance.wasBought,
      'price': instance.price,
      'idCategory': instance.idCategory,
      'urlLink': instance.urlLink,
      'image': instance.image,
    };
