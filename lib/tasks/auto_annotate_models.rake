# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults({
      'exclude_factories'    => "false",
      'exclude_fixtures'     => "false",
      'exclude_tests'        => "false",
      'force'                => "false",
      'format_bare'          => "false",
      'format_markdown'      => "true",
      'format_rdoc'          => "false",
      'ignore_model_sub_dir' => "false",
      'include_version'      => "false",
      'model_dir'            => "app/models",
      'position_in_class'    => "before",
      'position_in_factory'  => "before",
      'position_in_fixture'  => "before",
      'position_in_routes'   => "before",
      'position_in_test'     => "before",
      'require'              => "",
      'show_indexes'         => "true",
      'show_migration'       => "true",
      'simple_indexes'       => "false",
      'skip_on_db_migrate'   => "false",
      'classified_sort'      => "true",
      'trace'                => "true",
    })
  end

  Annotate.load_tasks
end
