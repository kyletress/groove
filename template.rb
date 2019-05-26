after_bundle do
    # Create and migrate the database
    rails_command "db:create"
    rails_command "db:migrate"

    # Initialize a git repo and commit everything 
    git :init 
    git add: "."
    git commit: %Q{ -m 'Initial commit' }

    say "Track is clear. Your app has been created.", :green
end