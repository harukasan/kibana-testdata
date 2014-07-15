require 'json'
require 'faker'

I18n.enforce_available_locales = false

class FakeEvents
  def initialize
    @i = 0
    @users = self.generateUsers
    @locations = self.generateLocations
    @time = Time.now - 24*60*60 # 1日前から
  end

  def generateEvent
    events = []
    @time += (10 * (Math.cos(@i / 100.0 / (3..5).to_a.sample) + 1)).to_i # 時間を適当に進める
    (1..10).to_a.sample.times do
      @time += [0,0,1].sample # 時間を適当にすすめる
      location = @locations.sample # 位置情報を1つ取得
      user = @users.sample # ユーザを1つ取得
      events << {
        time: @time,
        user_name: user[:user_name],
        user_sex: user[:sex],
        user_age: user[:age],
        user_country: location[:country],
        message: Faker::Lorem.paragraph,
        location: [location[:longitude], location[:latitude]],
      }
    end
    events
  end

  def generateLocations
    locations = []
    File.open('./worldcitiespop.txt').each_line do |line|
      country, city, accent, region, population, latitude, longitude = line.encode("UTF-8", invalid: :replace).strip.split(',')
      locations << {
        country: country,
        city: city,
        latitude: latitude.to_f,
        longitude: longitude.to_f,
      }
    end

    locations
  end

  def generateUsers
    users = []
    1000.times do |i|
      name = Faker::Name.name
      users << {
        id: i + 1,
        name: name,
        user_name: Faker::Internet.user_name(name),
        email: Faker::Internet.free_email,
        sex: ['M', 'M', 'M', 'F', 'F'].sample,
        age: [10, 20, 20, 20, 20, 20, 30, 30, 40, 40, 50, 60].sample + (1..10).to_a.sample,
      }
    end

    users
  end

end

events = FakeEvents.new
10000.times do
  events.generateEvent().each do |event|
    index = event[:time].getutc.strftime('sample_service-%Y.%m.%d')
    data = event.select{|k, v| k != :time}
    data['@timestamp'] = event[:time].strftime('%Y-%m-%dT%H:%M:%S%:z')
    puts %Q!{ "index" : { "_index" : "#{index}", "_type" : "event"}" } }\n#{JSON.dump(data)}!
  end
end
