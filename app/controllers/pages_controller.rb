class PagesController < ApplicationController
  def home
    @events = modified_events
  end

  def my_events
    @current_user_events = current_user_modified_events
  end

  private

  def modified_events
    result = []
    Event.find_each do |event|
      if event.period == 'once' || ''
        result.append(event)
      else
        event.starts_at.all_occurrences.each do |date|
          result.append(EventsHelper::ModifiedEvent.new(date, event))
        end
      end
    end
    result
  end

  def current_user_modified_events
    result = []
    User.find(current_user.id).events.each do |event|
      if event.period == 'once' || ''
        result.append(event)
      else
        event.starts_at.all_occurrences.each do |date|
          result.append(EventsHelper::ModifiedEvent.new(date, event))
        end
      end
    end
    result
  end
end
