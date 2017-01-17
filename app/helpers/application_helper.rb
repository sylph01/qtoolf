module ApplicationHelper
  def all_genres
    return ["ノン","アニ","スポ","芸能","ライ","社会","文系","理系"]
  end

  def all_kinds
    return ["○×","四択","連想","並替","文字","スロ","タイ","エフ","キュ","線結","多答","順当","グル","S1","S2","S3","ラン","自由"]
  end

  def rank(match, score)
    match.scores.to_a.count { |sx| sx.score.to_f > score.score.to_f } + 1
  end
end
