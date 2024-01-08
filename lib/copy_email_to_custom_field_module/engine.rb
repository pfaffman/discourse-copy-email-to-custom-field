# frozen_string_literal: true

module ::SyncUserEmailModule
  class Engine < ::Rails::Engine
    engine_name PLUGIN_NAME
    isolate_namespace SyncUserEmailModule
    config.autoload_paths << File.join(config.root, "lib")
  end
end
