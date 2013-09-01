class PagesController < ApplicationController
  def index
    @pages = Page.all.inject([]) {|memo, page| memo << Page.from_dbid_or_entity(page)}
  end

  def create
    @page = Page.new(title: params[:title], content: params[:content], no: params[:no].to_f)
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  end

  def edit
    @page = Page.from_dbid_or_entity(params[:id].to_i)
  end

  def show
    @page = Page.from_dbid_or_entity(params[:id].to_i)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def update
  end

  def destroy
    @page = Page.get(params[:id].to_i)
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
