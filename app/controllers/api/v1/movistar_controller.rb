# -*- encoding : utf-8 -*-

module Api
  module V1
    class MovistarController < ApiControllerBase

      def getEpg
        @epg = []
        now = Time.now
        nowStr = Time.now.strftime("%H:%M")
        today = Time.now.strftime("%Y-%m-%d")
        @response = HTTP.get("http://www.plus.es/guia/" + today + "/?v=json")
        @epgAux = ActiveSupport::JSON.decode(@response)['data']

        @epgAux.each do |key, value|
          @epg.push(value)
        end

        @epg.each do |c|
          c['PROGRAMAS'].each_with_index do |p, index|
            if(nowStr > p['HORA_INICIO'] && nowStr < p['HORA_FIN'])
              c['DATOS_CADENA'][:ACTUAL] = index
              p[:PORCENTAJE] = (((now - Time.parse(p['HORA_INICIO'])) / (p['DURACION'] * 60)) * 100).to_i
              break
            end
          end
        end

        @epg
        
      end
    end
  end
end
