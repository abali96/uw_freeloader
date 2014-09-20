class EventsController < ApplicationController
  before_filter :ensure_logged_in
  def index
    @events = Event.all
  end


  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new

    @user_id = current_user.id
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_url
    else
      render :new
    end

    @user_id = current_user.id
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_url
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to :index
  end

  private
  def event_params
    params.require(:event).permit(:name, :food_type, :location, :start_time, :quantity, :quality, :awkwardness, :wait_time, :user_id, :tag_list)
  end


end
