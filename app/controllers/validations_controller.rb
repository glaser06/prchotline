class ValidationsController < ApplicationController

  def validations
      @locations = []
      @countyName = ""
      @items = Item.all
      @counties = County.all
      @item_locations = ItemLocation.all
      locations = []
      if params[:county]
        @county = County.where(name: params[:county]).first
        if not @county.nil?
          @countyName = @county.name
          @countyId = @county.id
          locations = Location.all.for_county(@countyId)

        else
          locations = Location.all
          @locations = "errorMessage"
        end
      else
        locations = Location.all
      end
      if params[:sortby]
        sort = params[:sortby]
        if sort == "county"
          @locations = locations.by_county.alphabetical.paginate(:page => params[:page]).per_page(10)
          # @locations = locations.alphabetical.paginate(:page => params[:page]).per_page(10)
        elsif sort == "name"
          @locations = locations.alphabetical.paginate(:page => params[:page]).per_page(10)
        elsif sort == "verified"
          @locations = locations.by_updated.paginate(:page => params[:page]).per_page(10)
        elsif sort == "city"
          @locations = locations.by_city.alphabetical.paginate(:page => params[:page]).per_page(10)
        elsif sort == "zipcode"
          @locations = locations.by_zipcode.alphabetical.paginate(:page => params[:page]).per_page(10)
        end
        puts "woah it works"

      else
        @locations = locations.alphabetical.paginate(:page => params[:page]).per_page(10)
      end

  end

end
