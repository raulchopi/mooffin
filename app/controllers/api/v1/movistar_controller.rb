# -*- encoding : utf-8 -*-

module Api
  module V1
    class MovistarController < ApiControllerBase

      def getEpgToday
        @epg = []
        now = Time.now
        nowStr = Time.now.strftime("%H:%M")
        readed = File.readlines "./movistar/today.txt"
        @epgAux = ActiveSupport::JSON.decode(readed[0])['data']

        @epgAux.each do |key, value|
          @epg.push(value)
        end

        @epg.each do |c|
          c['PROGRAMAS'].each_with_index do |p, index|
            # controlamos programa actual, la 2da condicion es para controlar programa de medianoche
            if( (nowStr >= p['HORA_INICIO'] && nowStr < p['HORA_FIN']) || (nowStr >= p['HORA_INICIO'] && nowStr > p['HORA_FIN']))
              c['DATOS_CADENA'][:ACTUAL] = index
              p[:PORCENTAJE] = (((now - Time.parse(p['HORA_INICIO'])) / (p['DURACION'] * 60)) * 100).to_i
              if(p[:PORCENTAJE] < 0) # controlamos programas de medianoche
                p[:PORCENTAJE] = (((now - Time.parse(p['HORA_INICIO'] + 86400)) / (p['DURACION'] * 60)) * 100).to_i
              end
              break
            end
          end
        end
        @epg
      end

      def getEpgTomorrow
        @epg = []
        today = (Time.now + 1.days).strftime("%Y-%m-%d")
        @response = HTTP.get("http://www.plus.es/guia/" + today + "/?v=json&canal=" + epg_params)
        @epgAux = ActiveSupport::JSON.decode(@response)['data']

        @epgAux.each do |key, value|
          @epg.push(value)
        end

        @epg
      end


      def getEpgAfterTomorrow
        @epg = []
        today = (Time.now + 2.days).strftime("%Y-%m-%d")
        @response = HTTP.get("http://www.plus.es/guia/" + today + "/?v=json&canal=" + epg_params)
        @epgAux = ActiveSupport::JSON.decode(@response)['data']

        @epgAux.each do |key, value|
          @epg.push(value)
        end

        @epg

      end

      private
        def epg_params
          params.require(:code)
        end

    end
  end
end
