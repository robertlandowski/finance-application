module BudgeteventsHelper
  def budgetevents_today(events)
    events_today = []
    sum = 0
    events.each do |event|
      if Time.current.to_date == event.created_at.to_date && event.recurringtime <= 1
        events_today << [event.title , event.value]
        sum += event.value
      elsif event.recurringtime > 1
        fractional_value = ((event.value * 1.00) / event.recurringtime).round(2)
        sum += fractional_value
        events_today << [event.title, fractional_value]
      end
    end
    remaining = current_user.budgets[0].daily - sum

    if remaining < 0
      remaining = 0
    end

    events_today << ["Amount Remaining",remaining]
    return events_today.reverse
  end

  def budgetevents_weekly(events)
    events_weekly = []
    sum = 0
    events.each do |event|
      if Time.now.localtime.beginning_of_week < event.created_at.localtime && event.recurringtime <= 7 && Time.now.localtime.end_of_week > event.created_at.localtime
        events_weekly << [event.title , event.value]
        sum += event.value
      elsif event.recurringtime > 7
        fractional_value = (((event.value * 1.00) / event.recurringtime) * 7).round(2)
        sum += fractional_value
        events_weekly << [event.title, fractional_value]
      end
    end
    remaining = current_user.budgets[0].weekly - sum

    if remaining < 0
      remaining = 0
    end

    events_weekly << ["Amount Remaining",remaining]
    return events_weekly.reverse
  end

  def budgetevents_monthly(events)
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
    remaining = current_user.budgets[0].monthly - sum

    if remaining < 0
      remaining = 0
    end

    events_month << ["Amount Remaining",remaining.round(2)]
    return events_month.reverse
  end

  def budgetevents_yearly(events)
    events_year = []
    sum = 0
    events.each do |event|
      if Time.now.localtime.to_date.year == event.created_at.localtime.to_date.year
        events_year << [event.title , event.value]
        sum += event.value
      end
    end
    remaining = current_user.budgets[0].yearly - sum

    if remaining < 0
      remaining = 0
    end

    events_year << ["Amount Remaining",remaining]
    return events_year.reverse
  end

  def daily_percent_complete_budget(events)
    current_amount = budgetevents_today(events)[0][1]
    percent = (current_amount.to_f/current_user.budgets[0].daily) * 100
    return percent.round(2)
  end

  def weekly_percent_complete_budget(events)
    current_amount = budgetevents_weekly(events)[0][1]
    percent = (current_amount.to_f/current_user.budgets[0].weekly) * 100
    return percent.round(2)
  end


  def monthly_percent_complete_budget(events)
    current_amount = budgetevents_monthly(events)[0][1]
    percent = (current_amount.to_f/current_user.budgets[0].monthly) * 100
    return percent.round(2)
  end

  def yearly_percent_complete_budget(events)
    current_amount = budgetevents_yearly(events)[0][1]
    percent = (current_amount.to_f/current_user.budgets[0].yearly) * 100
    return percent.round(2)
  end

  def daily_pace_budget(events)
    sum = 0
    time_passed_percent = 1 - ((Time.now.localtime.end_of_day.to_i - Time.now.localtime.to_i)/86400.00)
    pace = current_user.budgets[0].daily * time_passed_percent
    current_amount = budgetevents_today(events)[1..-1]
    current_amount.each do |val|
      sum += val[1]
    end
    amount_behind = sum - pace
    return amount_behind.round(2)
  end

  def weekly_pace_budget(events)
    sum = 0
    time_passed_percent = 1 - ((Time.now.localtime.end_of_week.to_i - Time.now.localtime.to_i)/604800.00)
    pace = current_user.budgets[0].weekly * time_passed_percent
    current_amount = budgetevents_weekly(events)[1..-1]
    current_amount.each do |val|
      sum += val[1]
    end
    amount_behind = sum - pace
    return amount_behind.round(2)
  end

  def monthly_pace_budget(events)
    sum = 0
    time_passed_percent = 1 - ((Time.now.localtime.end_of_month.to_i - Time.now.localtime.to_i)/2592000.00)
    pace = current_user.budgets[0].monthly * time_passed_percent
    current_amount = budgetevents_monthly(events)[1..-1]
    current_amount.each do |val|
      sum += val[1]
    end
    amount_behind = sum - pace
    return amount_behind.round(2)
  end

  def yearly_pace_budget(events)
    sum = 0
    goal_end_date = current_user.budgets[0].created_at + 365.days
    time_passed_percent = 1 - ((goal_end_date.to_i - Time.now.localtime.to_i)/31536000.00)
    pace = current_user.budgets[0].yearly * time_passed_percent
    current_amount = budgetevents_yearly(events)[1..-1]
    current_amount.each do |val|
      sum += val[1]
    end
    amount_behind = sum - pace
    return amount_behind.round(2)
  end

  def colors_group
    return ['#265C00', 'blue','orange', 'purple', 'red', 'green', 'yellow', 'pink']
  end

  def color_choice(value)
    if value <= 0
      return "green"
    else
      return "red"
    end
  end
end
