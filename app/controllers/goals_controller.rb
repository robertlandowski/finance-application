class GoalsController < ApplicationController
  def index
    @goals = Goal.all
  end

  def show
    # @goals = Goal.all
  end

  def create
    @goals = Goal.create(goals_params)
    @goals.user = current_user
    @goals.monthly = (@goals.yearly)/12
    @goals.weekly = (@goals.yearly)/52
    @goals.daily = (@goals.yearly)/365


    if @goals.created_at.to_date >= Time.now.to_date && @goals.save
      redirect_to welcome_index_path, notice: "Goal was saved successfully."
    else
      redirect_to :action => :new, notice: "Error YO!"
    end
  end

  def new
    @goals = Goal.new
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update_columns(goals_params)
    @goal.update(:weekly => @goal.yearly.to_i/52)
    @goal.update(:monthly => @goal.yearly.to_i/12)
    @goal.update(:daily => @goal.yearly.to_i/365)

    if @goal.save
      flash[:notice] = "Goal was updated."
      redirect_to :action => :index
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def goals_params
    params.require(:goal).permit(:yearly, :monthly, :weekly, :daily,:created_at)
  end
end
