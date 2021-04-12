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
        file_path = params[:file].original_filename.split(' - ')[0].strip
        CSV.open(file_path, 'a+') do |csv|
          csv << ["Categoria",
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
end
