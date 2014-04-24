class BeaufortScale

  class << self
    def describe(wind_speed)
      new(wind_speed).describe
    end
  end

  def initialize(wind_speed)
    @wind_speed = wind_speed
  end

  def describe
    case @wind_speed
    when 0..1.5
      "и ветар нема."
    when 1.6..3.4
      "Си дувка малкуцка."
    when 3.5..5.4
      "A ветар си има."
    when 5.5..7.9
      "Си дува ветре..."
    when 8..10.7
      "И да ви кажам, си се ујача ветаров!"
    when 10.8..17.1
      "и бајаги јак ветар дува!!!"
    when 17.2..24.4
      "A дува ветар у ПМ!!"
    when 24.5..32.6
      "ШО Е СО ВЕТРОВ РЕТАРДИРАН ЕЈ?"
    when 32.7..1000
      "НАДВОР ИМА УРАГАН!!!!!!!"
    end
  end

end
