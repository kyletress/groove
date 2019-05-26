def add_gems 
    gem 'bcrypt', '~> 3.1.12'
    gem 'name_of_person'
    gem 'redis', '~> 4.0'
    gem 'sidekiq', '~> 5.2', '>= 5.2.5'
end 

def copy_templates
    remove_file "app/assets/stylesheets/application.css"
    generate :controller, "StaticPages home"

    route "root to: 'static_pages#home'"
end 

add_gems

after_bundle do
    copy_templates
    
    # Create and migrate the database
    rails_command "db:create"
    rails_command "db:migrate"

    # Initialize a git repo and commit everything 
    git :init 
    git add: "."
    git commit: %Q{ -m 'Initial commit' }

    say "Track is clear. Your app has been created.", :green
end