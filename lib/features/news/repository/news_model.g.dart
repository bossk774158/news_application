// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsModelAdapter extends TypeAdapter<NewsModel> {
  @override
  final int typeId = 1;

  @override
  NewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsModel(
      articleId: fields[0] as String,
      title: fields[1] as String,
      link: fields[2] as String,
      keywords: (fields[3] as List?)?.cast<String>(),
      creator: (fields[4] as List?)?.cast<String>(),
      videoUrl: fields[5] as String?,
      description: fields[6] as String,
      content: fields[7] as String,
      pubDate: fields[8] as DateTime,
      imageUrl: fields[9] as String?,
      sourceId: fields[10] as String?,
      sourceName: fields[11] as String?,
      sourceUrl: fields[12] as String?,
      sourcePriority: fields[13] as int?,
      sourceIcon: fields[14] as String?,
      language: fields[15] as String,
      country: (fields[16] as List).cast<String>(),
      category: (fields[17] as List).cast<String>(),
      duplicate: fields[18] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NewsModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.articleId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.keywords)
      ..writeByte(4)
      ..write(obj.creator)
      ..writeByte(5)
      ..write(obj.videoUrl)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.content)
      ..writeByte(8)
      ..write(obj.pubDate)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.sourceId)
      ..writeByte(11)
      ..write(obj.sourceName)
      ..writeByte(12)
      ..write(obj.sourceUrl)
      ..writeByte(13)
      ..write(obj.sourcePriority)
      ..writeByte(14)
      ..write(obj.sourceIcon)
      ..writeByte(15)
      ..write(obj.language)
      ..writeByte(16)
      ..write(obj.country)
      ..writeByte(17)
      ..write(obj.category)
      ..writeByte(18)
      ..write(obj.duplicate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
