module ShoppyCartus
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_initialize_file
      copy_file 'shoppy_cartus.rb', "config/initializers/#{file_name}.rb"
    end
  end
end
