//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cbl_flutter_ce/cbl_flutter_ce.h>
#include <isar_flutter_libs/isar_flutter_libs_plugin.h>
#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>
#include <realm/realm_plugin.h>
#include <sqlite3_flutter_libs/sqlite3_flutter_libs_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CblFlutterCeRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CblFlutterCe"));
  IsarFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("IsarFlutterLibsPlugin"));
  ObjectboxFlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ObjectboxFlutterLibsPlugin"));
  RealmPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RealmPlugin"));
  Sqlite3FlutterLibsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("Sqlite3FlutterLibsPlugin"));
}
