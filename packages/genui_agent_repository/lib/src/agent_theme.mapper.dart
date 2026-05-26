// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'agent_theme.dart';

class AgentThemeMapper extends ClassMapperBase<AgentTheme> {
  AgentThemeMapper._();

  static AgentThemeMapper? _instance;
  static AgentThemeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AgentThemeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AgentTheme';

  static int _$primaryArgb(AgentTheme v) => v.primaryArgb;
  static const Field<AgentTheme, int> _f$primaryArgb = Field(
    'primaryArgb',
    _$primaryArgb,
  );
  static int _$onPrimaryArgb(AgentTheme v) => v.onPrimaryArgb;
  static const Field<AgentTheme, int> _f$onPrimaryArgb = Field(
    'onPrimaryArgb',
    _$onPrimaryArgb,
  );
  static int _$backgroundArgb(AgentTheme v) => v.backgroundArgb;
  static const Field<AgentTheme, int> _f$backgroundArgb = Field(
    'backgroundArgb',
    _$backgroundArgb,
  );
  static int _$onBackgroundArgb(AgentTheme v) => v.onBackgroundArgb;
  static const Field<AgentTheme, int> _f$onBackgroundArgb = Field(
    'onBackgroundArgb',
    _$onBackgroundArgb,
  );
  static int _$accentArgb(AgentTheme v) => v.accentArgb;
  static const Field<AgentTheme, int> _f$accentArgb = Field(
    'accentArgb',
    _$accentArgb,
  );
  static int _$onAccentArgb(AgentTheme v) => v.onAccentArgb;
  static const Field<AgentTheme, int> _f$onAccentArgb = Field(
    'onAccentArgb',
    _$onAccentArgb,
  );
  static String _$fontFamily(AgentTheme v) => v.fontFamily;
  static const Field<AgentTheme, String> _f$fontFamily = Field(
    'fontFamily',
    _$fontFamily,
  );

  @override
  final MappableFields<AgentTheme> fields = const {
    #primaryArgb: _f$primaryArgb,
    #onPrimaryArgb: _f$onPrimaryArgb,
    #backgroundArgb: _f$backgroundArgb,
    #onBackgroundArgb: _f$onBackgroundArgb,
    #accentArgb: _f$accentArgb,
    #onAccentArgb: _f$onAccentArgb,
    #fontFamily: _f$fontFamily,
  };

  static AgentTheme _instantiate(DecodingData data) {
    return AgentTheme(
      primaryArgb: data.dec(_f$primaryArgb),
      onPrimaryArgb: data.dec(_f$onPrimaryArgb),
      backgroundArgb: data.dec(_f$backgroundArgb),
      onBackgroundArgb: data.dec(_f$onBackgroundArgb),
      accentArgb: data.dec(_f$accentArgb),
      onAccentArgb: data.dec(_f$onAccentArgb),
      fontFamily: data.dec(_f$fontFamily),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AgentTheme fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AgentTheme>(map);
  }

  static AgentTheme fromJson(String json) {
    return ensureInitialized().decodeJson<AgentTheme>(json);
  }
}

mixin AgentThemeMappable {
  String toJson() {
    return AgentThemeMapper.ensureInitialized().encodeJson<AgentTheme>(
      this as AgentTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return AgentThemeMapper.ensureInitialized().encodeMap<AgentTheme>(
      this as AgentTheme,
    );
  }

  AgentThemeCopyWith<AgentTheme, AgentTheme, AgentTheme> get copyWith =>
      _AgentThemeCopyWithImpl<AgentTheme, AgentTheme>(
        this as AgentTheme,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AgentThemeMapper.ensureInitialized().stringifyValue(
      this as AgentTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    return AgentThemeMapper.ensureInitialized().equalsValue(
      this as AgentTheme,
      other,
    );
  }

  @override
  int get hashCode {
    return AgentThemeMapper.ensureInitialized().hashValue(this as AgentTheme);
  }
}

extension AgentThemeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AgentTheme, $Out> {
  AgentThemeCopyWith<$R, AgentTheme, $Out> get $asAgentTheme =>
      $base.as((v, t, t2) => _AgentThemeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AgentThemeCopyWith<$R, $In extends AgentTheme, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? primaryArgb,
    int? onPrimaryArgb,
    int? backgroundArgb,
    int? onBackgroundArgb,
    int? accentArgb,
    int? onAccentArgb,
    String? fontFamily,
  });
  AgentThemeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AgentThemeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AgentTheme, $Out>
    implements AgentThemeCopyWith<$R, AgentTheme, $Out> {
  _AgentThemeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AgentTheme> $mapper =
      AgentThemeMapper.ensureInitialized();
  @override
  $R call({
    int? primaryArgb,
    int? onPrimaryArgb,
    int? backgroundArgb,
    int? onBackgroundArgb,
    int? accentArgb,
    int? onAccentArgb,
    String? fontFamily,
  }) => $apply(
    FieldCopyWithData({
      if (primaryArgb != null) #primaryArgb: primaryArgb,
      if (onPrimaryArgb != null) #onPrimaryArgb: onPrimaryArgb,
      if (backgroundArgb != null) #backgroundArgb: backgroundArgb,
      if (onBackgroundArgb != null) #onBackgroundArgb: onBackgroundArgb,
      if (accentArgb != null) #accentArgb: accentArgb,
      if (onAccentArgb != null) #onAccentArgb: onAccentArgb,
      if (fontFamily != null) #fontFamily: fontFamily,
    }),
  );
  @override
  AgentTheme $make(CopyWithData data) => AgentTheme(
    primaryArgb: data.get(#primaryArgb, or: $value.primaryArgb),
    onPrimaryArgb: data.get(#onPrimaryArgb, or: $value.onPrimaryArgb),
    backgroundArgb: data.get(#backgroundArgb, or: $value.backgroundArgb),
    onBackgroundArgb: data.get(#onBackgroundArgb, or: $value.onBackgroundArgb),
    accentArgb: data.get(#accentArgb, or: $value.accentArgb),
    onAccentArgb: data.get(#onAccentArgb, or: $value.onAccentArgb),
    fontFamily: data.get(#fontFamily, or: $value.fontFamily),
  );

  @override
  AgentThemeCopyWith<$R2, AgentTheme, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AgentThemeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

