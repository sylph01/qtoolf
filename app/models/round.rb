class Round < ApplicationRecord
  # Round should eager load matches and scores when these values are needed.
  # ex: Round.includes(:matches => [:scores]).find(1)

  belongs_to :event
  has_many :matches, dependent: :destroy

  def qacers_export
    self.matches.map{ |match| match.qacers_scores.map { |x| x.join(",") }.join("\n") }.join("\n")
  end

  def qacers_scores
    self.matches.map { |match| match.qacers_scores.map { |x| [self.name] + x }}
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
