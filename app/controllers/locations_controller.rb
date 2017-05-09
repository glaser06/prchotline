class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    # @l = Location.all.to_a
    # @locations = Location.all.paginate(:page => params[:page]).per_page(20)
    # @item_locations = ItemLocation.by_item.all
    @errors = ""
    # @l = Location.all.to_a
    # @locations = Location.all.paginate(:page => params[:page]).per_page(20)
    # @item_locations = ItemLocation.by_item.all

    if params[:validate] && params[:validate] != ""
      puts "stuff"
    end
    # @locations = []
    @countyName = ""
    allLocations = Location.all
    # @items = Item.all
    # @counties = County.all
    @item_locations = ItemLocation.all
    locations = []
    if params[:county] && params[:county] != ""

      @county = County.where(name: params[:county].capitalize).first
      if not @county.nil?
        @countyName = @county.name
        @countyId = @county.id
        locations = allLocations.for_county(@countyId)
        unless locations.blank?
          locations = allLocations.for_county(@countyId).distinct
        end

        puts @countyName
      else
        locations = allLocations
        @errors = "#{params[:county]} does not exist"
        # @locations = []

        return
      end
    else

      locations = allLocations
    end
    if params[:sortby] && params[:sortby] != ""
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
      elsif sort == "active"
        @locations = locations.by_active.alphabetical.paginate(:page => params[:page]).per_page(10)
      end
      puts "woah it works"

    else
      @locations = locations.alphabetical.paginate(:page => params[:page]).per_page(10)
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @item_locations = @location.item_locations.by_item.to_a
  end

  # GET /locations/new
  def new
    @location = Location.new
    @location.item_locations.build
    @location.addresses.build
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    puts location_params
    # @item_location.verified = Date.today
    # puts @item_location.verified
    # @item_location.context = "hullo we trying"
    # puts @item_location.context
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|

      if @location.update(location_params)
        if params[:redirect] == "true"
          format.html { redirect_to :back, notice: 'Location was successfully validated.' }
          format.json { render :show, status: :ok, location: @location }
        else
          format.html { redirect_to @location, notice: 'Location was successfully updated.' }
          format.json { render :show, status: :ok, location: @location }
        end

      else
        @location.reload
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params

      params.require(:location).permit(:name, :phone, :website, :verified, :active, :details, addresses_attributes: [:id, :location_id, :county_id, :address, :city, :zipcode, :active, :_destroy], item_locations_attributes: [:id, :item_id, :location_id, :active, :description, :_destroy, :verified, :context])

    end
end
