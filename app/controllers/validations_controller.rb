class ValidationsController < ApplicationController

  def validations
      @locations = []
      @countyName = ""
      @items = Item.all
      @counties = County.all
      @item_locations = ItemLocation.all

      if params[:county]
        @county = County.where(name: params[:county]).first
        if not @county.nil?
          @countyName = @county.name
          @countyId = @county.id
          @locations = Location.all.for_county(@countyId).alphabetical.paginate(:page => params[:page]).per_page(10)
        else
          @locations = "errorMessage"
        end
      end
      if params[:sortby]
        puts "woah it works"
      end
  end

end
