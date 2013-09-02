class PagesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    resolved = Page.all.inject([]) {|memo, dbid| memo << Page.get(dbid)}
    @pages = resolved.sort {|x, y| x.no <=> y.no }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def create
    @page = Page.new(title: params[:title], content: params[:content], no: params[:no].to_f)
    respond_to do |format|
      if @page.save
        update_order
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @page = Page.new

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end

  def edit
    @page = Page.find(params[:id].to_i)
  end

  def show
    @page = Page.find(params[:id].to_i)

    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
  end

  def update
    @page = Page.find(params[:id].to_i)

    respond_to do |format|
      if @page.update_attributes(title: params[:title], content: params[:content], no: params[:no].to_f)
        update_order
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.get(params[:id].to_i)
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private
  def update_order
    resolved = Page.all.inject([]) {|memo, dbid| memo << Page.get(dbid)}
    sorted = resolved.sort {|x, y| x.no <=> y.no }
    sorted.each_with_index do |page, index|
      page.update(order: index)
    end
  end
end
