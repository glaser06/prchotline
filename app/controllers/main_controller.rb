class MainController < ApplicationController
  def index

    @items = Item.all
    @locations = []
    if params[:county] && params[:item] && params[:zip]
      i,l,c = Item.search(params[:item],params[:county],params[:zip])
      @locations = l
      @context = c
      @item = i
    end
  end
end
