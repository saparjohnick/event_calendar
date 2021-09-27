module EventsHelper
  class ModifiedEvent
    attr_accessor :start_time, :name, :description, :id, :period

    def initialize(start_time, event)
      self.start_time = start_time
      self.name = event.name
      self.id = event.id
      self.description = event.description
      self.period = event.period
    end
  end


end
