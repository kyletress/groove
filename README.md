# Groove Rails Template

A simple starting point for my Rails apps. 

**Note:** Requires Rails 5.2 or higher

## Getting Started

#### Requirements 

What you need:

* Ruby 2.5 or higher 
* Redis (for ActionCable)
* Bundler `gem install bundler`
* Rails `gem install rails`
* Yarn `brew install yarn`

#### Creating a new app 

```bash
rails new nyapp -d postgresql -m https://raw.githubusercontent.com/kyletress/groove/master/template.rb
```

or you can make this the default by adding the following lines to your `~/.railsrc` file:

```bash
-d postgresql 
-m https://raw.githubusercontent.com/kyletress/groove/master/template.rb
```

