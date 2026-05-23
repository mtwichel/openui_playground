// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'shell_bloc.dart';

class ShellTabMapper extends EnumMapper<ShellTab> {
  ShellTabMapper._();

  static ShellTabMapper? _instance;
  static ShellTabMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShellTabMapper._());
    }
    return _instance!;
  }

  static ShellTab fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ShellTab decode(dynamic value) {
    switch (value) {
      case r'definition':
        return ShellTab.definition;
      case r'components':
        return ShellTab.components;
      case r'tools':
        return ShellTab.tools;
      case r'theme':
        return ShellTab.theme;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ShellTab self) {
    switch (self) {
      case ShellTab.definition:
        return r'definition';
      case ShellTab.components:
        return r'components';
      case ShellTab.tools:
        return r'tools';
      case ShellTab.theme:
        return r'theme';
    }
  }
}

extension ShellTabMapperExtension on ShellTab {
  String toValue() {
    ShellTabMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ShellTab>(this) as String;
  }
}

class ShellStateMapper extends ClassMapperBase<ShellState> {
  ShellStateMapper._();

  static ShellStateMapper? _instance;
  static ShellStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShellStateMapper._());
      ShellTabMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShellState';

  static ShellTab _$selectedTab(ShellState v) => v.selectedTab;
  static const Field<ShellState, ShellTab> _f$selectedTab = Field(
    'selectedTab',
    _$selectedTab,
    opt: true,
    def: ShellTab.definition,
  );

  @override
  final MappableFields<ShellState> fields = const {
    #selectedTab: _f$selectedTab,
  };

  static ShellState _instantiate(DecodingData data) {
    return ShellState(selectedTab: data.dec(_f$selectedTab));
  }

  @override
  final Function instantiate = _instantiate;

  static ShellState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShellState>(map);
  }

  static ShellState fromJson(String json) {
    return ensureInitialized().decodeJson<ShellState>(json);
  }
}

mixin ShellStateMappable {
  String toJson() {
    return ShellStateMapper.ensureInitialized().encodeJson<ShellState>(
      this as ShellState,
    );
  }

  Map<String, dynamic> toMap() {
    return ShellStateMapper.ensureInitialized().encodeMap<ShellState>(
      this as ShellState,
    );
  }

  ShellStateCopyWith<ShellState, ShellState, ShellState> get copyWith =>
      _ShellStateCopyWithImpl<ShellState, ShellState>(
        this as ShellState,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShellStateMapper.ensureInitialized().stringifyValue(
      this as ShellState,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShellStateMapper.ensureInitialized().equalsValue(
      this as ShellState,
      other,
    );
  }

  @override
  int get hashCode {
    return ShellStateMapper.ensureInitialized().hashValue(this as ShellState);
  }
}

extension ShellStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShellState, $Out> {
  ShellStateCopyWith<$R, ShellState, $Out> get $asShellState =>
      $base.as((v, t, t2) => _ShellStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShellStateCopyWith<$R, $In extends ShellState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({ShellTab? selectedTab});
  ShellStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ShellStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShellState, $Out>
    implements ShellStateCopyWith<$R, ShellState, $Out> {
  _ShellStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShellState> $mapper =
      ShellStateMapper.ensureInitialized();
  @override
  $R call({ShellTab? selectedTab}) => $apply(
    FieldCopyWithData({if (selectedTab != null) #selectedTab: selectedTab}),
  );
  @override
  ShellState $make(CopyWithData data) =>
      ShellState(selectedTab: data.get(#selectedTab, or: $value.selectedTab));

  @override
  ShellStateCopyWith<$R2, ShellState, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShellStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

