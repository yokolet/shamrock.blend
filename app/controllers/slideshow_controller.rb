class SlideshowController < ApplicationController
  def index
    @page = Page.get(Page.where(order: 0).first)
    @number_of_pages = Page.all.length
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @no = params[:id].to_i
    @page = Page.get(Page.where(order: @no).first)
    @number_of_pages = Page.all.length
    respond_to do |format|
      format.html
      format.js
    end
  end
end
