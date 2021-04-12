class ImportationsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  def new
  end

  def import
    if params[:file].nil?
      redirect_to importations_new_path
    else
      # csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
      # CSV.foreach(params[:file].path, csv_options) do |row|
      CSV.foreach(params[:file].path) do |row|
        # puts "#{row[0]} | #{row[1]} | #{row[2]} | #{row[1].split('/').reject(&:blank?).count} | #{row[1].split('/').reject(&:blank?)}"
        url_array = row[1].split('/').reject(&:blank?)
        raise
        file_path = params[:file].original_filename.split(' - ')[0].strip
        CSV.open(file_path, 'a+') do |csv|
          csv << [category(url_array),
                  row[0],
                  row[1],
                  row[2],
                  row[3],
                  row[4],
                  row[5],
                  row[6],
                  row[7],
                  row[8],
                ]
        end
      end
      redirect_to importations_new_path
    end
  end

  def category(url_array)
    category_description = ''
    if url_array.count = 1
      level_one_url = url_descriptions(UrlClassification.where(level: Level.where(level:1)))
      if level_one_url.include? url_array[0]
        category_description =
      end
    elsif url_array.count = 2
      level_two_url = url_descriptions(UrlClassification.where(level: Level.where(level:2)))
    elsif url_array.count = 3
      level_three_url = url_descriptions(UrlClassification.where(level: Level.where(level:3)))
    else
      category_description = 'Outros'
    end
  end

  def url_descriptions(url_objects)
    urls_array = []
    url_objects.to_a.each do |url|
      urls_array << url.name
    end
    urls_array
  end
end
