class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



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


end
