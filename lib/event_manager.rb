require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zip(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone(phone_number)
  phone_number = phone_number.delete('^0-9')
  length = phone_number.length

  phone_number = nil if length > 11 || length < 10

  if length == 11
    phone_number = phone_number[0..9] if phone_number[0] == '1'
    phone_number = nil if phone_number[0] != '1'
  end

  phone_number
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue
    'Find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exist? 'output'

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

contents = CSV.open 'event_attendees.csv', headers: true,
                                           header_converters: :symbol

template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zip(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end
