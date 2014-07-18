class EntriesController < ApplicationController
  def new
  end
  
  def show
    @entry = Entry.find(params[:id])
    respond_to { |format| format.js }
  end
  
  def index
    @entries = Entry.all
  end
end
