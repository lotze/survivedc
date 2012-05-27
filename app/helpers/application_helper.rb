module ApplicationHelper
  def map_open_time
    Time.at(1337461600 - 480)
  end
  
  def release_time
    # get actual release from DB; if it doesn't exist, use predefined start time of 8 PM
    Time.at(1337472000 - 480)
  end
  
  def over_time
    Time.at(1337500800 - 480)
  end
  
  def time_bw_loc_updates
    if game_on
      return 60
    elsif pre_game
      return 300
    else
      return 3600
    end
  end
  
  def pre_game 
    t = Time.now
    t >= release_time - 7200 && t <= release_time 
  end
  
  def post_game
    t = Time.now
    t >= over_time
  end
  
  def game_on
    t = Time.now
    t >= release_time && t <= over_time 
  end
  
  def map_on
    t = Time.now
    t >= map_open_time
  end
  
  def random_code(length=5)
    code = ""
    length.times do
      code = code + (rand(26) + 65).chr
    end
    return code
  end
end
