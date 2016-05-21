# -*- encoding : utf-8 -*-

module Api
  module V1
    class MovistarController < ApiControllerBase

      def getEpgToday
        now = Time.now
        nowStr = Time.now.strftime("%H:%M")
        readed = File.read("./movistar/today.txt")
        @epg = ActiveSupport::JSON.decode(readed)

        @epg.each do |c|
          c['PROGRAMAS'].each_with_index do |p, index|
            # controlamos programa actual, la 2da condicion es para controlar programa de medianoche
            if( (nowStr >= p['HORA_INICIO'] && nowStr < p['HORA_FIN']) || (p['HORA_INICIO'] > p['HORA_FIN'] && nowStr <= p['HORA_INICIO'] && nowStr <= p['HORA_FIN']))
              c['DATOS_CADENA'][:ACTUAL] = index
              p[:PORCENTAJE] = (((now - Time.parse(p['HORA_INICIO'])) / (p['DURACION'] * 60)) * 100).to_i
              if(p[:PORCENTAJE] < 0) # controlamos programas de medianoche
                p[:PORCENTAJE] = (((now - Time.parse(p['HORA_INICIO']) + 86400) / (p['DURACION'] * 60)) * 100).to_i
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


      def getProgramInfo
        @info = {}

        response = Nokogiri::HTML(open("http://www.plus.es/ficha?tipo=R&id=" + programInfo_params))

        @info['title'] = response.css('div[class=title-image]').css('p[class=h-gamma]').text
        @info['subtitle'] = response.css('div[class=title-image]').css('h1[class=h-epsilon]').text
        @info['synopsis'] = response.css('div[itemprop=description]').text
        @info['genre'] = response.css('p[itemprop=genre]').text
        @info['duration'] = response.css('span[itemprop=duration]').text
        @info['date'] = response.css('p[itemprop=datePublished]').text
        @info['moral'] = response.css('div[class=moral]').css('img')[0]['alt']
        @info['image'] = response.css('div[class=cover]').css('img')[0]['src']

        @info
      end

      private
        def epg_params
          params.require(:code)
        end

        def programInfo_params
          params.require(:program)
        end

    end
  end
end
