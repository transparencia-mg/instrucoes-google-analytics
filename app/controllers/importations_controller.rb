class ImportationsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'
  require 'csv'
  # https://programmingresources.fandom.com/wiki/Ruby:_Deleting_Files#:~:text=To%20delete%20a%20file%20you,command%20of%20the%20File%20class.&text=You%20can%20use%20ruby's%20%22fileutils,to%20achieve%20deleting%20folders%2Fdirectories.
  require 'fileutils'

  def new
  end

  def import
    if params[:file].nil?
      redirect_to importations_new_path
    else
      file_path = params[:file].original_filename.split(' - ')[0].strip
      url_classified_array = url_objets_to_classifications_array(UrlClassification.all.to_a)
      CSV.open(file_path, 'a+') do |csv|
        csv << %w(propriedade
                  mes
                  pagina-destino
                  URL
                  sessoes
                  novas-sessoes-porcentagem
                  usuarios-novos
                  taxa-rejeicao
                  paginas-sessao
                  duracao-sessao
                  )
        CSV.foreach(params[:file].path, col_sep: ',', quote_char: '"') do |row|
          url_imported_array = row[0].split('/').reject(&:blank?)
          csv << [file_path.split('-')[0], # Busca portal ou ckan como propriedade
                  file_path.split('-')[4].to_i, # Busca o mês
                  classification(url_imported_array, url_classified_array),
                  row[0],
                  row[1].split('.').join, # Retirar o ponto quando número for muito grande
                  row[2].split("%")[0],
                  row[3].split('.').join, # Retirar o ponto quando número for muito grande
                  row[4].split("%")[0],
                  row[5],
                  row[6].split("<").last
                ]
          # arrumar arquivos 2020 e 2021 comentar códigos acima
          # csv << [row[0],
          #         row[1],
          #         row[2],
          #         row[3],
          #         row[4].split('.').join,
          #         row[5].split("%")[0],
          #         row[6].split('.').join,
          #         row[7].split("%")[0],
          #         row[8],
          #         row[9]
          #                 ]
        end
      end
      redirect_to export_path(file_path: file_path)
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
    # Último && evita erros no código
    if classified_url.include?(imported_url.first(3).last) && !UrlClassification.where(url:imported_url[0..2].join('/')).first.nil?
      # o último iten (após "/") das urls classificadas tem que ser igual ao terceiro item
      # (após "/") da url importada
      classification_description = UrlClassification.where(url:imported_url[0..2].join('/')).first.classification
    elsif classified_url.include?(imported_url.first.split('?').first)
      # classificação Busca - possui link diferente - separado por "?"
      classification_description = UrlClassification.where(url:imported_url.first.split('?').first).first.classification
    elsif imported_url.first == 'banco-de-noticias'
      classification_description = UrlClassification.where(url:'banco-de-noticias').first.classification
    else
      classification_description = 'Outros'
    end
    classification_description
  end

  def export
    # https://gorails.com/episodes/export-to-csv
    respond_to do |format|
      format.csv { send_data to_csv(params[:file_path]), filename: params[:file_path] }
    end
    # Deleta o arquivo após a classificação e exportação
    FileUtils.rm_rf(params[:file_path])
  end

  def to_csv(file_path)
    CSV.generate(col_sep: ';', quote_char: '"', headers: true) do |csv|
      CSV.foreach(file_path) do |row|
        csv << row
      end
    end
  end

  private

  def sucess
    redirect_to importations_new_path
  end
end
