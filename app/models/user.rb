class User < ActiveRecord::Base
  has_many :plays

  def leaderboard_data
    {
      username: username,
      num_plays: num_plays,
      average_score: average_score,
      average_playtime: average_playtime,
      best_play: best_play,
      highscore_score: highscore_score,
      highscore_time: highscore_time
    }
  end

  def initialize_session_cookie
    update(session_cookie: (0...32).map { ([65, 97].sample + rand(26)).chr }.push(rand(99)).join)
  end

  def validate_session_cookie(test_cookie)
    test_cookie == session_cookie
  end

  private

  def num_plays
    plays.length
  end

  def average_score
    plays.average(:score)
  end

  def average_playtime
    plays.average(:playtime)
  end

  def best_play
    plays.max_by(:score)
  end

  def highscore_score
    best_play.score
  end

  def highscore_time
    best_play.time
  end
end
