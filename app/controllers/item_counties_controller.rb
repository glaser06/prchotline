class ItemCountiesController < ApplicationController
  before_action :set_item_county, only: [:show, :edit, :update, :destroy]

  # GET /item_counties
  # GET /item_counties.json
  def index
    @item_counties = ItemCounty.all
  end

  # GET /item_counties/1
  # GET /item_counties/1.json
  def show
  end

  # GET /item_counties/new
  def new
    @item_county = ItemCounty.new
  end

  # GET /item_counties/1/edit
  def edit
  end

  # POST /item_counties
  # POST /item_counties.json
  def create
    @item_county = ItemCounty.new(item_county_params)
    respond_to do |format|
      if @item_county.save
        format.html { redirect_to @item_county, notice: 'Item county was successfully created.' }
        format.json { render :show, status: :created, location: @item_county }
      else
        format.html { render :new }
        format.json { render json: @item_county.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_counties/1
  # PATCH/PUT /item_counties/1.json
  def update
    respond_to do |format|
      if @item_county.update(item_county_params)
        format.html { redirect_to @item_county, notice: 'Item county was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_county }
      else
        format.html { render :edit }
        format.json { render json: @item_county.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_counties/1
  # DELETE /item_counties/1.json
  def destroy
    @item_county.destroy
    respond_to do |format|
      format.html { redirect_to item_counties_url, notice: 'Item county was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_county
      @item_county = ItemCounty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_county_params
      params.require(:item_county).permit(:description, :county_id, :item_id)
    end
end
