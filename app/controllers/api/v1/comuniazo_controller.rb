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

        page.css('div.group.partidos')[0].css('div.partido').each do |partido|
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
          if partido.at_css('img.tv')
            @partido['tv'] = partido.css('img.tv')[0]['src']
          end
          @jornada['resultados'].push @partido
        end

        @jornada
      end

      def getPuntos
        @puntos = {}
        @puntos['partidos'] = []

        page = Nokogiri::HTML(open("http://www.comuniazo.com/comunio/puntos"))

        page.css('div.partido-small').each do |part|
          @p = {}
          @casa = []
          @fuera = []
          @p['escudo1'] = part.css('div.escudo-box')[0].css('i')[0]['class']
          @p['escudo2'] = part.css('div.escudo-box')[1].css('i')[0]['class']
          @p['local'] = part.css('div.equipo')[0].text
          @p['visitante'] = part.css('div.equipo')[1].text
          @p['marcador1'] = part.css('div.marcador').css('span')[0].text
          @p['marcador2'] = part.css('div.marcador').css('span')[1].text

          #Alineacion de casa
          part.css('div.left').css('tr').each do |j|
            @j = {}
            @j['nombre'] = j.css('td.ancho').css('strong').text
            @j['pos'] = j.css('td')[0].css('span')[0]['class']
            if j.at_css('td.pt-comunio')
              @j['puntos'] = j.css('td.pt-comunio').text
              @j['val'] = j.css('td.pt-comunio')[0]['class'].split(' ').second
            end
            @j['eventos'] = []
            j.css('div.eventos').css('i').each do |e|
              @j['eventos'].push e['class'].split(' ').last
            end
            @casa.push @j
          end

          #Alineacion de fuera
          part.css('div.right').css('tr').each do |j|
            @j = {}
            @j['nombre'] = j.css('td.ancho').css('strong').text
            @j['pos'] = j.css('td')[0].css('span')[0]['class']
            if j.at_css('td.pt-comunio')
              @j['puntos'] = j.css('td.pt-comunio').text
              @j['val'] = j.css('td.pt-comunio')[0]['class'].split(' ').second
            end
            @j['eventos'] = []
            j.css('div.eventos').css('i').each do |e|
              @j['eventos'].push e['class'].split(' ').last
            end
            @fuera.push @j
          end

          @p['casa'] = @casa
          @p['fuera'] = @fuera
          @puntos['partidos'].push @p

        end

        @puntos
      end

      def getPartido
        @partido = {}

        page = Nokogiri::HTML(open(url_game))

        @casa = []
        @fuera = []
        @casales = []
        @fuerales = []

        @partido['casajugtit'] = page.css('div.content').css('div.group').css('div.col')[0].css('tr.head').css('h2').text
        @partido['fuerajugtit'] = page.css('div.content').css('div.group').css('div.col')[2].css('tr.head').css('h2').text

        @partido['casajugdisp'] = page.css('div.content').css('div.group').css('div.col')[0].css('div.alert').text
        @partido['fuerajugdisp'] = page.css('div.content').css('div.group').css('div.col')[2].css('div.alert').text
        @partido['casaconvdisp'] = page.css('div.content').css('div.group')[1].css('div.col')[0].css('div.box')[0].css('div.alert').text
        @partido['fueraconvdisp'] = page.css('div.content').css('div.group')[1].css('div.col')[2].css('div.box')[0].css('div.alert').text
        if page.css('div.content').css('div.group')[1].css('div.col')[0].css('div.box')[1]
          @partido['casalesdisp'] = page.css('div.content').css('div.group')[1].css('div.col')[0].css('div.box')[1].css('div.alert').text
        end
        if page.css('div.content').css('div.group')[1].css('div.col')[2].css('div.box')[1]
          @partido['fueralesdisp'] = page.css('div.content').css('div.group')[1].css('div.col')[2].css('div.box')[1].css('div.alert').text
        end

        #Alineacion de casa
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

        #Alineacion de fuera
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

        #Lesionados de casa
        if page.css('div.content').css('div.group')[1].css('div.col')[0].css('div.box')[1]
          page.css('div.content').css('div.group')[1].css('div.col')[0].css('div.box')[1].css('tbody').css('tr').each do |l|
            @l = {}
            @l['nombre'] = l.css('strong').text
            @l['pos'] = l.css('span')[0]['class']
            @l['time'] = l.css('div.font-op').text
            @casales.push @l
          end
        end

        #Lesionados de fuera
        if page.css('div.content').css('div.group')[1].css('div.col')[2].css('div.box')[1]
          page.css('div.content').css('div.group')[1].css('div.col')[2].css('div.box')[1].css('tbody').css('tr').each do |l|
            @l = {}
            @l['nombre'] = l.css('strong').text
            @l['pos'] = l.css('span')[0]['class']
            @l['time'] = l.css('div.font-op').text
            @fuerales.push @l
          end
        end

        @partido['casa'] = @casa
        @partido['fuera'] = @fuera
        @partido['casales'] = @casales
        @partido['fuerales'] = @fuerales
        @partido['escudo1'] = page.css('td.escudo-mid')[0].css('img')[0]['src']
        @partido['escudo2'] = page.css('td.escudo-mid')[1].css('img')[0]['src']
        @partido['local'] = page.css('td.escudo-mid')[0].css('img')[0]['alt']
        @partido['visitante'] = page.css('td.escudo-mid')[1].css('img')[0]['alt']
        @partido['marcador1'] = page.css('td.marcador').css('span')[0].text
        @partido['marcador2'] = page.css('td.marcador').css('span')[1].text
        @partido['fecha'] = page.css('td.fecha')[0].text

      end

      private
        def url_game
          params.require(:game)
        end

    end
  end
end
