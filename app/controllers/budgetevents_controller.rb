class BudgeteventsController < ApplicationController
  $futureevents = []
  def index
    @events = current_user.budgetevents.all
  end

  def show
  end

  def new
    @event = Budgetevent.new
  end

  def create
    @event = Budgetevent.create(budgetevents_params)
    @event.user = current_user

    if @event.save
      redirect_to :action => :index, notice: "Event was saved successfully."
    end

    if @event.created_at > Time.now
      $futureevents << @event
      puts $futureevents
    end
  end

  def edit
    @event = Budgetevent.find(params[:id])
  end

  def update
    @event = Budgetevent.find(params[:id])
    @event.assign_attributes(budgetevents_params)

    if @event.save
      flash[:notice] = "Post was updated."
      redirect_to :action => :index
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @event = Budgetevent.find(params[:id])

     if @event.destroy
       flash[:notice] = "\"#{@event.title}\" was deleted successfully."
       redirect_to :action => :index
     else
       flash.now[:alert] = "There was an error deleting the event."
       render :index
     end
  end

  private

  def budgetevents_params
    params.require(:budgetevent).permit(:title, :value, :recurring, :recurringtime, :duplicated, :created_at)
  end
end
