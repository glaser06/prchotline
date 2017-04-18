require 'csv'

class MainController < ApplicationController


  def clear_form
    session.delete(:value)
    redirect_to :back
  end

  def submit_form
    county = params[:county]
    item = params[:item]
    callerName = params[:callerName]
    if callerName == "" then callerName = "Anonymous" end
    method = params[:method]
    disposition = params[:disposition]
    type = params[:type]
    callFor = params[:callFor]
    session[:value] = [County.find(county).name.titleize, Item.find(item).name.titleize, callerName, method, disposition, type, callFor]
    vals = session[:value]

    if params[:submit_clicked]
      if callFor == "PRC"
        CSV.open('PRCcall_stats.csv', "at") do |csv|
          csv << session[:value]
          end
      else
        CSV.open('DEPcall_stats.csv', "at") do |csv|
          csv << session[:value]
        end
      end
      session.delete(:value)
      redirect_to "/", notice: "#{callerName} was added to #{callFor}'s call stats."
    end
  end

  def newCall
    if params.has_key?([:callerName])
      callerName = params[:callerName]
      session[:value] = [params[:callerName]]
    end
    @vals = session[:value]
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
           @locations = @item.addresses.near(coords, 50).paginate(:page => params[:page]).per_page(10)
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
