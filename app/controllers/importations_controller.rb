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
      url_classified_array = url_objets_to_classifications_array(UrlClassification.all.to_a)
      CSV.foreach(params[:file].path) do |row|
        # puts "#{row[0]} | #{row[1]} | #{row[2]} | #{row[1].split('/').reject(&:blank?).count} | #{row[1].split('/').reject(&:blank?)}"
        url_imported_array = row[1].split('/').reject(&:blank?)
        file_path = params[:file].original_filename.split(' - ')[0].strip
        CSV.open(file_path, 'a+') do |csv|
          csv << [classification(url_imported_array, url_classified_array),
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

  def url_objets_to_classifications_array(url_array)
    url_array_classification = []
    url_array.each do |url|
      url_array_classification << url.url.split('/').reject(&:blank?).last
    end
    url_array_classification
  end

  def classification(imported_url, classified_url)
    classification_description = ''
    if classified_url.include?(imported_url.first(3).last)
      if !UrlClassification.where(url:imported_url.first(3).last).first.nil?
        # raise
        classification_description = UrlClassification.where(url:imported_url.first(3).last).first.classification
      end
    else
      classification_description = 'Outros'
    end
    classification_description
  end
end
