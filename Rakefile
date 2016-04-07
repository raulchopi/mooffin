# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Mooffin::Application.load_tasks

namespace :mooffin do
  desc "Get Movistar+ epg"
  task getEpgToday: :environment do
    # delete yesterdays file
    # yesterday = (Time.now - 1.days).strftime("%Y-%m-%d")
    # File.delete("./movistar/" + yesterday + ".txt")

    #generate new todays file
    today = Time.now.strftime("%Y-%m-%d")
    path = "./movistar/today.txt"
    response = HTTP.get("http://www.plus.es/guia/" + today + "/?v=json")
    File.open(path, "w+") do |f|
      f.write(response)
    end
  end
end
