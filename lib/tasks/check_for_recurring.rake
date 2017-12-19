require 'rake'

task :check_for_recurring => :environment do
  Event.all.each do |event|
    if event.recurring == true && event.duplicated == false
      puts (event.created_at.localtime.to_date + event.recurringtime.day)
      puts Time.now.localtime.to_date
      if (event.created_at.localtime.to_date + event.recurringtime.day) == Time.now.localtime.to_date
        puts "#{event.title} woopy"
        this_event = Event.create(title: event.title, value: event.value, user_id: event.user_id,
                    recurring: event.recurring, recurringtime: event.recurringtime,
                    duplicated: false)
        this_event.user = event.user
        event.update(duplicated: true)
      end
    end
  end
end
