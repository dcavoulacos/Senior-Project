class ActionFramesController < ApplicationController
  before_action :set_action_frame, only: [:show, :edit, :update, :destroy]

  # GET /action_frames
  def index
    @action_frames = ActionFrame.all
  end

  # GET /action_frames/1
  def show
    @action_frame = ActionFrame.find(params[:id])
    @action = @action_frame.actions.new
  end

  # GET /action_frames/new
  def new
    @action_frame = ActionFrame.new
  end

  # GET /action_frames/1/edit
  def edit
  end

  # POST /action_frames
  def create
    @action_frame = ActionFrame.new(action_frame_params)

    if @action_frame.save
      redirect_to @action_frame, notice: 'Action frame was successfully created.'
      # Initial position for all players set here FOR NOW!
      @action_frame.players.create(role: "PG", has_ball: true, 
        position_x: 25, position_y: 30)
      @action_frame.players.create(role: "SG", has_ball: false,
        position_x: 2, position_y: 7)
      @action_frame.players.create(role: "SF", has_ball: false,
        position_x: 48, position_y: 7)
      @action_frame.players.create(role: "PF", has_ball: false,
        position_x: 16, position_y: 20)
      @action_frame.players.create(role: "C", has_ball: false,
        position_x: 34, position_y: 20)  

    else
      render action: 'new'
    end
  end

  # PATCH/PUT /action_frames/1
  def update
    if @action_frame.update(action_frame_params)
      redirect_to @action_frame, notice: 'Action frame was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /action_frames/1
  def destroy
    @action_frame.destroy
    redirect_to action_frames_url, notice: 'Action frame was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action_frame
      @action_frame = ActionFrame.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def action_frame_params
      params.require(:action_frame).permit(:action_frame_id)
    end
end
