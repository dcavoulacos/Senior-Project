class ActionFramesController < ApplicationController
  before_action :set_action_frame, only: [:show, :edit, :update, :destroy]

  # GET /action_frames
  def index
    @action_frames = ActionFrame.all
  end

  # GET /action_frames/1
  def show
    @action_frame = ActionFrame.find(params[:id])
    # @new_action = @action_frame.actions.new
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
      # Find AF's set play, and make sure next/prev relation is good.
      @set_play = SetPlay.find(@action_frame.set_play_id)      
      @set_play.currentAF_id = @action_frame.id
      @set_play.save

      prev = ActionFrame.find(@action_frame.prev_id)
      prev.next_id = @action_frame.id
      if prev.ends_set
        prev.ends_set = false
      end
      prev.save
      # Fill any empty prev actions to Move with end_x/y values set
      while prev.has_blank
        prev.actions.each do |a|
          if a.is_blank
            a.action_type = "Move"
            a.end_position_x = a.player.position_x
            a.end_position_y = a.player.position_y
            a.save
          end
        end
      end

      # Make sure new action frame isn't initial action frame, then update players
      if @set_play.action_frames.last.prev_id > 0
      # Update all player positions/ball boolean
        prev.actions.each do |a|
          p = a.player
          # Move/Screen actions first
          if a.action_type == "Move" || a.action_type == "Screen"
            p.position_x = a.end_position_x
            p.position_y = a.end_position_y
          # Pass action
          elsif a.action_type == "Pass"
            if !p.has_ball
              redirect_to @set_play, notice: 'Player must have the ball to pass!'
            else
              # Player loses ball first
              p.has_ball = false
              # Teammate gains ball second
              teammate = Player.find_by_id(a.teammate)
              teammate.has_ball = true
              teammate.save
            end
          # Shoot action should not come up
          # elsif a.action_type == "Shoot"
          #   redirect_to @set_play, notice: 'No new action frame after a shot. How did you get here?'
          # # No other actions should be possible
          # else
          #   redirect_to @set_play, notice: 'Impossible action type found. What did you do..?'
          end
          p.save
        end
      end

      # Create actions for all five players
      @action_frame.actions.create(player_id: @set_play.pg.id)     
      @action_frame.actions.create(player_id: @set_play.sg.id)    
      @action_frame.actions.create(player_id: @set_play.sf.id)
      @action_frame.actions.create(player_id: @set_play.pf.id)
      @action_frame.actions.create(player_id: @set_play.c.id)

      redirect_to @set_play, notice: 'Action frame was successfully created.'

    else
      render action: 'new'
    end
  end

  # PATCH/PUT /action_frames/1
  def update
    if @action_frame.update(action_frame_params)
      redirect_to :back, notice: 'Action frame was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /action_frames/1
  def destroy
    @action_frame.prev.next_id = nil
    @action_frame.prev.save
    @action_frame.set_play.currentAF_id = @action_frame.prev.id
    @action_frame.set_play.save
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
      params.require(:action_frame).permit(:set_play_id, :prev_id)
    end
end
