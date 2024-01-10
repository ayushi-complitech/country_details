class StatesController < ApplicationController
  def index
    @states = State.all
    respond_to do |format|
      format.html
      format.json { render json: StateDatatable.new(params, view_context: view_context) }
      format.csv { send_data State.to_csv, filename: "states-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
    end
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    State.import_from_csv(params[:file])

    redirect_to request.referer, notice: 'Import started...'
  end
 
  def show
    @state = State.find(params[:id])
  end
 
  def new
    @state = State.new
  end
 
  def edit
    @state = State.find(params[:id])
  end
 
  def create
    @state = State.new(state_params)
 
    if @state.save
      redirect_to @state
    else
      render 'new'
    end
  end
 
  def update
    @state = State.find(params[:id])
 
    if @state.update(state_params)
      redirect_to @state
    else
      render 'edit'
    end
  end
 
  def destroy
    @state = State.find(params[:id])
    @state.destroy
 
    redirect_to states_path
  end

  def fetch_states
    country = Country.find(params[:country_id])
    states = country.states

    render json: { states: states }
  end
 
  private
    def state_params
      params.require(:state).permit(:name, :abbreviation, :is_active, :country_id)
    end
  
end
