module ArrayHelper
  def insert_dummy(dummy = "*DummyPlayer")
    if self.length < 2
      self + [dummy].cycle(3).to_a
    else
      case self.length % 4
        when 0 then self
        when 1 then (self << dummy).insert(self.length - 4, dummy).insert(self.length - 8, dummy)
        when 2 then (self << dummy).insert(self.length - 4, dummy)
        when 3 then (self << dummy)
      end
    end
  end
end
