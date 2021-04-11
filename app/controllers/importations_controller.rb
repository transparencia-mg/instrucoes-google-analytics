class ImportationsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def new
  end

  def import
    if params[:file].nil?
      redirect_to importations_new_path
    else
      # csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
      # CSV.foreach(params[:file].path, csv_options) do |row|
      CSV.foreach(params[:file].path) do |row|
        p row
      end
      redirect_to importations_new_path
    end
  end
end
