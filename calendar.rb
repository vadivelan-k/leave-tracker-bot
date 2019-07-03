module Calendar
  def dates_array(d = nil)
    d = d || Date.today
    start_of_month = (d - d.mday + 1)
    end_of_month = start_of_month.next_month.prev_day

    start_day = start_of_month.day
    end_day = end_of_month.day
    days = (start_day..end_day).to_a.map(&:to_s)

    (start_of_month.cwday - 1).times do
      days.unshift('-')
    end

    (end_of_month.cwday - 1).times do
      days.push('-')
    end

    days.each_slice(7).to_a
  end
end