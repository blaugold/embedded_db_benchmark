//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cbl_flutter_ee/cbl_flutter_ee.h>
#include <isar_flutter_libs/isar_flutter_libs_plugin.h>
#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <realm/realm_plugin.h>
#include <sqlite3_flutter_libs/sqlite3_flutter_libs_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) cbl_flutter_ee_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CblFlutterEe");
  cbl_flutter_ee_register_with_registrar(cbl_flutter_ee_registrar);
  g_autoptr(FlPluginRegistrar) isar_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "IsarFlutterLibsPlugin");
  isar_flutter_libs_plugin_register_with_registrar(isar_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) objectbox_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ObjectboxFlutterLibsPlugin");
  objectbox_flutter_libs_plugin_register_with_registrar(objectbox_flutter_libs_registrar);
  g_autoptr(FlPluginRegistrar) realm_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "RealmPlugin");
  realm_plugin_register_with_registrar(realm_registrar);
  g_autoptr(FlPluginRegistrar) sqlite3_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "Sqlite3FlutterLibsPlugin");
  sqlite3_flutter_libs_plugin_register_with_registrar(sqlite3_flutter_libs_registrar);
}
