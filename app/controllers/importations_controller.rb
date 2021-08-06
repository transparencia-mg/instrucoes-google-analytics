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
      delete_csv_files
      file_path = params[:file].original_filename.split(' - ')[0].strip
      url_classified_array = url_objets_to_classifications_array(UrlClassification.all.to_a)
      CSV.open(file_path, 'a+') do |csv|
        # csv << %w(propriedade
        #           mes
        #           pagina_destino
        #           URL
        #           sessoes
        #           novas-sessoes_porcentagem
        #           usuarios_novos
        #           taxa_rejeicao
        #           paginas_sessao
        #           duracao_sessao
        #           )
        CSV.foreach(params[:file].path, col_sep: ',', quote_char: '"') do |row|
          property = file_path.split('-')[0] # Busca portal ou ckan como propriedade
          url_imported_array = imported_array(row, property)
          csv << [property,
                  file_path.split('-')[4].to_i, # Busca o mês
                  classification(url_imported_array, url_classified_array, property),
                  row[0],
                  row[1].split('.').join, # Retirar o ponto quando número for muito grande
                  (row[2].split("%")[0].to_f/100).to_s.sub(".", ","), # row[2].split("%")[0] e transforma em número decimal
                  row[3].split('.').join, # Retirar o ponto quando número for muito grande
                  (row[4].split("%")[0].to_f/100).to_s.sub(".", ","), # row[4].split("%")[0] e transforma em número decimal
                  row[5],
                  row[6].split("<").last
                ]
        # arrumar arquivos 2020 e 2021 comentar códigos acima
        # count = 0
        # CSV.foreach(params[:file].path, col_sep: ';', quote_char: '"') do |row|
        #   csv << [row[0],
        #           row[1],
        #           row[2],
        #           row[3],
        #           row[4].split('.').join,
        #           (row[5].split("%")[0].to_f/100).to_s.sub(".", ","),
        #           row[6].split('.').join,
        #           (row[7].split("%")[0].to_f/100).to_s.sub(".", ","),
        #           row[8],
        #           row[9]
        #         ] if count > 0
        #         count += 1
        end
      end
      redirect_to export_path(file_path: file_path)
    end
  end

  def imported_array(row, property)
    url_imported_array = []
    if property == "ckan" && row[0].split('/').reject(&:blank?).count == 0
      url_imported_array = ["dados.mg.gov.br"]
    else
      url_imported_array = row[0].split('/').reject(&:blank?)
    end
      url_imported_array
  end

  def url_objets_to_classifications_array(url_array)
    url_array_classification = []
    url_array.each do |url|
      url_array_classification << url.url.split('/').reject(&:blank?).last
    end
    url_array_classification
  end

  def classification(imported_url, classified_url, property)
    classification_description = ''
    if property == "portal"
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
    elsif property == "ckan"
      # Último && evita erros no código
      if classified_url.include?(imported_url.first(3).last) && !UrlClassification.where(url:imported_url[0..2].join('/')).first.nil?
        # o último iten (após "/") das urls classificadas tem que ser igual ao terceiro item
        # (após "/") da url importada
        classification_description = UrlClassification.where(url:imported_url[0..2].join('/')).first.classification
      elsif imported_url.first == 'user'
        classification_description = 'Usuário'
      elsif classified_url.include?(imported_url.first.split('?').first)
        # classificação Busca - possui link diferente - separado por "?"
        classification_description = UrlClassification.where(url:imported_url.first.split('?').first).first.classification
      else
        classification_description = 'Outros'
      end
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

  def delete_csv_files
    all_csv_files = Dir.glob "./*.csv"
    all_csv_files.each do |file|
      File.delete(file)
    end
  end

  private

  def sucess
    redirect_to importations_new_path
  end
end
