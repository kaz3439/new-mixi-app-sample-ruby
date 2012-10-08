class MixiAppGenerator < Rails::Generators::NamedBase
  include Rails::Generators::ResourceHelpers
  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(dirname) #:nodoc:
    next_migration_number = current_migration_number(dirname) + 1
    ActiveRecord::Migration.next_migration_number(next_migration_number)
  end

  def copy_controller_file
    copy_file "mixi_app_controller.rb", "app/controllers/#{file_name}_controller.rb"
  end

  def copy_token_migration_files
    migration_template "migration.rb", File.join("db/migrate", "create_token.rb");
  end

  def copy_token_model_files
    template "token.rb", File.join("app/models", "token.rb");
  end

end
