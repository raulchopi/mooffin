# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'open-uri'

Mooffin::Application.load_tasks

namespace :mooffin do
  desc "Get Movistar+ epg"
  task getEpgToday: :environment do

    #canales tv publica
    publicChannels = ['TVE', 'LA2', 'A3', 'C4', 'T5', 'SEXTA', 'FDFIC', 'NEOX',
      'ATRESS', '13TV', 'TDEP', 'DCRMAX', 'DIVINI', 'NOVA', 'MEGA', 'ENERGY',
      'BOING', 'CLANTV', '24H', 'PARCH']

    #generate new todays file
    today = Time.now.strftime("%Y-%m-%d")
    path = "./movistar/today.txt"
    @epg = []
    url = "http://www.plus.es/guia/" + today + "/?v=json"
    response = open(url).read

    @epgAux = ActiveSupport::JSON.decode(response)['data']

    @epgAux.each do |key, value|
      @epg.push(value)
    end

    @epg.delete_at(7)  # borro el programa 'la otra'

    @epg.each do |c|
      if(publicChannels.include? c['DATOS_CADENA']['CODIGO'])
        c['DATOS_CADENA'][:PUBLICA] = true
      else
        c['DATOS_CADENA'][:PUBLICA] = false
      end

      c['DATOS_CADENA'].delete('URL')
      c['DATOS_CADENA'].delete('DIAL_PRINCIPAL')
      c['DATOS_CADENA'].delete('EXCLUSIVA')
      c['DATOS_CADENA'].delete('MARCA')
      c['PROGRAMAS'].each_with_index do |p, index|
        p.delete('URL')
        p.delete('ELEMENTO')
        p.delete('DURACION_VISUAL')
        p.delete('ESTRENO')
        p.delete('TEMPORADA')
      end
    end

    File.open(path, "w+") do |f|
      f.write(@epg.to_json)
    end
  end
end
