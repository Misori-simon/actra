module GoalsHelper
  def extract_date
    strftime('%m/%d/%Y')
  end

  def extract_time
    strftime('at %I:%M%p')
  end
end
