class EventsController < ApplicationController
  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def new
    @event = Event.new
  end

  def create
    @current_user = current_user
    @event = @current_user.hosted_events.build(event_params)
    if @event.save
      flash[:success] = "Event created"
      redirect_to @event
    else
      flash.now[:danger] = @event.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @current_user = current_user

    @invitation = if @event.host?(@current_user)
                    Invitation.new
                  else
                    Invitation.find_or_initialize_by(event: @event,
                                                     attendee: @current_user)
                  end
  end

  private

    def event_params
      params.require(:event).permit(:title, :date)
    end
end
