class MainController < ApplicationController
  def index

    @items = Item.all
    @locations = []
    @errors = " "

    if params[:county] && params[:item]
      @errors = ""

      qCounty = params[:county]
      qItem = params[:item]
      county = County.for_name(qCounty)
      item = Item.for_name(qItem)
      if item.blank?
        @errors += "Could not find #{params[:item]}"
        return
      end
      @item = item[0]
      if county.blank?
        @errors += "#{params[:county]} does not exist"
        return
      end
      @county = county[0]

      if params[:zip] != ""
        qZip = params[:zip]
        # i,l,c = search(qItem, qCounty, qZip)
        @locations = @item.locations.active.for_zipcode(qZip).alphabetical


      else


        @locations = @item.locations.active.for_county(@county.id).alphabetical


      end
      contexts = []
      @locations.each do |loc|
        context = ItemLocation.active.for_item(@item.id).for_location(loc.id)
        contexts.push(context)

      end
      @contexts = contexts
    end
  end

  def validations
    @locations = []
    @countyName = ""
    @items = Item.all
    @counties = County.all
    @item_locations = ItemLocation.all
    if params[:county]
      countyId = params[:county]
      @countyName = County.find(countyId).name
      @locations = Location.all.for_county(countyId).alphabetical
    end
  end

end
