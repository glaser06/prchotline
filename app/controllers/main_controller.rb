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
    if method == "other2" then method = params[:altOther2] end
      disposition = params[:disposition]
    if disposition == "other3" then disposition = params[:altOther3] end
    if disposition == "directly" then disposition = params[:directly] end
      callType = params[:callType]
    if callType == "Other" then callType = params[:altOther] end
    callFor = params[:callFor]
    session[:value] = [county, item, callerName, method, disposition, callType, callFor]
    @vals = session[:value]
    if params[:submit_clicked]

      client = DropboxApi::Client.new

      ifInTmpFolder = false

      currentYear = Time.now.year
      currentMonth = Time.now.month
      prcFileName = ""
      if callFor == "PRC"
        prcFileName = "PRCHotlineStatsMonth#{currentMonth}.csv"
      else
        prcFileName = "DEPHotlineStatsMonth#{currentMonth}.csv"
      end

      path = "/#{currentYear}/#{prcFileName}"
      tmpPath = Rails.root.join("tmp/#{prcFileName}")


      if File.exist?(tmpPath) || File.symlink?(tmpPath)
        puts "do something here?"
      else

        results = client.search(prcFileName,"/#{currentYear}")

        if results.matches.count > 0
          path = results.matches.first.resource.path_lower
          monthCSV = ""
          file = client.download(path) do |chunk|
            monthCSV << chunk
          end
          CSV.open(tmpPath, "at") do |csv|
            csv << monthCSV

          end



        end

      end
      # check if file is in tmp folder
      # if not
      # list folder
      # check if current year folder exists
      #   if not create it
      # check if current month file exists
      #   if not create it
      # download file
      # write data to csv
      # upload and override file to dropbox
      CSV.open(tmpPath, "at") do |csv|
        csv << [County.find(county).name.titleize, Item.find(item).name.titleize, callerName, method, disposition, callType, callFor]

      end
      file_content = IO.read tmpPath
      client.upload path, file_content, :mode => :overwrite

      session.delete(:value)
      redirect_to "/", notice: "#{callerName} was added to #{callFor}'s call stats."
    else
        puts "save"
        puts @vals
        redirect_to :back
    end

  end

  def newCall
    if params.has_key?([:callerName])
      callerName = params[:callerName]
      session[:value] = [params[:callerName]]
    end

  end

  def index
    if not session[:value].nil?
      @vals = session[:value]
    else
      @vals = [County.all.first, Item.all.first, "","Flyer", "Referred to Verizon", "Where to recycle", "PRC"]
    end



    # @items = Item.all

    @locations = []
    @errors = " "
    if params[:county]
      @errors = ""
      qCounty = params[:county]
      qItem = params[:item]
      county = County.for_name(qCounty.capitalize)

      if county.blank?

        if params[:county] == ""
          @errors += "Please enter a county"
        else
          @errors += "#{params[:county]} county does not exist"
        end

        return
      end

      # find the item, if it exists
      if params[:item] != ""
        # item query is not empty

        # search for query in Item names
        item = Item.for_name(qItem.downcase)
        # search for query in Alias names
        aliasItem = Alias.for_name(qItem.downcase)

        # if both have not been found, fuzzymatch through both tables and
        # return a correction
        if item.blank? and aliasItem.blank?
          item_match = FuzzyMatch.new(Item.all, :read => :name)
          alias_match = FuzzyMatch.new(Alias.all, :read => :name)
          items = item_match.find(params[:item])
          aliases = alias_match.find(params[:item])
          if !items.nil?
            @errors = "ERROR_MATCH_FOUND"
            @item = items
          elsif !aliases.nil?
            @errors = "ERROR_MATCH_FOUND"
            @item = aliases.item
          else
            @errors += "Could not find #{params[:item]}"

          end
          return
        elsif aliasItem.blank?
          @item = item.first
        elsif item.blank?
          @item = Item.find(aliasItem.first.item_id)
        end
      else
        # If item is empty, redirect to the location page filtered by county
        redirect_to controller: 'locations', action: 'index', county: county[0].name
        return
      end

      if params[:zip] && params[:zip] != ""
        qZip = params[:zip]


        coords = Geocoder.coordinates(qZip)
        # @locations1 = Address.near(coords,50)

        @locations = @item.addresses.near(coords,50)

        # @locations = @item.locations.active.addresses.active.for_zipcode(qZip).alphabetical


      else
        @county = county.first


        @locations = @item.addresses.for_county(@county)
        

      end


      if @locations.blank?
        @errors = "#{@county.name} has no locations"
        return
      else
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
            @locations = loc.by_city
          end

        else
          @locations = @locations.by_name
        end
        @locations = @locations.paginate(:page => params[:page]).per_page(10)
      end

    end


    # if params[:sortby]
    #   sort = params[:sortby]
    #   loc = @locations
    #   if sort == "name"
    #
    #     @locations = loc.by_name
    #   elsif sort == "verified"
    #     @locations = loc.by_verified
    #   elsif sort == "zipcode"
    #     @locations = loc.by_zipcode
    #   elsif sort == "city"
    #     @locations = loc.by_city
    #   end
    #
    #
    # end




  end



end
