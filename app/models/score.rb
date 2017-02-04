class Score < ApplicationRecord
  belongs_to :match, inverse_of: :scores

  QACERS_REPLACE_TABLE = {
    "○×" => "○×",
    "四択" => "４択",
    "連想" => "連想",
    "並替" => "並替",
    "文字" => "文字",
    "スロ" => "スロ",
    "タイ" => "タイ",
    "エフ" => "エフ",
    "キュ" => "キュ",
    "線結" => "線結",
    "多答" => "多答",
    "順当" => "順当",
    "グル" => "グル",
    "S1" => "Ｒ１",
    "S2" => "Ｒ２",
    "S3" => "Ｒ３",
    "ラン" => "ラン",
    "自由" => "ＦＳ"
  }

  before_save do
    if self.name.nil? || self.name == ""
      self.name = "*DummyPlayer"
    end
    if self.score.nil? || self.score == ""
      self.score = 0
    end
    if self.score.to_i >= 500
      self.score = (self.score.to_f / 100)
    end
    self.score = "%3.2f" % self.score
  end

  def numeric_score
    if self.score.nil? || self.score == ""
      0
    else
      self.score.to_f
    end
  end

  def qacers_kind
    if self.kind
      str = self.kind
      QACERS_REPLACE_TABLE.each{ |key, value| str.gsub!(key, value) }
      str
    else
      return ""
    end
  end
end
