class EntriesController < ApplicationController
  def new
    @entry = Entry.new
    @parent = params[:id]
  end
  
  def create
    parent_id = params[:entry][:parent]
    params[:entry].delete(:parent)
    @entry = Entry.new(entry_params)
    if @entry.save
      parent = Entry.find(parent_id) if parent_id.present?
      @entry.make_child_of!(parent) if parent.present?
    else
      @parent = parent_id
      render 'new'
    end
  end
  
  def show
    @entry = Entry.find(params[:id])
    respond_to { |format| format.js }
  end
  
  def index
    @entries = Entry.all
  end
  
  def edit
    @entry = Entry.find(params[:id])
    respond_to { |format| format.js }
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      redirect_to @entry
    else
      render 'edit'
    end
  end
  
  def destroy
    entry = Entry.find(params[:id])
    @id = params[:id]
    entry.destroy_children
    entry.destroy
  end
  
  private
    def clean_tags(tag_string)
      if tag_string.present?
        tag_list = tag_string.split(',').map(&:strip).reject(&:blank?)
      else
        tag_list = []
      end
    end

    def entry_params
      params[:entry][:tags] = clean_tags(params[:entry][:tags])
      params.require(:entry).permit(:name, :description, :tags => [])
    end
end
