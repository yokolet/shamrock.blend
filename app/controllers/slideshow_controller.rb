class SlideshowController < ApplicationController
  def index
    page = Page.get(Page.where(order: 0).first)
    @title = page.title
    @content = Haml::Engine.new(page.content).render
    @number_of_pages = Page.all.length
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @no = params[:id].to_i
    page = Page.get(Page.where(order: @no).first)
    @number_of_pages = Page.all.length
    @title = page.title
    @content = Haml::Engine.new(page.content).render
    puts "#{page.title}, #{page.content}"
    puts @content
    respond_to do |format|
      format.html
      format.js
    end
  end
end
