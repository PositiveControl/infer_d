require 'date'

class DateParser
  def self.infer_format(array)
    dates = Array(array).map { |date_string|
      date_string.split(/(\/|-)/).first
    }
    if dates.all? { |d| d.length == 4 }
      :ymd
    elsif dates.all? { |d| d.to_i <= 12 && d.to_i > 0 }
      :mdy
    else
      :alpha_dmy
    end
  end

  def self.parse(string, date_format)
    case date_format
    when :ymd
      Date.strptime(string, '%Y/%m/%d')
    when :alpha_dmy
      Date.parse(string)
    when :mdy
      Date.strptime(string, '%m/%d/%Y')
    end
  end
end
