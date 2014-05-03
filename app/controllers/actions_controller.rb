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
  
    respond_to do |format|
      if @action.save
        format.html { redirect_to :back, notice: 'Action was successfully created.' }
        format.js
        format.json { render action: 'show', status: :created, location: @action }
      else
        # This used to be render: action 'new'
        format.html { render action: 'new' }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actions/1
  def update
    if @action.update(action_params)
      if action_params[:action_type] == "Shoot"
        @action.teammate = nil
        @action.end_position_x = nil
        @action.end_position_y = nil
      elsif action_params[:action_type] == "Pass"
        @action.end_position_x = nil
        @action.end_position_y = nil
      end
      @action.save
      @set_play = SetPlay.find_by_id(@action.action_frame.set_play_id)
      redirect_to @set_play
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
      params.require(:new_action).permit(:action_frame, :player, :end_position_x, 
        :end_position_y, :action_type, :teammate)
    end

    def is_invalid(action)
      if action.action_type == 'Move'
        if action.end_position_x == nil || action.end_position_y == nil
          return true
          # Error report, must move somewhere.
        elsif action.end_position_x < 0 || action.end_position_x > 50
          return true
          # Error report, out of bounds.
        elsif action.end_position_y < 0 || action.end_position_y > 47
          return true
          # Error report, out of bounds/backcourt violation.
          # LET THIS BE ALTERED WHEN COURT SIZE IS VARIABLE!!!
        end

      elsif action.action_type == 'Pass'
          unless action.player.has_ball == true
          return true
          # Error report, you must have the ball to pass!
        end
        if action.player_id == action.teammate_id
          return true
          # Error report, cannot pass to yourself
        end
      end
    end
end
