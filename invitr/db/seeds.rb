user = User.create!(name: "Will",
                    password: ENV['TEST_PASS'] ,
                    password_confirmation: ENV['TEST_PASS'],)

user.hosted_events.build(title: "Invitr Launch Party!",
                         date: (10.days.from_now)).save

user.hosted_events.build(title: "Invitr Anniversary Party!",
                         date: (1.year.from_now)).save
                          
user.hosted_events.build(title: "UnBirthday Party",
                         date: (rand(1...365).days.from_now)).save

15.times do
  name = Faker::Games::Witcher.character.gsub(/\s+/, "")
  password = ENV['TEST_PASS']
  user = User.create(name: name,
                     password: password,
                     password_confirmation: password)
  2.times do
    title = "#{Faker::Games::Witcher.location} #{Faker::Verb.base}"
    date = rand(-30..100).days.from_now
    user.hosted_events.build(title: title,
                              date: date).save
  end
end

100.times do
  user = User.order('RANDOM()').first
  event = Event.order('RANDOM()').first
  attendees = event.attendees
  unless attendees.include?(user) || user == event.host
    event.invitations.build(attendee_id: user.id,
                            status: "accepted").save
  end
end

100.times do
  user = User.order('RANDOM()').first
  event = user.hosted_events.order('RANDOM()').first
  invitee = User.order('RANDOM()').first
  unless user == invitee || event.attendees.include?(invitee)
    event.invitations.build(attendee_id: invitee.id).save
  end
end