class Course < ActiveRecord::Base
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :year, numericality: { only_integer: true , greater_than: 0 , less_than: 6}
    validates :period, numericality: { only_integer: true}

  def period_array=(hash)
    string = hash.values.join
    self.period = string.to_i 2
  end

  def period_array
    if self.period.nil?
      self.period = 0
    end

    period_array = period.to_s(2).rjust(4, '0').split('')
    (0..3).zip(period_array).to_h
  end

end
