class CountriesController < ApplicationController

  def index
    @countries = Country.all
    respond_to do |format|
      format.html
      format.json { render json: CountryDatatable.new(params, view_context: view_context) }
      format.csv { send_data Country.to_csv, filename: "countries-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
    end
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    Country.import_from_csv(params[:file])

    redirect_to request.referer, notice: 'Import started...'
  end

  def show
    @country = Country.find(params[:id])
  end
 
  def new
    @country = Country.new
  end
 
  def edit
    @country = Country.find(params[:id])
  end
 
  def create
    @country = Country.new(country_params)
 
    if @country.save
      redirect_to @country
    else
      render 'new'
    end
  end
 
  def update
    @country = Country.find(params[:id])
 
    if @country.update(country_params)
      redirect_to @country
    else
      render 'edit'
    end
  end
 
  def destroy
    @country = Country.find(params[:id])
    @country.destroy
 
    redirect_to countries_path
  end

  def status
    raise params.inspect
    country = Country.active
    country = Country.inactive

    render json: { countries: country }
  end

  private
    def country_params
      params.require(:country).permit(:name, :is_active)
    end
  
end
