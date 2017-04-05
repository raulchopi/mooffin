# -*- encoding : utf-8 -*-
require File.expand_path('../../../../../config/application', __FILE__)
require 'open-uri'

module Api
  module V1
    class ComuniazoController < ApiControllerBase
      def getJornada
        @jornada = {}
        @jornada['resultados'] = []

        page = Nokogiri::HTML(open("http://www.comuniazo.com"))

        # File.open("./elhtml.html", "w+") do |f|
        #   f.write(page)
        # end

        page.css('div.group.partidos')[1].css('div.partido').each do |partido|
          @partido = {}
          @partido['res'] = partido.css('div.score').text
          @partido['fecha'] = partido.css('div.fecha').text
          @partido['local'] = partido.css('div.casa').css('i')[0]['class']
          @partido['visitante'] = partido.css('div.fuera').css('i')[0]['class']
          @partido['url'] = partido.css('a.match')[0]['href']
          if partido.at_css('div.bubble-puntos')
            @partido['puntos'] = 'si'
          else
            @partido['puntos'] = 'no'
          end
          @jornada['resultados'].push @partido
        end
        # @jornada['subtitle'] = response.css('div[class=title-image]').css('h1[class=h-epsilon]').text
        # @jornada['synopsis'] = response.css('div[itemprop=description]').text
        # @jornada['genre'] = response.css('p[itemprop=genre]').text
        # @jornada['duration'] = response.css('span[itemprop=duration]').text
        # @jornada['date'] = response.css('p[itemprop=datePublished]').text
        # @jornada['moral'] = response.css('div[class=moral]').css('img')[0]['alt']
        # @jornada['image'] = response.css('div[class=cover]').css('img')[0]['src']

        @jornada
      end

      def getPartido
        @partido = {}

        page = Nokogiri::HTML(open(url_game))

        # File.open("./elpartido.html", "w+") do |f|
        #   f.write(page)
        # end

        @casa = []
        @fuera = []

        page.css('div.content').css('div.group').css('div.col')[0].css('tbody').css('tr').each do |j|
          @j = {}
          @j['nombre'] = j.css('strong').text
          @j['pos'] = j.css('td.mini').css('span')[0]['class']
          if j.at_css('td.score')
            @j['puntos'] = j.css('td.score').text
            @j['val'] = j.css('td.score')[0]['class'].split(' ').last
          end
          @j['eventos'] = []
          j.css('div.eventos').css('i').each do |e|
            @j['eventos'].push e['class'].split(' ').last
          end
          @casa.push @j
        end

        page.css('div.content').css('div.group').css('div.col')[2].css('tbody').css('tr').each do |j|
          @j = {}
          @j['nombre'] = j.css('strong').text
          @j['pos'] = j.css('td.mini').css('span')[0]['class']
          if j.at_css('td.score')
            @j['puntos'] = j.css('td.score').text
            @j['val'] = j.css('td.score')[0]['class'].split(' ').last
          end
          @j['eventos'] = []
          j.css('div.eventos').css('i').each do |e|
            @j['eventos'].push e['class'].split(' ').last
          end
          @fuera.push @j
        end

        @partido['casa'] = @casa
        @partido['fuera'] = @fuera
        @partido['escudo1'] = page.css('td.escudo-mid')[0].css('img')[0]['src']
        @partido['escudo2'] = page.css('td.escudo-mid')[1].css('img')[0]['src']
        @partido['marcador1'] = page.css('td.marcador').css('span')[0].text
        @partido['marcador2'] = page.css('td.marcador').css('span')[1].text

      end

      private
        def url_game
          params.require(:game)
        end

    end
  end
end
