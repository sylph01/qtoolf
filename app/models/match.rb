class Match < ApplicationRecord
  has_many :scores, dependent: :destroy, inverse_of: :match
  belongs_to :round
  mount_uploader :image, MatchImageUploader

  accepts_nested_attributes_for :scores

  (1..4).each do |n|
    define_method "score#{n}" do
      self.scores.sort_by { |x| x.order }[n - 1]
    end
  end

  def name
    "#{self.court}コート/#{self.number}試合"
  end

  def max_score
    self.scores.map(&:numeric_score).max
  end

  def second_to_max_score
    self.scores.map(&:numeric_score).sort.reverse[1]
  end

  def calculate_statistics
    self.scores.map do |s|
      {
        name:           s.name,
        genre:          s.genre,
        kind:           s.kind,
        score:          s.numeric_score,
        rank:           (self.scores.to_a.count { |sx| sx.numeric_score > s.numeric_score } + 1),
        rate_against_1: max_score == 0           ? 0 : s.numeric_score /           max_score.to_f,
        rate_against_2: second_to_max_score == 0 ? 0 : s.numeric_score / second_to_max_score.to_f
      }
    end
  end

  def owner
    self.round.event.owner
  end

  def owner_id
    self.owner.id
  end

  def contributors
    self.round.event.contributors
  end
end
