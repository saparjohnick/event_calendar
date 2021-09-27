class EventsController < ApplicationController
  before_action :user_signed_in?, only: %i[create destroy]
  before_action :correct_user, only: [:destroy]

  def new
    @event = current_user.events.build
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = authorize Event.find(params[:id])
  end

  def create
    @event = EventForm.new(event_params)
    if @event.submit
      redirect_to root_url, notice: "Event created"
    else
      render 'pages/home'
    end
  end

  def update
    authorize Event.find(params[:id])
    @event = EventForm.new(event_params.merge(id: params[:id]))
    if @event.update
      redirect_to root_url, notice: 'Event updated'
    else
      render 'pages/home'
    end
  end

  def destroy
    raise ActiveRecord::RecordNotFound unless @event

    authorize @event
    @event.destroy!
    redirect_to root_url, notice: 'Event deleted.'
  end

  private

  def event_params
    result = params.require(:event).permit(:name, :description, :period, :start_time, :end_time)
    result.merge(user: current_user)
  end

  def correct_user
    @event = current_user.events.find(params[:id])
    redirect_to root_url if @event.nil?
  end
end
