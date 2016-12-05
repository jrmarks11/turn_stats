namespace :api do
  desc "loads all the files from trackobot"
  task load_all: :environment do
    GameLoader.new.load_all
  end

  desc "loads a certain number of pages from tracobot"
  task :load, [:pages] => [:environment] do |t, args|
    puts "loading the last #{args[:pages]} pages"
    GameLoader.new.load(pages: args[:pages].to_i)
  end
end
