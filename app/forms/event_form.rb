class EventForm
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_reader :user, :name, :start_time, :end_time, :description, :period
  attr_accessor :starts_at, :schedule

  VALIDATION_ATTRIBUTES = %i[
    user
    name
    period
    start_time
    end_time
  ].freeze

  VALIDATION_ATTRIBUTES.each do |attribute|
    validates attribute, presence: true
  end

  def initialize(params)
    @user = params[:user]
    @name = params[:name]
    @start_time = DateTime.parse(params[:start_time])
    @end_time = params[:end_time].present? ? DateTime.parse(params[:end_time]) : @start_time
    @description = params[:description]
    @period = params[:period]
    @schedule = IceCube::Schedule.new(Time.now)
  end

  def submit
    return invalidate_form unless user_and_content_provided?

    if valid? && period == 'once'
      create_permanent_event
    else
      create_reccurrent_event
    end
  end

  def update
    return invalidate_form unless user_and_content_provided?

    if valid? && period == 'once'
      update_permanent_event
    else
      update_reccurrent_event
    end
  end

  private

  def invalidate_form
    VALIDATION_ATTRIBUTES.each do |attribute|
      errors.add(attribute, :blank, message: 'cannot be nil') if send(attribute.to_s).nil?
    end
    false
  end

  def update_reccurrent_event
    start_times(period)
    starts_at = schedule
    user.events.update(user: user, name: name, description: description, period: period, starts_at: starts_at, start_time: start_time, end_time: end_time)
  end

  def update_permanent_event
    user.events.update(user: user, name: name, description: description, period: period, start_time: start_time, end_time: end_time)
  end

  def user_and_content_provided?
    return false unless user

    name.present?
  end

  def create_reccurrent_event
    start_times(period)
    starts_at = schedule
    user.events.create(user: user, name: name, description: description, period: period, starts_at: starts_at, start_time: start_time, end_time: end_time)
  end

  def start_times(interval)
    schedule.add_recurrence_rule IceCube::Rule.send(interval).until(end_time)
  end

  def create_permanent_event
    user.events.create(user: user, name: name, description: description, period: period, start_time: start_time, end_time: end_time)
  end
end
