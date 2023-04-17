// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetPatientCollection on Isar {
  IsarCollection<Patient> get patients => this.collection();
}

const PatientSchema = CollectionSchema(
  name: r'Patient',
  id: -3057427754190339924,
  properties: {
    r'habilitado': PropertySchema(
      id: 0,
      name: r'habilitado',
      type: IsarType.bool,
    ),
    r'idade': PropertySchema(
      id: 1,
      name: r'idade',
      type: IsarType.long,
    ),
    r'nome': PropertySchema(
      id: 2,
      name: r'nome',
      type: IsarType.string,
    )
  },
  estimateSize: _patientEstimateSize,
  serialize: _patientSerialize,
  deserialize: _patientDeserialize,
  deserializeProp: _patientDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _patientGetId,
  getLinks: _patientGetLinks,
  attach: _patientAttach,
  version: '3.0.5',
);

int _patientEstimateSize(
  Patient object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _patientSerialize(
  Patient object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.habilitado);
  writer.writeLong(offsets[1], object.idade);
  writer.writeString(offsets[2], object.nome);
}

Patient _patientDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Patient(
    reader.readString(offsets[2]),
    reader.readLong(offsets[1]),
    reader.readBool(offsets[0]),
  );
  object.id = id;
  return object;
}

P _patientDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _patientGetId(Patient object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _patientGetLinks(Patient object) {
  return [];
}

void _patientAttach(IsarCollection<dynamic> col, Id id, Patient object) {
  object.id = id;
}

extension PatientQueryWhereSort on QueryBuilder<Patient, Patient, QWhere> {
  QueryBuilder<Patient, Patient, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PatientQueryWhere on QueryBuilder<Patient, Patient, QWhereClause> {
  QueryBuilder<Patient, Patient, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Patient, Patient, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Patient, Patient, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Patient, Patient, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PatientQueryFilter
    on QueryBuilder<Patient, Patient, QFilterCondition> {
  QueryBuilder<Patient, Patient, QAfterFilterCondition> habilitadoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habilitado',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idadeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idade',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idadeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idade',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idadeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idade',
        value: value,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> idadeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idade',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<Patient, Patient, QAfterFilterCondition> nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }
}

extension PatientQueryObject
    on QueryBuilder<Patient, Patient, QFilterCondition> {}

extension PatientQueryLinks
    on QueryBuilder<Patient, Patient, QFilterCondition> {}

extension PatientQuerySortBy on QueryBuilder<Patient, Patient, QSortBy> {
  QueryBuilder<Patient, Patient, QAfterSortBy> sortByHabilitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habilitado', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> sortByHabilitadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habilitado', Sort.desc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> sortByIdade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idade', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> sortByIdadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idade', Sort.desc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension PatientQuerySortThenBy
    on QueryBuilder<Patient, Patient, QSortThenBy> {
  QueryBuilder<Patient, Patient, QAfterSortBy> thenByHabilitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habilitado', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByHabilitadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habilitado', Sort.desc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByIdade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idade', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByIdadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idade', Sort.desc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<Patient, Patient, QAfterSortBy> thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }
}

extension PatientQueryWhereDistinct
    on QueryBuilder<Patient, Patient, QDistinct> {
  QueryBuilder<Patient, Patient, QDistinct> distinctByHabilitado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habilitado');
    });
  }

  QueryBuilder<Patient, Patient, QDistinct> distinctByIdade() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idade');
    });
  }

  QueryBuilder<Patient, Patient, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }
}

extension PatientQueryProperty
    on QueryBuilder<Patient, Patient, QQueryProperty> {
  QueryBuilder<Patient, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Patient, bool, QQueryOperations> habilitadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habilitado');
    });
  }

  QueryBuilder<Patient, int, QQueryOperations> idadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idade');
    });
  }

  QueryBuilder<Patient, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }
}
