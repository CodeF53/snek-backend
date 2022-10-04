class User < ActiveRecord::Base
  has_many :plays

  def new_play(playtime:, score:)
    Play.create(user: self, playtime: playtime, score: score)
  end

  def leaderboard_data
    {
      username: username,
      num_plays: num_plays,
      average_score: average_score,
      average_playtime: average_playtime,
      highscore_score: highscore_score,
      highscore_time: highscore_time,
      highscore_date: best_play.created_at
    }
  end

  def initialize_session_cookie
    update(session_cookie: (0...32).map { ([65, 97].sample + rand(26)).chr }.push(rand(99)).join)
  end

  private

  def num_plays
    plays.length
  end

  def average_score
    plays.sum(&:score) / plays.length
  end

  def average_playtime
    plays.sum(&:playtime) / plays.length
  end

  def best_play
    plays.max_by(&:score)
  end

  def highscore_score
    puts best_play
    best_play.score
  end

  def highscore_time
    best_play.playtime
  end
end
