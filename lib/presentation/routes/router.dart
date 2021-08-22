import 'package:nimbus/presentation/pages/empresas/empresas_page.dart';
import 'package:nimbus/presentation/pages/home/home_page.dart';
import 'package:auto_route/annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: HomePage, initial: true),
    MaterialRoute(page: EmpresasPage, path: "/empresas", name: "Empresas")
  ],
)
class $AppRouter {}
