class DirectorysController < ApplicationController
  
  def new
    @directory = Directory.new
  end
  
end
