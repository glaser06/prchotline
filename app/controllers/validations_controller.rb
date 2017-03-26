class ValidationsController < ApplicationController

  def validations
      @locations = []
      @countyName = ""
      @items = Item.all
      @counties = County.all
      @item_locations = ItemLocation.all

      if params[:county]
        countyId = params[:county]
        @countyName = County.find(countyId).name
        @locations = Location.all.for_county(countyId).alphabetical.paginate(:page => params[:page]).per_page(10)
      end
  end

end