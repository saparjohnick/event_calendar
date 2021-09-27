event:
id: 12,
 created_at: Mon, 06 Sep 2021 17:46:22 UTC +00:00,
 updated_at: Mon, 06 Sep 2021 17:46:22 UTC +00:00,
 name: "New event",
 period: "Monthly",
 user_id: 1,
 description: "New event description",
 start_time: Sun, 05 Sep 2021 00:00:00 UTC +00:00,
 end_time: nil,
 starts_at:
  #<IceCube::Schedule:0x00007ffaa8038630
   @all_exception_rules=[],
   @all_recurrence_rules=
    [#<IceCube::MonthlyRule:0x00007ffaa5304fd8
      @interval=1,
      @start_time=nil,
      @time=nil,
      @uses=0,
      @validations=
       {:interval=>
         [#<IceCube::Validations::MonthlyInterval::Validation:0x00007ffaa5304dd0
           @interval=1>]..., 05 Nov 2025>]}>]

calendar:
  name 
  start_time:datetime 
  end_time:datetime


Нужно перегенерить так, чтобы подставить для каждой даты -- название ивента
event.starts_at.all_occurrences.each do |date|
  new_event.date = date
  new_event.name = name
end

  class.start_time


new idea:
  need helper for create a new class with all events + start_dates (duplicates)
  and show this one class to view
