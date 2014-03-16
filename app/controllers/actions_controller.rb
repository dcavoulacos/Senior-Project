class ActionsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update, :destroy]

  # GET /actions
  def index
    @actions = Action.all
  end

  # GET /actions/1
  def show
  end

  # GET /actions/new
  def new
    @action = Action.new
  end

  # GET /actions/1/edit
  def edit
  end

  # POST /actions
  def create
    @action = Action.new(action_params)

    if @action.save
      redirect_to @action, notice: 'Action was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /actions/1
  def update
    if @action.update(action_params)
      redirect_to @action, notice: 'Action was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /actions/1
  def destroy
    @action.destroy
    redirect_to actions_url, notice: 'Action was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action
      @action = Action.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def action_params
      params.require(:action).permit(:end_x, :end_y, :type)
    end
end
