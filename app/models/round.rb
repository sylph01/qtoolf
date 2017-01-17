class Round < ApplicationRecord
  # Round should eager load matches and scores when these values are needed.
  # ex: Round.includes(:matches => [:scores]).find(1)

  belongs_to :event
  has_many :matches, dependent: :destroy

  def qacers_export
    self.matches.map do |match|
      match.scores.map do |score|
        [score.name.to_s, score.genre.to_s, score.qacers_kind.to_s, score.numeric_score].join(",")
      end.join("\n")
    end.join("\n")
  end

  def owner
    self.event.owner
  end

  def owner_id
    self.owner.id
  end

  def contributors
    self.event.contributors
  end
end
