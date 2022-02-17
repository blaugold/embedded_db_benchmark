// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';

import 'objectbox_document.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 110508833524735892),
      name: 'ObjectboxDoc',
      lastPropertyId: const IdUid(23, 3961540835188943383),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2756476576729890188),
            name: 'id',
            type: 9,
            flags: 2048,
            indexId: const IdUid(2, 4984996048941082833)),
        ModelProperty(
            id: const IdUid(2, 1803984718397515963),
            name: 'index',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 456765814606734479),
            name: 'guid',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 302027292187508492),
            name: 'isActive',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1191233812433334458),
            name: 'balance',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3099099690824981750),
            name: 'picture',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7953884654089440513),
            name: 'age',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6235868881030615646),
            name: 'eyeColor',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 1167247666618880382),
            name: 'nameId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7428278450406228165),
            relationTarget: 'ObjectboxName'),
        ModelProperty(
            id: const IdUid(10, 204460225648943795),
            name: 'company',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 6946925352944923873),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 947663455830537931),
            name: 'phone',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 6518746044648241766),
            name: 'address',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 3776573471784835142),
            name: 'about',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 3496852478087686881),
            name: 'registered',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 666970885414060636),
            name: 'latitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 4312645177577161725),
            name: 'longitude',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 5799165882936424372),
            name: 'tags',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 4643702838393377346),
            name: 'greeting',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 4785659561339604838),
            name: 'favoriteFruit',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 5193248094615037014),
            name: 'dbRange',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 3961540835188943383),
            name: 'dbId',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 8804691660091051136),
            name: 'friends',
            targetId: const IdUid(3, 8278041067566766108))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 8564006045192440331),
      name: 'ObjectboxName',
      lastPropertyId: const IdUid(3, 3282042645606389258),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 9131136361258168339),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6528529618981580335),
            name: 'first',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3282042645606389258),
            name: 'last',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 8278041067566766108),
      name: 'ObjectboxFriend',
      lastPropertyId: const IdUid(2, 7815945799659295841),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 291722160156892971),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7815945799659295841),
            name: 'name',
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
      lastEntityId: const IdUid(3, 8278041067566766108),
      lastIndexId: const IdUid(2, 4984996048941082833),
      lastRelationId: const IdUid(1, 8804691660091051136),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [3886440479243237754],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    ObjectboxDoc: EntityDefinition<ObjectboxDoc>(
        model: _entities[0],
        toOneRelations: (ObjectboxDoc object) => [object.name],
        toManyRelations: (ObjectboxDoc object) =>
            {RelInfo<ObjectboxDoc>.toMany(1, object.dbId): object.friends},
        getId: (ObjectboxDoc object) => object.dbId,
        setId: (ObjectboxDoc object, int id) {
          object.dbId = id;
        },
        objectToFB: (ObjectboxDoc object, fb.Builder fbb) {
          final idOffset = fbb.writeString(object.id);
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
          final greetingOffset = fbb.writeString(object.greeting);
          final favoriteFruitOffset = fbb.writeString(object.favoriteFruit);
          final dbRangeOffset = fbb.writeList(
              object.dbRange.map(fbb.writeString).toList(growable: false));
          fbb.startTable(24);
          fbb.addOffset(0, idOffset);
          fbb.addInt64(1, object.index);
          fbb.addOffset(2, guidOffset);
          fbb.addBool(3, object.isActive);
          fbb.addOffset(4, balanceOffset);
          fbb.addOffset(5, pictureOffset);
          fbb.addInt64(6, object.age);
          fbb.addOffset(7, eyeColorOffset);
          fbb.addInt64(8, object.name.targetId);
          fbb.addOffset(9, companyOffset);
          fbb.addOffset(10, emailOffset);
          fbb.addOffset(11, phoneOffset);
          fbb.addOffset(12, addressOffset);
          fbb.addOffset(13, aboutOffset);
          fbb.addOffset(14, registeredOffset);
          fbb.addOffset(15, latitudeOffset);
          fbb.addOffset(16, longitudeOffset);
          fbb.addOffset(17, tagsOffset);
          fbb.addOffset(18, greetingOffset);
          fbb.addOffset(19, favoriteFruitOffset);
          fbb.addOffset(21, dbRangeOffset);
          fbb.addInt64(22, object.dbId);
          fbb.finish(fbb.endTable());
          return object.dbId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxDoc(
              dbId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 48, 0),
              id: const fb.StringReader().vTableGet(buffer, rootOffset, 4, ''),
              index: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              guid:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              isActive: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false),
              balance:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              picture:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 14, ''),
              age: const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0),
              eyeColor:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 18, ''),
              company:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 22, ''),
              email:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 24, ''),
              phone:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 26, ''),
              address:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 28, ''),
              about:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 30, ''),
              registered:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 32, ''),
              latitude:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 34, ''),
              longitude:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 36, ''),
              tags: const fb.ListReader<String>(fb.StringReader(), lazy: false)
                  .vTableGet(buffer, rootOffset, 38, []),
              dbRange:
                  const fb.ListReader<String>(fb.StringReader(), lazy: false)
                      .vTableGet(buffer, rootOffset, 46, []),
              greeting:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 40, ''),
              favoriteFruit: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 42, ''));
          object.name.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.name.attach(store);
          InternalToManyAccess.setRelInfo(
              object.friends,
              store,
              RelInfo<ObjectboxDoc>.toMany(1, object.dbId),
              store.box<ObjectboxDoc>());
          return object;
        }),
    ObjectboxName: EntityDefinition<ObjectboxName>(
        model: _entities[1],
        toOneRelations: (ObjectboxName object) => [],
        toManyRelations: (ObjectboxName object) => {},
        getId: (ObjectboxName object) => object.id,
        setId: (ObjectboxName object, int id) {
          object.id = id;
        },
        objectToFB: (ObjectboxName object, fb.Builder fbb) {
          final firstOffset = fbb.writeString(object.first);
          final lastOffset = fbb.writeString(object.last);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, firstOffset);
          fbb.addOffset(2, lastOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxName(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              first:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              last:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    ObjectboxFriend: EntityDefinition<ObjectboxFriend>(
        model: _entities[2],
        toOneRelations: (ObjectboxFriend object) => [],
        toManyRelations: (ObjectboxFriend object) => {},
        getId: (ObjectboxFriend object) => object.id,
        setId: (ObjectboxFriend object, int id) {
          object.id = id;
        },
        objectToFB: (ObjectboxFriend object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ObjectboxFriend(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [ObjectboxDoc] entity fields to define ObjectBox queries.
class ObjectboxDoc_ {
  /// see [ObjectboxDoc.id]
  static final id =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[0]);

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

  /// see [ObjectboxDoc.name]
  static final name = QueryRelationToOne<ObjectboxDoc, ObjectboxName>(
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

  /// see [ObjectboxDoc.greeting]
  static final greeting =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[18]);

  /// see [ObjectboxDoc.favoriteFruit]
  static final favoriteFruit =
      QueryStringProperty<ObjectboxDoc>(_entities[0].properties[19]);

  /// see [ObjectboxDoc.dbRange]
  static final dbRange =
      QueryStringVectorProperty<ObjectboxDoc>(_entities[0].properties[20]);

  /// see [ObjectboxDoc.dbId]
  static final dbId =
      QueryIntegerProperty<ObjectboxDoc>(_entities[0].properties[21]);

  /// see [ObjectboxDoc.friends]
  static final friends = QueryRelationToMany<ObjectboxDoc, ObjectboxFriend>(
      _entities[0].relations[0]);
}

/// [ObjectboxName] entity fields to define ObjectBox queries.
class ObjectboxName_ {
  /// see [ObjectboxName.id]
  static final id =
      QueryIntegerProperty<ObjectboxName>(_entities[1].properties[0]);

  /// see [ObjectboxName.first]
  static final first =
      QueryStringProperty<ObjectboxName>(_entities[1].properties[1]);

  /// see [ObjectboxName.last]
  static final last =
      QueryStringProperty<ObjectboxName>(_entities[1].properties[2]);
}

/// [ObjectboxFriend] entity fields to define ObjectBox queries.
class ObjectboxFriend_ {
  /// see [ObjectboxFriend.id]
  static final id =
      QueryIntegerProperty<ObjectboxFriend>(_entities[2].properties[0]);

  /// see [ObjectboxFriend.name]
  static final name =
      QueryStringProperty<ObjectboxFriend>(_entities[2].properties[1]);
}
