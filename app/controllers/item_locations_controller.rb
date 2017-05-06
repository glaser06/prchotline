class ItemLocationsController < ApplicationController
  before_action :set_item_location, only: [:show, :edit, :update, :destroy]

  # GET /item_locations
  # GET /item_locations.json
  def index
    @item_locations = ItemLocation.all
  end

  # GET /item_locations/1
  # GET /item_locations/1.json
  def show
  end

  # GET /item_locations/new
  def new
    @item_location = ItemLocation.new
  end

  # GET /item_locations/1/edit
  def edit
  end

  # POST /item_locations
  # POST /item_locations.json
  def create
    #I'm wondering if this create method even works at this point
    #### also gerry?????
    respond_to do |format|
      if @item_location.save
        format.html { redirect_to @item_location, notice: 'Item location was successfully created.' }
        format.json { render :show, status: :created, location: @item_location }
      else
        format.html { render :new }
        format.json { render json: @item_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_locations/1
  # PATCH/PUT /item_locations/1.json
  def update
    respond_to do |format|
      if @item_location.update(item_location_params)
        format.html { redirect_to @item_location, notice: 'Item location was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_location }
      else
        format.html { render :edit }
        format.json { render json: @item_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_locations/1
  # DELETE /item_locations/1.json
  def destroy
    @item_location.destroy
    respond_to do |format|
      format.html { redirect_to item_locations_url, notice: 'Item location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_location
      @item_location = ItemLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_location_params
      params.require(:item_location).permit(:description, :verified, :context, :item_id, :location_id, :active)
    end
end
