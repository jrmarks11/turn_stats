namespace :api do
  desc "loads all the files from trackobot"
  task load_all: :environment do
    GameLoader.new.load_all
  end
end
