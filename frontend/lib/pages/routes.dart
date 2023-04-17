import 'package:flutter/widgets.dart';

import '/third_party/third_party.dart';
import '/constants/constants.dart';
import 'pages.dart';

part 'routes.g.dart';

@TypedGoRoute<WorkbenchPageRoute>(path: '/workbench')
@immutable
class WorkbenchPageRoute extends GoRouteData {
  const WorkbenchPageRoute({
    this.id = Empty.INT,
  });

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkbenchPage();
  }
}
