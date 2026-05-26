// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'genui_agent.dart';

class GenuiAgentMapper extends ClassMapperBase<GenuiAgent> {
  GenuiAgentMapper._();

  static GenuiAgentMapper? _instance;
  static GenuiAgentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenuiAgentMapper._());
      AgentThemeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GenuiAgent';

  static String _$name(GenuiAgent v) => v.name;
  static const Field<GenuiAgent, String> _f$name = Field('name', _$name);
  static String _$description(GenuiAgent v) => v.description;
  static const Field<GenuiAgent, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$instructions(GenuiAgent v) => v.instructions;
  static const Field<GenuiAgent, String> _f$instructions = Field(
    'instructions',
    _$instructions,
  );
  static AgentTheme _$theme(GenuiAgent v) => v.theme;
  static const Field<GenuiAgent, AgentTheme> _f$theme = Field('theme', _$theme);
  static const Field<GenuiAgent, List<Component<dynamic>>> _f$components =
      Field('components', null, mode: FieldMode.param, opt: true);
  static const Field<GenuiAgent, List<Tool>> _f$tools = Field(
    'tools',
    null,
    mode: FieldMode.param,
    opt: true,
  );

  @override
  final MappableFields<GenuiAgent> fields = const {
    #name: _f$name,
    #description: _f$description,
    #instructions: _f$instructions,
    #theme: _f$theme,
    #components: _f$components,
    #tools: _f$tools,
  };

  static GenuiAgent _instantiate(DecodingData data) {
    return GenuiAgent(
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      instructions: data.dec(_f$instructions),
      theme: data.dec(_f$theme),
      components: data.dec(_f$components),
      tools: data.dec(_f$tools),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GenuiAgent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GenuiAgent>(map);
  }

  static GenuiAgent fromJson(String json) {
    return ensureInitialized().decodeJson<GenuiAgent>(json);
  }
}

mixin GenuiAgentMappable {
  String toJson() {
    return GenuiAgentMapper.ensureInitialized().encodeJson<GenuiAgent>(
      this as GenuiAgent,
    );
  }

  Map<String, dynamic> toMap() {
    return GenuiAgentMapper.ensureInitialized().encodeMap<GenuiAgent>(
      this as GenuiAgent,
    );
  }

  GenuiAgentCopyWith<GenuiAgent, GenuiAgent, GenuiAgent> get copyWith =>
      _GenuiAgentCopyWithImpl<GenuiAgent, GenuiAgent>(
        this as GenuiAgent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GenuiAgentMapper.ensureInitialized().stringifyValue(
      this as GenuiAgent,
    );
  }

  @override
  bool operator ==(Object other) {
    return GenuiAgentMapper.ensureInitialized().equalsValue(
      this as GenuiAgent,
      other,
    );
  }

  @override
  int get hashCode {
    return GenuiAgentMapper.ensureInitialized().hashValue(this as GenuiAgent);
  }
}

extension GenuiAgentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GenuiAgent, $Out> {
  GenuiAgentCopyWith<$R, GenuiAgent, $Out> get $asGenuiAgent =>
      $base.as((v, t, t2) => _GenuiAgentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GenuiAgentCopyWith<$R, $In extends GenuiAgent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AgentThemeCopyWith<$R, AgentTheme, AgentTheme> get theme;
  $R call({
    String? name,
    String? description,
    String? instructions,
    AgentTheme? theme,
    List<Component<dynamic>>? components,
    List<Tool>? tools,
  });
  GenuiAgentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GenuiAgentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GenuiAgent, $Out>
    implements GenuiAgentCopyWith<$R, GenuiAgent, $Out> {
  _GenuiAgentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GenuiAgent> $mapper =
      GenuiAgentMapper.ensureInitialized();
  @override
  AgentThemeCopyWith<$R, AgentTheme, AgentTheme> get theme =>
      $value.theme.copyWith.$chain((v) => call(theme: v));
  @override
  $R call({
    String? name,
    String? description,
    String? instructions,
    AgentTheme? theme,
    List<Component<dynamic>>? components,
    List<Tool>? tools,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (description != null) #description: description,
      if (instructions != null) #instructions: instructions,
      if (theme != null) #theme: theme,
      #components: components,
      #tools: tools,
    }),
  );
  @override
  GenuiAgent $make(CopyWithData data) => GenuiAgent(
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    instructions: data.get(#instructions, or: $value.instructions),
    theme: data.get(#theme, or: $value.theme),
    components: data.get(#components),
    tools: data.get(#tools),
  );

  @override
  GenuiAgentCopyWith<$R2, GenuiAgent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GenuiAgentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

