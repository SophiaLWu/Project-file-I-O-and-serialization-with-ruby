require "csv"
require "sunlight/congress"
require "erb"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.gsub(/[^0-9]/, "")
  phone_number_length = phone_number.length

  if phone_number_length == 11 && phone_number[0] == "1"
    phone_number.slice!(0)
  elsif phone_number_length != 10
    phone_number = "0000000000"  
  end

  phone_number
end

def find_peak(counts)
  counts.key(counts.values.max)
end

def add_to_counts(counts, item)
  if counts[item]
    counts[item] += 1
  else
    counts[item] = 1
  end
end

def find_hour_of_day(registration_date)
  date = DateTime.strptime(registration_date, "%m/%d/%y %H:%M")
  date.hour
end

def find_day_of_week(registration_date)
  date = DateTime.strptime(registration_date, "%m/%d/%y %H:%M")
  date.cwday
end

def convert_day_of_week_to_string(weekday)
  case weekday
  when 1
    "Monday"
  when 2
    "Tuesday"
  when 3
    "Wednesday"
  when 4
    "Thursday"
  when 5
    "Friday"
  when 6
    "Saturday"
  when 7
    "Sunday"
  end
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, \
                                           header_converters: :symbol

template_letter = File.read "form_letter.html"
erb_template = ERB.new template_letter
hours = {}
days = {}

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])

  hour = find_hour_of_day(row[:regdate])
  add_to_counts(hours, hour)

  day = convert_day_of_week_to_string(find_day_of_week(row[:regdate]))
  add_to_counts(days, day)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end

peak_hour = find_peak(hours)
peak_day = find_peak(days)

puts "The peak hour of the day that people registered was #{peak_hour}."
puts "The peak day of the week that people registered was #{peak_day}."

