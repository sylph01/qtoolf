class Event < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :rounds, dependent: :destroy
  has_many :contributors, dependent: :destroy

  def scores_of_player(player_name)
    scores = Score.joins(match: {round: :event}).where('events.id' => self.id).where('name' => player_name)
  end
end
