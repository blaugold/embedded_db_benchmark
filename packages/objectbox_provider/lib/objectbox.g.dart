// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'src/objectbox_document.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5975479730380645645),
      name: 'ObjectboxDoc',
      lastPropertyId: const IdUid(21, 8425542009147428868),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9071115106028723042),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8147067031482888355),
            name: 'index',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7400733012204376347),
            name: 'guid',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 882296990772912154),
            name: 'isActive',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1856879421160937355),
            name: 'balance',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 1216337852447169512),
            name: 'picture',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7602799951283092054),
            name: 'age',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 2506288877467910564),
            name: 'eyeColor',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7156934374478972818),
            name: 'obxNameId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 2922724101490916872),
            relationTarget: 'ObjectboxName'),
        ModelProperty(
            id: const IdUid(10, 5036475251230873139),
            name: 'company',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 5200013480694212432),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 3225140679890968316),
            name: 'phone',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 9080567143972325731),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 4183651052807564409),
            name: 'about',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 4820844337013479071),
            name: 'registered',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 2169977252191127612),
            name: 'latitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 7365893667725084580),
            name: 'longitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 8801537517580732069),
            name: 'tags',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 1857545187715544561),
            name: 'dbRange',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 3248557202536651004),
            name: 'greeting',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 8425542009147428868),
            name: 'favoriteFruit',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 963584562680433028),
            name: 'obxFriends',
            targetId: const IdUid(2, 4199569690113202764))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 4199569690113202764),
      name: 'ObjectboxFriend',
      lastPropertyId: const IdUid(3, 6250350875566240112),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 316313569599393634),
            name: 'dbId',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6809741144950909301),
            name: 'id',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6250350875566240112),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 8718784461707806829),
      name: 'ObjectboxName',
      lastPropertyId: const IdUid(3, 62858941369991929),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 166415314088832355),
            name: 'dbId',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2767922558854450455),
            name: 'first',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 62858941369991929),
            name: 'last',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Store openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) =>
    Store(getObjectBoxModel(),
        directory: directory,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 8718784461707806829),
      lastIndexId: const IdUid(1, 2922724101490916872),
      lastRelationId: const IdUid(1, 963584562680433028),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ObjectboxDoc: EntityDefinition<ObjectboxDoc>(
        model: _entities[0],
        toOneRelations: (ObjectboxDoc object) => [object.obxName],
        toManyRelations: (ObjectboxDoc object) =>
            {RelInfo<ObjectboxDoc>.toMany(1, object.id): object.obxFriends},
        getId: (ObjectboxDoc object) => object.id,
        setId: (ObjectboxDoc object, int id) {
          object.id = id;
        },
        objectToFB: (ObjectboxDoc object, fb.Builder fbb) {
          final guidOffset = fbb.writeString(object.guid);
          final balanceOffset = fbb.writeString(object.balance);
          final pictureOffset = fbb.writeString(object.picture);
          final eyeColorOffset = fbb.writeString(object.eyeColor);
          final companyOffset = fbb.writeString(object.company);
          final emailOffset = fbb.writeString(object.email);
          final phoneOffset = fbb.writeString(object.phone);
          final addressOffset = fbb.writeString(object.address);
          final aboutOffset = fbb.writeString(object.about);
          final registeredOffset = fbb.writeString(object.registered);
          final latitudeOffset = fbb.writeString(object.latitude);
          final longitudeOffset = fbb.writeString(object.longitude);
          final tagsOffset = fbb.writeList(
              object.tags.map(fbb.writeString).toList(growable: false));
          final dbRangeOffset = fbb.writeList(
              object.dbRange.map(fbb.writeString).toList(growable: false));
          final greetingOffset = fbb.writeString(object.greeting);
          final favoriteFruitOffset = fbb.writeString(object.favoriteFruit);
          fbb.startTable(22);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.index);
          fbb.addOffset(2, guidOffset);
          fbb.addBool(3, object.isActive);
          fbb.addOffset(4, balanceOffset);
          fbb.addOffset(5, pictureOffset);
          fbb.addInt64(6, object.age);
          fbb.addOffset(7, eyeColorOffset);
          fbb.addInt64(8, object.obxName.targetId);
          fbb.addOffset(9, companyOffset);
          fbb.addOffset(10, emailOffset);
          fbb.addOffset(11, phoneOffset);
          fbb.addOffset(12, addressOffset);
          fbb.addOffset(13, aboutOffset);
          fbb.addOffset(14, registeredOffset);
          fbb.addOffset(15, latitudeOffset);
          fbb.addOffset(16, longitudeOffset);
          fbb.addOffset(17, tagsOffset);
          fbb.addOffset(18, dbRangeOffset);
          fbb.addOffset(19, greetingOffset);
          fbb.addOffset(20, favoriteFruitOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxDoc(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              index: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              guid: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              isActive: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false),
              balance: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''),
              picture: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              age: const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0),
              eyeColor: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 18, ''),
              company: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 22, ''),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 24, ''),
              phone: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 26, ''),
              address:
                  const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 28, ''),
              about: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 30, ''),
              registered: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 32, ''),
              latitude: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 34, ''),
              longitude: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 36, ''),
              tags: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGet(buffer, rootOffset, 38, []),
              dbRange: const fb.ListReader<String>(fb.StringReader(asciiOptimization: true), lazy: false).vTableGet(buffer, rootOffset, 40, []),
              greeting: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 42, ''),
              favoriteFruit: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 44, ''));
          object.obxName.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.obxName.attach(store);
          InternalToManyAccess.setRelInfo<ObjectboxDoc>(object.obxFriends,
              store, RelInfo<ObjectboxDoc>.toMany(1, object.id));
          return object;
        }),
    ObjectboxFriend: EntityDefinition<ObjectboxFriend>(
        model: _entities[1],
        toOneRelations: (ObjectboxFriend object) => [],
        toManyRelations: (ObjectboxFriend object) => {},
        getId: (ObjectboxFriend object) => object.dbId,
        setId: (ObjectboxFriend object, int id) {
          object.dbId = id;
        },
        objectToFB: (ObjectboxFriend object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(4);
          fbb.addInt64(0, object.dbId);
          fbb.addInt64(1, object.id);
          fbb.addOffset(2, nameOffset);
          fbb.finish(fbb.endTable());
          return object.dbId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxFriend(
              dbId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    ObjectboxName: EntityDefinition<ObjectboxName>(
        model: _entities[2],
        toOneRelations: (ObjectboxName object) => [],
        toManyRelations: (ObjectboxName object) => {},
        getId: (ObjectboxName object) => object.dbId,
        setId: (ObjectboxName object, int id) {
          object.dbId = id;
        },
        objectToFB: (ObjectboxName object, fb.Builder fbb) {
          final firstOffset = fbb.writeString(object.first);
          final lastOffset = fbb.writeString(object.last);
          fbb.startTable(4);
          fbb.addInt64(0, object.dbId);
          fbb.addOffset(1, firstOffset);
          fbb.addOffset(2, lastOffset);
          fbb.finish(fbb.endTable());
          return object.dbId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxName(
              dbId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              first: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              last: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ObjectboxDoc] entity fields to define ObjectBox queries.
class ObjectboxDoc_ {
  /// see [ObjectboxDoc.id]
  static final id =
      QueryIntegerProperty<ObjectboxDoc>(_entities[0].properties[0]);

  /// see [ObjectboxDoc.index]
  static final index =
      QueryIntegerProperty<ObjectboxDoc>(_entities[0].properties[1]);

  /// see [ObjectboxDoc.guid]
  static final guid =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[2]);

  /// see [ObjectboxDoc.isActive]
  static final isActive =
      QueryBooleanProperty<ObjectboxDoc>(_entities[0].properties[3]);

  /// see [ObjectboxDoc.balance]
  static final balance =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[4]);

  /// see [ObjectboxDoc.picture]
  static final picture =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[5]);

  /// see [ObjectboxDoc.age]
  static final age =
      QueryIntegerProperty<ObjectboxDoc>(_entities[0].properties[6]);

  /// see [ObjectboxDoc.eyeColor]
  static final eyeColor =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[7]);

  /// see [ObjectboxDoc.obxName]
  static final obxName = QueryRelationToOne<ObjectboxDoc, ObjectboxName>(
      _entities[0].properties[8]);

  /// see [ObjectboxDoc.company]
  static final company =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[9]);

  /// see [ObjectboxDoc.email]
  static final email =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[10]);

  /// see [ObjectboxDoc.phone]
  static final phone =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[11]);

  /// see [ObjectboxDoc.address]
  static final address =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[12]);

  /// see [ObjectboxDoc.about]
  static final about =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[13]);

  /// see [ObjectboxDoc.registered]
  static final registered =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[14]);

  /// see [ObjectboxDoc.latitude]
  static final latitude =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[15]);

  /// see [ObjectboxDoc.longitude]
  static final longitude =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[16]);

  /// see [ObjectboxDoc.tags]
  static final tags =
      QueryStringVectorProperty<ObjectboxDoc>(_entities[0].properties[17]);

  /// see [ObjectboxDoc.dbRange]
  static final dbRange =
      QueryStringVectorProperty<ObjectboxDoc>(_entities[0].properties[18]);

  /// see [ObjectboxDoc.greeting]
  static final greeting =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[19]);

  /// see [ObjectboxDoc.favoriteFruit]
  static final favoriteFruit =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[20]);

  /// see [ObjectboxDoc.obxFriends]
  static final obxFriends = QueryRelationToMany<ObjectboxDoc, ObjectboxFriend>(
      _entities[0].relations[0]);
}

/// [ObjectboxFriend] entity fields to define ObjectBox queries.
class ObjectboxFriend_ {
  /// see [ObjectboxFriend.dbId]
  static final dbId =
      QueryIntegerProperty<ObjectboxFriend>(_entities[1].properties[0]);

  /// see [ObjectboxFriend.id]
  static final id =
      QueryIntegerProperty<ObjectboxFriend>(_entities[1].properties[1]);

  /// see [ObjectboxFriend.name]
  static final name =
      QueryStringProperty<ObjectboxFriend>(_entities[1].properties[2]);
}

/// [ObjectboxName] entity fields to define ObjectBox queries.
class ObjectboxName_ {
  /// see [ObjectboxName.dbId]
  static final dbId =
      QueryIntegerProperty<ObjectboxName>(_entities[2].properties[0]);

  /// see [ObjectboxName.first]
  static final first =
      QueryStringProperty<ObjectboxName>(_entities[2].properties[1]);

  /// see [ObjectboxName.last]
  static final last =
      QueryStringProperty<ObjectboxName>(_entities[2].properties[2]);
}
