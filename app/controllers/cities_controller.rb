class CitiesController < ApplicationController
  def index
    @cities = City.all
    respond_to do |format|
      format.html
      format.json { render json: CityDatatable.new(params, view_context: view_context) }
      format.csv { send_data City.to_csv, filename: "cities-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
    end
  end

 def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    City.import_from_csv(params[:file])

    redirect_to request.referer, notice: 'Import started...'
 end
 
  def show
    @city = City.find(params[:id])
  end
 
  def new
    @city = City.new
  end
 
  def edit
    @city = City.find(params[:id])
  end
 
  def create
    @city = City.new(city_params)
 
    if @city.save
      redirect_to @city
    else
      render 'new'
    end
  end
 
  def update
    @city = City.find(params[:id])
 
    if @city.update(city_params)
      redirect_to @city
    else
      render 'edit'
    end
  end
 
  def destroy
    @city = City.find(params[:id])
    @city.destroy
 
    redirect_to cities_path
  end
 
  private
    def city_params
      params.require(:city).permit(:name, :is_active, :country_id, :state_id)
    end
  
end
