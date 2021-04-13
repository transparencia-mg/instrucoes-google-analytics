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
      file_path = params[:file].original_filename.split(' - ')[0].strip
      url_classified_array = url_objets_to_classifications_array(UrlClassification.all.to_a)
      count = 0
      CSV.open(file_path, 'a+') do |csv|
        CSV.foreach(params[:file].path) do |row|
          url_imported_array = row[1].split('/').reject(&:blank?)
          csv << %w(classificacao
                    periodo
                    url
                    sessoes
                    porcentagem_novas_sessoes
                    novos_usuarios
                    taxa_rejeicao
                    paginas_sessao
                    duração_media_sessao
                    ) if count == 0
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
          count += 1
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
    if classified_url.include?(imported_url.first(3).last) && !UrlClassification.where(url:imported_url.join('/')).first.nil?
        classification_description = UrlClassification.where(url:imported_url.join('/')).first.classification
    else
      classification_description = 'Outros'
    end
    classification_description
  end

  def export
    # https://gorails.com/episodes/export-to-csv
    respond_to do |format|
      format.csv { send_data to_csv, filename: "texte-exportacao" }
    end
  end

  def to_csv
      CSV.generate(headers: true) do |csv|
        CSV.foreach("03_2021_1") do |row|
          csv << row
        end
      end
    end
end


# puts "#{row[0]} | #{row[1]} | #{row[2]} | #{row[1].split('/').reject(&:blank?).count} | #{row[1].split('/').reject(&:blank?)}"
# csv_options = { col_sep: ',', quote_char: '"' }
# CSV.foreach(params[:file].path, csv_options) do |row|
