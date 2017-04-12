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

    if params[:submit_clicked]
      if params[:callerName] && params[:method] && params[:disposition] && params[:county]&& params[:method] && params[:purpose] && params[:type]
        CSV.open('call_stats.csv', "at") do |csv|
          csv << [callerName, method, County.find(county).name.titleize, Item.find(item).name.titleize, disposition, purpose, type]
        end
      end
      session.delete(:value)
      redirect_to "/"
    end
  end

  def newCall
    if params.has_key?([:callerName]) # && params[:method] && params[:disposition] && params[:county]&& params[:method] && params[:purpose] && params[:type]
      callerName = params[:callerName]
      # method = params[:method]
      # disposition = params[:disposition]
      # county = params[:county]
      # item = params[:item]
      # method = params[:method]
      # purpose = params[:purpose]
      # type = params[:type]
      session[:value] = [callerName]#, method, disposition, county, item, method, purpose, type]
      puts "newCall"

    end
    puts "everything"
    @vals = session[:value]
    puts @vals

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
        puts "ereror2"
        return
      end
      @item = Item.find(item.first.item_id)
      if county.blank?
        puts "ereror"
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
        #for_county, -> (id) { where('county_id=?', id) }
        @county = County.find(county.first.id)
        #@locations = Location.for_county(@county).for_item(@item).joins(:addresses)
        
        @locations = @item.addresses.for_county(@county).paginate(:page => params[:page]).per_page(10)
        #@locations = @item.addresses.paginate(:page => params[:page]).per_page(10)
        #coords = Geocoder.coordinates("#{@county.name} County")
        #puts coords
        #@locations = @item.addresses.near(coords, 50).paginate(:page => params[:page]).per_page(10)
        # @locations = @item.locations.active.for_county(@county.id).alphabetical


      end
      contexts = []
      @locations.each do |loc|
        context = ItemLocation.active.for_item(@item.id).for_location(loc.location_id).first
        contexts.push(context)
      end
      @contexts = contexts
    end
    if params[:sortby]
      sort = params[:sortby]
      loc = @locations
      if sort == "name"

        @locations = loc.by_name
      elsif sort == "verified"
        @locations = loc.by_verified
      elsif sort == "zipcode"
        @locations = loc.by_zipcode
      elsif sort == "city"
        puts ""
      end
    end
  end


end
