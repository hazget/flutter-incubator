import 'dart:convert';
import 'package:yaml/yaml.dart';
import 'dart:io';

class Request {
  late String type;
  late Stream stream;
  late List<Gift> gifts;
  late Debug debug;

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    stream = Stream.fromJson(json['stream']);
    gifts = List<Gift>.from(json['gifts'].map((x) => Gift.fromJson(x)));
    debug = Debug.fromJson(json['debug']);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'stream': stream.toJson(),
      'gifts': List<dynamic>.from(gifts.map((x) => x.toJson())),
      'debug': debug.toJson(),
    };
  }

  String toYaml() {
    final yamlMap = toYamlMap();
    final jsonString = json.encode(yamlMap);
    final yamlString = loadYaml(jsonString).toString();
    return yamlString;
  }

  String toToml() {
    final tomlString = '''
[type]
type = "$type"

[stream]
userId = "${stream.userId}"
isPrivate = ${stream.isPrivate}
settings = ${stream.settings}
shardUrl = "${stream.shardUrl}"

[stream.public_tariff]
id = ${stream.publicTariff.id}
price = ${stream.publicTariff.price}
duration = "${stream.publicTariff.duration}"
description = "${stream.publicTariff.description}"

[stream.private_tariff]
clientPrice = ${stream.privateTariff.clientPrice}
duration = "${stream.privateTariff.duration}"
description = "${stream.privateTariff.description}"

[gifts]
${_generateGiftsToml()}

[debug]
duration = "${debug.duration}"
at = "${debug.at}"
''';
    return tomlString;
  }

  YamlMap toYamlMap() {
    final jsonMap = toJson();
    final jsonString = json.encode(jsonMap);
    final yamlMap = loadYaml(jsonString);
    return YamlMap.wrap(yamlMap);
  }

  String _generateGiftsToml() {
    final buffer = StringBuffer();
    for (var gift in gifts) {
      buffer.writeln('[[gifts]]');
      buffer.writeln('id = ${gift.id}');
      buffer.writeln('price = ${gift.price}');
      buffer.writeln('description = "${gift.description}"');
    }
    return buffer.toString();
  }
}

class Stream {
  late String userId;
  late bool isPrivate;
  late int settings;
  late String shardUrl;
  late PublicTariff publicTariff;
  late PrivateTariff privateTariff;

  Stream.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    isPrivate = json['is_private'];
    settings = json['settings'];
    shardUrl = json['shard_url'];
    publicTariff = PublicTariff.fromJson(json['public_tariff']);
    privateTariff = PrivateTariff.fromJson(json['private_tariff']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'is_private': isPrivate,
      'settings': settings,
      'shard_url': shardUrl,
      'public_tariff': publicTariff.toJson(),
      'private_tariff': privateTariff.toJson(),
    };
  }
}

class PublicTariff {
  late int id;
  late int price;
  late String duration;
  late String description;

  PublicTariff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'duration': duration,
      'description': description,
    };
  }
}

class PrivateTariff {
  late int clientPrice;
  late String duration;
  late String description;

  PrivateTariff.fromJson(Map<String, dynamic> json) {
    clientPrice = json['client_price'];
    duration = json['duration'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'client_price': clientPrice,
      'duration': duration,
      'description': description,
    };
  }
}

class Gift {
  late int id;
  late int price;
  late String description;

  Gift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'description': description,
    };
  }
}

class Debug {
  late String duration;
  late String at;

  Debug.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'duration': duration,
      'at': at,
    };
  }
}

void main() {
  final file = File('request.json');
  final jsonString = file.readAsStringSync();
  final jsonMap = json.decode(jsonString);
  final request = Request.fromJson(jsonMap);
  final yamlString = request.toYaml();
  final tomlString = request.toToml();
  print('YAML:');
  print(yamlString);
  print('TOML:');
  print(tomlString);
}
