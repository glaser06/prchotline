class ValidationsController < ApplicationController

  def validations
      puts "here"
      @locations = []
      @countyName = ""
      @items = Item.all
      @counties = County.all
      @item_locations = ItemLocation.all

      puts params[:tab]
      if params[:tab]
        #countyName = params[:county]
        @county = County.where(name: params[:tab]).first
        #County.find(countyId).name
        @countyName = @county.name
        puts @county
        puts @countyName
        @countyId = @county.id
        @locations = Location.all.for_county(@countyId).alphabetical.paginate(:page => params[:page]).per_page(10)
      end
  end

end