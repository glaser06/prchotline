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


    @items = Item.all
    @locations = []
    @errors = " "
    if params[:county] && params[:item]
      @errors = ""
      qCounty = params[:county]
      qItem = params[:item]
      county = County.for_name(qCounty.capitalize)
      if county.blank?
        puts "ereror"
        @errors += "#{params[:county]} county does not exist"
        return
      end

      item = Item.for_name(qItem.downcase)
      id = 0
      if item.blank?
        item = Alias.for_name(qItem.downcase)
        if item.blank?

          if params[:item] && params[:item] != ""

            names = []
            Item.all.each do |item_row|
              names.push(item_row.name)
            end
            Alias.all.each do |row|
              names.push(row.name)
            end
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
          else
            redirect_to controller: 'locations', action: 'index', county: county[0].name
            return
          end
        else
          id = item.first.item_id
        end
      else
        id = item.first.id

      end


      @item = Item.find(id)

      @county = county[0]
      if params[:zip] != ""
        qZip = params[:zip]
        # i,l,c = search(qItem, qCounty, qZip)

        coords = Geocoder.coordinates(qZip)
        @locations1 = Address.near(coords,50)

        @locations = @item.addresses.near(coords,50).paginate(:page => params[:page]).per_page(10)
        # @locations = @item.locations.active.addresses.active.for_zipcode(qZip).alphabetical


      else
        @county = County.find(county.first.id)

        @locations = @item.addresses.for_county(@county).paginate(:page => params[:page]).per_page(10)

      end

      @locations = @locations.by_active
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
        @locations = loc.by_city
      end
      @locations = @locations.by_active
    end


  end



end
