class WeatherAnchor
  WEATHER_URI = URI("http://api.openweathermap.org/data/2.5/weather?q=Skopje,mk")
  CODES = [
     [200, "има грмотевици со малку дожд."], [201, "има грмотевици со дожд."],
     [202, "има грмотевици со многу дожд."], [210, "има малку грмотевици."],
     [211, "има грмотевици."], [212, "има многу грмотевици."],
     [221, "ИМА ГРМОТЕВИЦИ, МНОГУ ГРМОТЕВИЦИ!"], [230, "грми и малку роси."],
     [231, "грмотевици и росење."], [232, "грмотевици со ситен дожд."],
     [300, "малку роси."], [301, "роси."], [302, "бааги роси."],
     [310, "почнува да врне."], [311, "почнува да врне."], [312, "врне дожд."],
     [313, "врне дожд."], [314, "врне дожд."], [321, "здраво врне!"],
     [500, "малкуцка врне."], [501, "малку врне."], [502, "врне!"], [503, "многу врне."],
     [504, "ќе не поплави."], [511, "врне замрзнат дожд."], [520, "малку врне."],
     [521, "врне дожд!"], [522, "многу врне дожд!"], [531, "многу врне, МНОГУ!"],
     [600, "ВРНЕ СНЕГ ЛУЃЕ!"], [601, "врне снег!"], [602, "многу врне снег..."],
     [611, "има лапавица."], [612, "истура снег."], [615, "врне малку измешан снег со дожд."],
     [616, "врне снег со дожд."], [620, "врне снег."], [621, "врне снег."],
     [622, "многу врне снег, многу!!!"], [701, "е магловито."], [711, "е зачадено."],
     [721, "е бааги магловито."], [731, "е лом, прашина насекаде!"],
     [741, "многу магла има."], [751, "има песочна бура!"], [761, "има прашина насекаде."],
     [762, "има ВУЛКАНСКА ПЕПЕЛ, сите по дома!"], [771, "има меќава."],
     [781, "има торнадо, сите у подрум!"], [800, 'небото е чисто.'],
     [801, 'има чат пат по некој облак.'], [802, 'има одвоени облаци.'],
     [803, 'има облаци.'], [804, 'облачно e!'], [900, 'има торнадо!'],
     [901, 'има тропска бура!'], [902, 'има ураган!'], [903, 'е ладно!'],
     [904, 'е топло.'], [905, 'е ветровито.'], [906, 'врне град!'], [951, 'е мирно.'],
     [950, 'заоѓа сонцето...'], [952, 'има слаб ветар.'], [953, 'има слаб ветар.'],
     [954, 'е ветровито.'], [955, 'дува свеж ветар.'], [956, 'дува силен ветар.'],
     [957, 'дува многу силен ветар.'], [958, 'има невреме!'], [959, 'има силно невреме!'],
     [960, 'има бура.'], [961, 'има силна бура.'], [962, 'има ураган!'],
    ]


  class << self
    def update!
      anchor = new
      anchor.tweet!
    end
  end

  def initialize
    @json = JSON.parse(Net::HTTP.get(WEATHER_URI))
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def generate_tweet
    weather_description + " " + tweet_description
  end

  def tweet!
    @twitter_client.update(generate_tweet)
  end

  private
  def temperature
    kelvin = @json["main"]["temp"]
    (kelvin - 273.15).round(0)
  end

  def id_code
    @json["weather"][0]["id"]
  end

  def weather_description
    code = CODES.detect do |code, desc|
      code == id_code
    end
    "Моментално надвор #{code.last}"
  end

  def tweet_description
    case temperature
    when -100..-20
      "#{temperature} степени. Ладно нек си ибе мајката!"
    when -19..-10
      "#{temperature} степени, грч ладно."
    when -9..0
      "Брррр... ладно! Температурата е #{temperature} степени."
    when 1..10
      "Свежo e, со температура од #{temperature} степени."
    when 11..20
      "Пријатно е, со температура од #{temperature} степени."
    when 21..25
      "#{temperature} степени, топ еј!"
    when 26..35
      "Топлоooo... (#{temperature} степени)"
    when 36..42
      "Мнооогу топло! Фаќа накај 40ка..."
    when 42..100
      "ПЕКОЛ!"
    end

  end
end
