module WelcomeHelper
  def events_today(events)
    events_today = []
    events.each do |event|
      if Time.now.localtime.to_date == event.created_at.localtime.to_date
        events_today << event.value
      end
    end
    remaining = current_user.goals[0].daily - events_today.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_today.sum],["Amount Remaining", remaining]]
  end

  def events_weekly(events)
    events_week = []
    events.each do |event|
      if Time.now.localtime.beginning_of_week < event.created_at.localtime && Time.now.localtime.end_of_week > event.created_at.localtime
        events_week << event.value
      end
    end
    remaining = current_user.goals[0].weekly - events_week.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_week.sum],["Amount Remaining", remaining]]
  end

  def events_monthly(events)
    events_month = []
    events.each do |event|
      if Time.now.localtime.to_date.month == event.created_at.localtime.to_date.month
        events_month << event.value
      end
    end
    remaining = current_user.goals[0].monthly - events_month.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_month.sum],["Amount Remaining", remaining]]
  end

  def events_yearly(events)
    events_year = []
    events.each do |event|
      if event.created_at > current_user.goals[0].created_at && event.created_at < (current_user.goals[0].created_at + 365.days)
        events_year << event.value
      end
    end
    remaining = current_user.goals[0].yearly - events_year.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_year.sum],["Amount Remaining", remaining]]
  end

  def daily_percent_complete(events)
    current_amount = events_today(events)[0][1]
    percent = (current_amount.to_f/current_user.goals[0].daily) * 100
    return percent.round(2)
  end

  def weekly_percent_complete(events)
    current_amount = events_weekly(events)[0][1]
    percent = (current_amount.to_f/current_user.goals[0].weekly) * 100
    return percent.round(2)
  end


  def monthly_percent_complete(events)
    current_amount = events_monthly(events)[0][1]
    percent = (current_amount.to_f/current_user.goals[0].monthly) * 100
    return percent.round(2)
  end

  def yearly_percent_complete(events)
    current_amount = events_yearly(events)[0][1]
    percent = (current_amount.to_f/current_user.goals[0].yearly) * 100
    return percent.round(2)
  end

  def completion_date(current_user)
    date = current_user.goals[0].created_at + 365.days
    return date.strftime("%B %-d, %Y")
  end

  def grouping_dates(events)
    if events.length <= 3
      return events.reverse.group_by {|i| i.created_at.localtime.to_date}
    else
      events = events.reverse
      return events[0..2].group_by {|i| i.created_at.localtime.to_date}
    end
  end

  def grouping_dates_all(events)
      return events.reverse.group_by {|i| i.created_at.localtime.to_date}
  end

  def daily_pace(events)
    time_passed_percent = 1 - ((Time.now.localtime.end_of_day.to_i - Time.now.localtime.to_i)/86400.00)
    pace = current_user.goals[0].daily * time_passed_percent
    current_amount = events_today(events)[0][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def weekly_pace(events)
    time_passed_percent = 1 - ((Time.now.localtime.end_of_week.to_i - Time.now.localtime.to_i)/604800.00)
    pace = current_user.goals[0].weekly * time_passed_percent
    current_amount = events_weekly(events)[0][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def monthly_pace(events)
    time_passed_percent = 1 - ((Time.now.localtime.end_of_month.to_i - Time.now.localtime.to_i)/2592000.00)
    pace = current_user.goals[0].monthly * time_passed_percent
    current_amount = events_monthly(events)[0][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def yearly_pace(events)
    goal_end_date = current_user.goals[0].created_at + 365.days
    time_passed_percent = 1 - ((goal_end_date.to_i - Time.now.localtime.to_i)/31536000.00)
    pace = current_user.goals[0].yearly * time_passed_percent
    current_amount = events_yearly(events)[0][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def event_color_choice(value)
    if value >= 0
      return "green"
    else
      return "red"
    end
  end
end
