class DirectoriesController < ApplicationController
  
  def new
    @directory = Directory.new
  end
  
end
