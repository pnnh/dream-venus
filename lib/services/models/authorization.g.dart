// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorization.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetAuthorizationCollection on Isar {
  IsarCollection<Authorization> get authorizations => getCollection();
}

const AuthorizationSchema = CollectionSchema(
  name: 'Authorization',
  schema:
      '{"name":"Authorization","idName":"id","properties":[{"name":"accessToken","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'accessToken': 0},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _authorizationGetId,
  setId: _authorizationSetId,
  getLinks: _authorizationGetLinks,
  attachLinks: _authorizationAttachLinks,
  serializeNative: _authorizationSerializeNative,
  deserializeNative: _authorizationDeserializeNative,
  deserializePropNative: _authorizationDeserializePropNative,
  serializeWeb: _authorizationSerializeWeb,
  deserializeWeb: _authorizationDeserializeWeb,
  deserializePropWeb: _authorizationDeserializePropWeb,
  version: 3,
);

int? _authorizationGetId(Authorization object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _authorizationSetId(Authorization object, int id) {
  object.id = id;
}

List<IsarLinkBase> _authorizationGetLinks(Authorization object) {
  return [];
}

void _authorizationSerializeNative(
    IsarCollection<Authorization> collection,
    IsarRawObject rawObj,
    Authorization object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.accessToken;
  final _accessToken = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_accessToken.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _accessToken);
}

Authorization _authorizationDeserializeNative(
    IsarCollection<Authorization> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = Authorization();
  object.accessToken = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _authorizationDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _authorizationSerializeWeb(
    IsarCollection<Authorization> collection, Authorization object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'accessToken', object.accessToken);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  return jsObj;
}

Authorization _authorizationDeserializeWeb(
    IsarCollection<Authorization> collection, dynamic jsObj) {
  final object = Authorization();
  object.accessToken = IsarNative.jsObjectGet(jsObj, 'accessToken') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  return object;
}

P _authorizationDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'accessToken':
      return (IsarNative.jsObjectGet(jsObj, 'accessToken') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _authorizationAttachLinks(
    IsarCollection col, int id, Authorization object) {}

extension AuthorizationQueryWhereSort
    on QueryBuilder<Authorization, Authorization, QWhere> {
  QueryBuilder<Authorization, Authorization, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension AuthorizationQueryWhere
    on QueryBuilder<Authorization, Authorization, QWhereClause> {
  QueryBuilder<Authorization, Authorization, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Authorization, Authorization, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Authorization, Authorization, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Authorization, Authorization, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension AuthorizationQueryFilter
    on QueryBuilder<Authorization, Authorization, QFilterCondition> {
  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'accessToken',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'accessToken',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      accessTokenMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'accessToken',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Authorization, Authorization, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension AuthorizationQueryLinks
    on QueryBuilder<Authorization, Authorization, QFilterCondition> {}

extension AuthorizationQueryWhereSortBy
    on QueryBuilder<Authorization, Authorization, QSortBy> {
  QueryBuilder<Authorization, Authorization, QAfterSortBy> sortByAccessToken() {
    return addSortByInternal('accessToken', Sort.asc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy>
      sortByAccessTokenDesc() {
    return addSortByInternal('accessToken', Sort.desc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension AuthorizationQueryWhereSortThenBy
    on QueryBuilder<Authorization, Authorization, QSortThenBy> {
  QueryBuilder<Authorization, Authorization, QAfterSortBy> thenByAccessToken() {
    return addSortByInternal('accessToken', Sort.asc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy>
      thenByAccessTokenDesc() {
    return addSortByInternal('accessToken', Sort.desc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Authorization, Authorization, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension AuthorizationQueryWhereDistinct
    on QueryBuilder<Authorization, Authorization, QDistinct> {
  QueryBuilder<Authorization, Authorization, QDistinct> distinctByAccessToken(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('accessToken', caseSensitive: caseSensitive);
  }

  QueryBuilder<Authorization, Authorization, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }
}

extension AuthorizationQueryProperty
    on QueryBuilder<Authorization, Authorization, QQueryProperty> {
  QueryBuilder<Authorization, String, QQueryOperations> accessTokenProperty() {
    return addPropertyNameInternal('accessToken');
  }

  QueryBuilder<Authorization, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
