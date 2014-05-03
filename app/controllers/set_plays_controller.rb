class SetPlaysController < ApplicationController
  before_action :set_set_play, only: [:show, :edit, :update, :destroy]

  # GET /set_plays
  def index
    @set_plays = SetPlay.all
  end

  # GET /set_plays/1
  def show
  end

  # GET /set_plays/new
  def new
    @set_play = SetPlay.new
  end

  # GET /set_plays/1/edit
  def edit
  end

  # POST /set_plays
  def create
    @set_play = SetPlay.new(set_play_params)

    if @set_play.save
      @set_play.action_frames.create(prev_id: -1)
      @set_play.currentAF_id = @set_play.action_frames.last.id
      @set_play.save
      pg = @set_play.players.create(role: "PG",
        position_x: @set_play.offense.pg_x,
        position_y: @set_play.offense.pg_y,
        has_ball: @set_play.offense.pg_ball)
      sg = @set_play.players.create(role: "SG",
        position_x: @set_play.offense.sg_x,
        position_y: @set_play.offense.sg_y,
        has_ball: @set_play.offense.sg_ball)
      sf = @set_play.players.create(role: "SF",
        position_x: @set_play.offense.sf_x,
        position_y: @set_play.offense.sf_y,
        has_ball: @set_play.offense.sf_ball)
      pf = @set_play.players.create(role: "PF",
        position_x: @set_play.offense.pf_x,
        position_y: @set_play.offense.pf_y,
        has_ball: @set_play.offense.pf_ball)
      c = @set_play.players.create(role: "C",
        position_x: @set_play.offense.c_x,
        position_y: @set_play.offense.c_y,
        has_ball: @set_play.offense.c_ball)


      # Create actions for initial action frame. All subsequent actions should
      # be created via the AF controller. 
      @set_play.action_frames.first.actions.create(player_id: pg.id)
      @set_play.action_frames.first.actions.create(player_id: sg.id)
      @set_play.action_frames.first.actions.create(player_id: sf.id)
      @set_play.action_frames.first.actions.create(player_id: pf.id)
      @set_play.action_frames.first.actions.create(player_id: c.id)


      redirect_to @set_play, notice: 'Set play was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /set_plays/1
  def update
    if @set_play.update(set_play_params)
      redirect_to @set_play, notice: 'Set play was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /set_plays/1
  def destroy
    @set_play.destroy
    redirect_to set_plays_url, notice: 'Set play was successfully destroyed.'
  end

  def prevAF
    @set_play = SetPlay.find(params[:id])
    current = ActionFrame.find(@set_play.currentAF_id)
    prev = current.prev
    offense = Offense.find(@set_play.offense_id)
    if prev.prev_id == -1
      @set_play.players.each do |p|
        # Would like to make this a "update_by_offense" method, but that can wait.
        if p.role == "PG"
          p.position_x = offense.pg_x
          p.position_y = offense.pg_y
          p.has_ball = offense.pg_ball
        elsif p.role == "SG"
           p.position_x = offense.sg_x
          p.position_y = offense.sg_y
          p.has_ball = offense.sg_ball
        elsif p.role == "SF"
          p.position_x = offense.sf_x
          p.position_y = offense.sf_y
          p.has_ball = offense.sf_ball
        elsif p.role == "PF"
          p.position_x = offense.pf_x
          p.position_y = offense.pf_y
          p.has_ball = offense.pf_ball
        elsif p.role == "C"
          p.position_x = offense.c_x
          p.position_y = offense.c_y
          p.has_ball = offense.c_ball
        else
        end
        p.save
      end
    else
      moveAF = prev.prev
      # Update positions first from prev's prev values
      moveAF.actions.each do |a|
        p = a.player
        if a.action_type == "Move" || a.action_type == "Screen"
          p.position_x = a.end_position_x
          p.position_y = a.end_position_y
        elsif a.action_type == "Pass"
          # Player passes in initial action frame
          if moveAF.prev_id == -1
            if p.role == "PG"
              p.position_x = offense.pg_x
              p.position_y = offense.pg_y
            elsif p.role == "SG"
              p.position_x = offense.sg_x
              p.position_y = offense.sg_y
            elsif p.role == "SF"
              p.position_x = offense.sf_x
              p.position_y = offense.sf_y
            elsif p.role == "PF"
              p.position_x = offense.pf_x
              p.position_y = offense.pf_y
            elsif p.role == "C"
              p.position_x = offense.c_x
              p.position_y = offense.c_y
            end
            p.save
          # Player passes in other action frame
          else
            pass_positionAF = moveAF.prev
            pass_position_action = pass_positionAF.actions.find_by_player_id(p.id)
            p.position_x = pass_position_action.end_position_x
            p.position_y = pass_position_action.end_position_y
          end
        end
        p.save
      end
      # Update has_ball bool from prev's value
      prev.actions.each do |a|
        p = a.player
        if a.action_type == "Pass"
          p.has_ball = true
          p.save
          teammate = Player.find(a.teammate)
          teammate.has_ball = false
          teammate.save
        end
      end
    end        
    @set_play.currentAF_id = prev.id
    @set_play.save

    redirect_to @set_play, notice: 'Went back one action frame.'
  end

  def nextAF
    @set_play = SetPlay.find(params[:id])
    current = ActionFrame.find(@set_play.currentAF_id)
    if current.next_id == -1
      redirect_to @set_play
    else
      nextAF = ActionFrame.find(current.next_id)

      
      current.actions.each do |a|
        p = a.player
        if a.action_type == "Move" || a.action_type == "Screen"
          p.position_x = a.end_position_x
          p.position_y = a.end_position_y
        elsif a.action_type == "Pass"
          # Player loses ball first
          p.has_ball = false
          # Teammate gains ball second
          teammate = Player.find(a.teammate)
          teammate.has_ball = true
          teammate.save
        elsif a.action_type == "Shoot"
          redirect_to @set_play, notice: 'No new action frame after a shot. How did you get here?'
        else
          redirect_to @set_play, notice: 'Impossible action type found. What did you do..?'
        end
        p.save
      end
      @set_play.currentAF_id = nextAF.id
      @set_play.save

      redirect_to @set_play, notice: 'Went forward one action frame.'
    end
  end

  def end_set_play
    @set_play = SetPlay.find(params[:id])
    current = ActionFrame.find(@set_play.currentAF_id)
    offense = Offense.find(@set_play.offense_id)
    current.next_id = -1
    current.ends_set = true
    current.save
    @set_play.currentAF_id = @set_play.action_frames.first.id
    @set_play.save
    @set_play.players.each do |p|
      # Would like to make this a "update_by_offense" method, but that can wait.
      if p.role == "PG"
        p.position_x = offense.pg_x
        p.position_y = offense.pg_y
        p.has_ball = offense.pg_ball
      elsif p.role == "SG"
         p.position_x = offense.sg_x
        p.position_y = offense.sg_y
        p.has_ball = offense.sg_ball
      elsif p.role == "SF"
        p.position_x = offense.sf_x
        p.position_y = offense.sf_y
        p.has_ball = offense.sf_ball
      elsif p.role == "PF"
        p.position_x = offense.pf_x
        p.position_y = offense.pf_y
        p.has_ball = offense.pf_ball
      elsif p.role == "C"
        p.position_x = offense.c_x
        p.position_y = offense.c_y
        p.has_ball = offense.c_ball
      else
      end
      p.save
    end

    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_play
      @set_play = SetPlay.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def set_play_params
      params.require(:set_play).permit(:id, :name, :offense_id)
    end

    # Update a single player's position and ball bool to initial values
    # def update_by_offense(p_id, o_id)
    #   player = Player.find(p_id)
    #   offense = Offense.find(o_id)
    #   case player
    #   when player.role == "PG"
    #     player.position_x = offense.pg_x
    #     player.position_y = offense.pg_y
    #     player.has_ball = offense.pg_ball
    #   when player.role == "SG"
    #      player.position_x = offense.sg_x
    #     player.position_y = offense.sg_y
    #     player.has_ball = offense.sg_ball
    #   when player.role == "SF"
    #     player.position_x = offense.sf_x
    #     player.position_y = offense.sf_y
    #     player.has_ball = offense.sf_ball
    #   when player.role == "PF"
    #     player.position_x = offense.pf_x
    #     player.position_y = offense.pf_y
    #     player.has_ball = offense.pf_ball
    #   when player.role == "C"
    #     player.position_x = offense.c_x
    #     player.position_y = offense.c_y
    #     player.has_ball = offense.c_ball
    #   else
    #     return
    #   end
    #   player.save      
    # end

    # # Update a single palyer's position and ball bool to value in preceding AF
    # def update_by_AF(player, prevAF_id)
    #   # check this
    #   @action = @prevAF.actions.where(player_id: @player.id)
    #   # puts player
    #   # puts @action.player
    #   if @action.action_type == "Move"

    #   elsif @action.action_type == "Pass"

    #   end
    # end
end
