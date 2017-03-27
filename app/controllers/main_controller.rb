require 'csv'

class MainController < ApplicationController

  def clear_form
    reset_session
  end

  def newCall
      if session[:visit_count].nil?
        session[:visit_count] = 1
      else
        session[:visit_count] += 1
      end
      @visit_count = session[:visit_count]
      puts @visit_count

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
      puts @vals

      if params[:callerName] && params[:method] && params[:disposition] && params[:county]&& params[:method] && params[:purpose] && params[:type]
      CSV.open('call_stats.csv', "at") do |csv|
        csv << [callerName, method, county, item, disposition, purpose, type]
      end
      redirect_to "/"
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

      item = Alias.for_name(qItem.downcase)

      if item.blank?
        @errors += "Could not find #{params[:item]}"
        return
      end
      @item = Item.find(item.first.item_id)
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

        @locations = @item.addresses.near(coords,50).paginate(:page => params[:page]).per_page(10)
        # @locations = @item.locations.active.addresses.active.for_zipcode(qZip).alphabetical


      else

        coords = Geocoder.coordinates("#{@county.name} County")
        @locations = @item.addresses.near(coords, 50)
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

end
