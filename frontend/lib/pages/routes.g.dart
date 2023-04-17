// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $workbenchPageRoute,
    ];

GoRoute get $workbenchPageRoute => GoRouteData.$route(
      path: '/workbench',
      factory: $WorkbenchPageRouteExtension._fromState,
    );

extension $WorkbenchPageRouteExtension on WorkbenchPageRoute {
  static WorkbenchPageRoute _fromState(GoRouterState state) =>
      WorkbenchPageRoute(
        id: _$convertMapValue('id', state.queryParams, int.parse) ?? Empty.INT,
      );

  String get location => GoRouteData.$location(
        '/workbench',
        queryParams: {
          if (id != Empty.INT) 'id': id.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  void push(BuildContext context) => context.push(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
