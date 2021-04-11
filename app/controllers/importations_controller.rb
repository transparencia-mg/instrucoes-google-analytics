class ImportationsController < ApplicationController

  require 'open-uri'
  require 'nokogiri'

  def new
  end

  def import
    if params[:file].nil?
      redirect_to importations_new_path
    else
      CSV.foreach(params[:file].path) do |row|
        p row
      end
      redirect_to importations_new_path
    end
  end
end
