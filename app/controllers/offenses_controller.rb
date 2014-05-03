class OffensesController < ApplicationController
  before_action :set_offense, only: [:show, :edit, :update, :destroy]

  # GET /offenses
  def index
    @offenses = Offense.all
  end

  # GET /offenses/1
  def show
  end

  # GET /offenses/new
  def new
    @offense = Offense.new
  end

  # GET /offenses/1/edit
  def edit
  end

  # POST /offenses
  def create
    @offense = Offense.new(offense_params)

    if @offense.save
      redirect_to @offense, notice: 'Offense was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /offenses/1
  def update
    if @offense.update(offense_params)
      redirect_to @offense, notice: 'Offense was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /offenses/1
  def destroy
    @offense.destroy
    redirect_to offenses_url, notice: 'Offense was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offense
      @offense = Offense.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offense_params
      params.require(:offense).permit(:name, :pg_x, :pg_y, :pg_ball, :sg_x, :sg_y, :sg_ball, :sf_x, :sf_y, :sf_ball, :pf_x, :pf_y, :pf_ball, :c_x, :c_y, :c_ball)
    end
end
