class EventsController < ApplicationController
  def index
    @events = current_user.events.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(events_params)
    @event.created_at = @event.created_at
    @event.user = current_user

    if @event.save
      redirect_to :action => :index, notice: "Goal was saved successfully."
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.assign_attributes(events_params)

    if @event.save
      flash[:notice] = "Post was updated."
      redirect_to :action => :index
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])

     if @event.destroy
       flash[:notice] = "\"#{@event.title}\" was deleted successfully."
       redirect_to :action => :index
     else
       flash.now[:alert] = "There was an error deleting the event."
       render :index
     end
  end

  private

  def events_params
    params.require(:event).permit(:title, :value, :recurring, :recurringtime, :duplicated, :created_at)
  end
end
