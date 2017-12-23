module WelcomeHelper
  def events_today(events)
    events_today = []
    divided_value = []
    events.each do |event|
      if Time.now.localtime.to_date == event.created_at.localtime.to_date && event.recurringtime <= 1
        events_today << event.value
      elsif event.recurringtime > 1 && (event.created_at.to_date + event.recurringtime.days) > Time.now.localtime.to_date
        puts "This is the event: #{event.title}"
        puts "this is the event: #{event.value}"
        puts "this is the #{event.recurringtime}"
        divided_value << ((1.00 * event.value)/event.recurringtime)
      end
    end
    remaining = current_user.goals[0].daily - events_today.sum - divided_value.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_today.sum.round(2)],["Amount Remaining", remaining.round(2)],["Expected Earnings", divided_value.sum.round(2)]]
  end

  def events_weekly(events)
    events_week = []
    divided_value = []
    events.each do |event|
      if Time.now.localtime.beginning_of_week < event.created_at.localtime && Time.now.localtime.end_of_week > event.created_at.localtime && event.recurringtime < 14
        events_week << event.value
      elsif event.recurringtime == 14 || event.recurringtime == 30 || event.recurringtime == 365
        divided_value << (((1.00 * event.value)/event.recurringtime) * 7.00)
      end
    end
    remaining = current_user.goals[0].weekly - events_week.sum - divided_value.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_week.sum.round(2)],["Amount Remaining", remaining.round(2)],["Expected", divided_value.sum.round(2) ]]
  end

  def events_monthly(events)
    events_month = []
    divided_value = []
    events.each do |event|
      if Time.now.localtime.to_date.month == event.created_at.localtime.to_date.month && event.recurringtime <= 30
        events_month << event.value
      elsif event.recurringtime == 365
        divided_value << (((1.00 * event.value)/event.recurringtime) * 30.00)
      end
    end
    remaining = current_user.goals[0].monthly - events_month.sum - divided_value.sum

    if remaining < 0
      remaining = 0
    end

    return [["Amount Earned", events_month.sum],["Amount Remaining", remaining.round(2)],["Expected", divided_value.sum.round(2) ]]
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
    current_amount = events_today(events)[0][1] + events_today(events)[-1][1]
    percent = (current_amount.to_f/current_user.goals[0].daily) * 100
    return percent.round(2)
  end

  def weekly_percent_complete(events)
    current_amount = events_weekly(events)[0][1] + events_weekly(events)[-1][1]
    percent = (current_amount.to_f/current_user.goals[0].weekly) * 100
    return percent.round(2)
  end


  def monthly_percent_complete(events)
    current_amount = events_monthly(events)[0][1] + events_monthly(events)[-1][1]
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
    current_amount = events_today(events)[0][1] + events_today(events)[-1][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def weekly_pace(events)
    time_passed_percent = 1 - ((Time.now.localtime.end_of_week.to_i - Time.now.localtime.to_i)/604800.00)
    pace = current_user.goals[0].weekly * time_passed_percent
    current_amount = events_weekly(events)[0][1]+ events_weekly(events)[-1][1]
    amount_behind = current_amount - pace
    return amount_behind.round(2)
  end

  def monthly_pace(events)
    time_passed_percent = 1 - ((Time.now.localtime.end_of_month.to_i - Time.now.localtime.to_i)/2592000.00)
    pace = current_user.goals[0].monthly * time_passed_percent
    current_amount = events_monthly(events)[0][1] + events_monthly(events)[-1][1]
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

  def switch_events_today(events)
    events_today = []
    sum = 0
    events.each do |event|
      if Time.now.localtime.to_date == event.created_at.localtime.to_date && event.recurringtime <= 1
        events_today << [event.title , event.value]
        sum += event.value
      elsif event.recurringtime > 1
        fractional_value = ((event.value * 1.00) / event.recurringtime).round(2)
        sum += fractional_value
        events_today << [event.title, fractional_value]
      end
    end
    remaining = current_user.goals[0].daily - sum

    if remaining < 0
      remaining = 0
    end

    events_today << ["Amount Remaining",remaining.round(2)]
    return events_today.reverse
  end

  def switch_events_weekly(events)
    events_weekly = []
    sum = 0
    events.each do |event|
      if Time.now.localtime.beginning_of_week < event.created_at.localtime && event.recurringtime <= 7 && Time.now.localtime.end_of_week > event.created_at.localtime
        events_weekly << [event.title , event.value]
        sum += event.value
      elsif event.recurringtime == 14 || event.recurringtime == 30 || event.recurringtime == 365
        fractional_value = (((event.value * 1.00) / event.recurringtime) * 7).round(2)
        sum += fractional_value
        events_weekly << [event.title, fractional_value]
      end
    end
    remaining = current_user.goals[0].weekly - sum

    if remaining < 0
      remaining = 0
    end

    events_weekly << ["Amount Remaining",remaining.round(2)]
    return events_weekly.reverse
  end

  def switch_events_monthly(events)
    events_month = []
    sum = 0
    events.each do |event|
      if (Time.now.localtime.to_date.month == event.created_at.localtime.to_date.month) && event.recurringtime <= 30
        events_month << [event.title , event.value]
        sum += event.value
      elsif event.recurringtime > 30
        fractional_value = ((event.value * 1.00) / event.recurringtime).round(2)
        sum += (fractional_value * 30)
        events_month << [event.title, fractional_value]
      end
    end
    remaining = current_user.goals[0].monthly - sum

    if remaining < 0
      remaining = 0
    end

    events_month << ["Amount Remaining",remaining]
    return events_month.reverse
  end

  def switch_events_yearly(events)
    events_year = []
    sum = 0
    events.each do |event|
      if Time.now.localtime.to_date.year == event.created_at.localtime.to_date.year
        events_year << [event.title , event.value]
        sum += event.value
      end
    end
    remaining = current_user.goals[0].yearly - sum

    if remaining < 0
      remaining = 0
    end

    events_year << ["Amount Remaining",remaining]
    return events_year.reverse
  end

  def event_totals(events, budgets)
    events_sum = 0
    budgets_sum = 0
    events.each do |event|
      if Time.now.localtime.to_date.year == event.created_at.localtime.to_date.year
        events_sum += event.value
      end
    end

    budgets.each do |budget|
      if Time.now.localtime.to_date.year == budget.created_at.localtime.to_date.year
        budgets_sum += budget.value
      end
    end

    savings = (events_sum - budgets_sum).round(2)
    if savings < 0
      savings = 0
    end
    return [["Savings",savings], ["Spending",budgets_sum.round(2)]]
  end

  def colors_group_switch
    return ['#F1F1F2', 'blue','orange', 'purple', 'red', 'green', 'yellow', 'pink', '#A4E8E8', '#A4CBE8', '#7277DF','#B272DF','#DD72DF','#B6031B', '#000', '#AD72DF','#06F556','#FF8F00','#FF000F']
  end

  def event_color_choice(value)
    if value >= 0
      return "green"
    else
      return "red"
    end
  end
end
