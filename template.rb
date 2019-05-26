require "fileutils"
require "shellwords"

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("groove-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/kyletress/groove.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{groove/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end  

def add_gems 
  gem 'bcrypt', '~> 3.1.12'
  gem 'name_of_person'
  gem 'redis', '~> 4.0'
  gem 'sidekiq', '~> 5.2', '>= 5.2.5'
end 

def copy_templates
  remove_file "app/assets/stylesheets/application.css"
  copy_file "Procfile"
  directory "app", force: true
  directory "config", force: true
  generate :controller, "StaticPages home"

  route "root to: 'static_pages#home'"
end 

def add_users 
  generate :controller, "Users"
  generate :model, "User first_name last_name email:string:uniq password_digest"
  generate :controller, "Sessions new"

  route "get  '/signup', to: 'users#new'"
  route "post '/signup', to: 'users#create'"
  route "get '/login', to: 'sessions#new'"
  route "post '/login', to: 'sessions#create'"
  route "delete '/logout', to: 'sessions#destroy'"
  route "resources :users"
end 

def configure_ssl
  environment 'config.force_ssl = true', env: 'production'
end 

# Main setup
add_template_repository_to_source_path
add_gems
add_users
configure_ssl

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