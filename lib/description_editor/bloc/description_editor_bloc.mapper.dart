// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'description_editor_bloc.dart';

class DescriptionEditorStateMapper
    extends ClassMapperBase<DescriptionEditorState> {
  DescriptionEditorStateMapper._();

  static DescriptionEditorStateMapper? _instance;
  static DescriptionEditorStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DescriptionEditorStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DescriptionEditorState';

  static String _$name(DescriptionEditorState v) => v.name;
  static const Field<DescriptionEditorState, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
    def: '',
  );
  static String _$description(DescriptionEditorState v) => v.description;
  static const Field<DescriptionEditorState, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
    def: '',
  );
  static String _$instructions(DescriptionEditorState v) => v.instructions;
  static const Field<DescriptionEditorState, String> _f$instructions = Field(
    'instructions',
    _$instructions,
    opt: true,
    def: '',
  );

  @override
  final MappableFields<DescriptionEditorState> fields = const {
    #name: _f$name,
    #description: _f$description,
    #instructions: _f$instructions,
  };

  static DescriptionEditorState _instantiate(DecodingData data) {
    return DescriptionEditorState(
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      instructions: data.dec(_f$instructions),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DescriptionEditorState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DescriptionEditorState>(map);
  }

  static DescriptionEditorState fromJson(String json) {
    return ensureInitialized().decodeJson<DescriptionEditorState>(json);
  }
}

mixin DescriptionEditorStateMappable {
  String toJson() {
    return DescriptionEditorStateMapper.ensureInitialized()
        .encodeJson<DescriptionEditorState>(this as DescriptionEditorState);
  }

  Map<String, dynamic> toMap() {
    return DescriptionEditorStateMapper.ensureInitialized()
        .encodeMap<DescriptionEditorState>(this as DescriptionEditorState);
  }

  DescriptionEditorStateCopyWith<
    DescriptionEditorState,
    DescriptionEditorState,
    DescriptionEditorState
  >
  get copyWith =>
      _DescriptionEditorStateCopyWithImpl<
        DescriptionEditorState,
        DescriptionEditorState
      >(this as DescriptionEditorState, $identity, $identity);
  @override
  String toString() {
    return DescriptionEditorStateMapper.ensureInitialized().stringifyValue(
      this as DescriptionEditorState,
    );
  }

  @override
  bool operator ==(Object other) {
    return DescriptionEditorStateMapper.ensureInitialized().equalsValue(
      this as DescriptionEditorState,
      other,
    );
  }

  @override
  int get hashCode {
    return DescriptionEditorStateMapper.ensureInitialized().hashValue(
      this as DescriptionEditorState,
    );
  }
}

extension DescriptionEditorStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DescriptionEditorState, $Out> {
  DescriptionEditorStateCopyWith<$R, DescriptionEditorState, $Out>
  get $asDescriptionEditorState => $base.as(
    (v, t, t2) => _DescriptionEditorStateCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class DescriptionEditorStateCopyWith<
  $R,
  $In extends DescriptionEditorState,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? description, String? instructions});
  DescriptionEditorStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DescriptionEditorStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DescriptionEditorState, $Out>
    implements
        DescriptionEditorStateCopyWith<$R, DescriptionEditorState, $Out> {
  _DescriptionEditorStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DescriptionEditorState> $mapper =
      DescriptionEditorStateMapper.ensureInitialized();
  @override
  $R call({String? name, String? description, String? instructions}) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (instructions != null) #instructions: instructions,
    }),
  );
  @override
  DescriptionEditorState $make(CopyWithData data) => DescriptionEditorState(
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    instructions: data.get(#instructions, or: $value.instructions),
  );

  @override
  DescriptionEditorStateCopyWith<$R2, DescriptionEditorState, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _DescriptionEditorStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

