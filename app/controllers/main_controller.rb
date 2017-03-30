require 'csv'

class MainController < ApplicationController


  def clear_form
    session.delete(:value)
    redirect_to :back
  end

  def submit_form
    callerName = params[:callerName]
    method = params[:method]
    disposition = params[:disposition]
    county = params[:county]
    item = params[:item]
    method = params[:method]
    purpose = params[:purpose]
    type = params[:type]

    session[:value] = [callerName, method, disposition, county, item, method, purpose, type]
    vals = session[:value]
    puts "submit_form"
    puts vals
    if params[:callerName] && params[:method] && params[:disposition] && params[:county]&& params[:method] && params[:purpose] && params[:type]
    CSV.open('call_stats.csv', "at") do |csv|
      csv << [callerName, method, County.find(county).name.titleize, Item.find(item).name.titleize, disposition, purpose, type]
    end

    session.delete(:value)
    redirect_to "/"

  end

  def newCall
      callerName = params[:callerName]
      method = params[:method]
      disposition = params[:disposition]
      county = params[:county]
      item = params[:item]
      method = params[:method]
      purpose = params[:purpose]
      type = params[:type]

      session[:value] = [callerName, method, disposition, county, item, method, purpose, type]
      @vals = session[:value]
      puts "newCall"
      puts vals
      # @value = session[:value]


    end
  end

  def index
    @items = Item.all
    @locations = []
    @errors = " "
    if params[:county] && params[:item]
      @errors = ""
      qCounty = params[:county]
      qItem = params[:item]
      county = County.for_name(qCounty.capitalize)

      item = Item.find(Alias.for_name(qItem.downcase).first.item_id)

      if item.blank?
        @errors += "Could not find #{params[:item]}"
        return
      end
      @item = item
      if county.blank?
        @errors += "#{params[:county]} does not exist"
        return
      end
      @county = county[0]
      if params[:zip] != ""
        qZip = params[:zip]
        # i,l,c = search(qItem, qCounty, qZip)

        coords = Geocoder.coordinates(qZip)
        @locations1 = Address.near(coords,50)

        @locations = @item.addresses.near(coords,50)
        # @locations = @item.locations.active.addresses.active.for_zipcode(qZip).alphabetical


      else


        # @locations = @item.locations.active.for_county(@county.id).alphabetical


      end
      contexts = []
      @locations.each do |loc|
        context = ItemLocation.active.for_item(@item.id).for_location(loc.id).first
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
