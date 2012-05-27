class StatusController < ApplicationController
  def runners
    runner_results = ActiveRecord::Base.connection.execute("select checkpoint_num, max(last_checkpoint_at), count(*) from users group by checkpoint_num order by checkpoint_num desc;")
    @per_checkpoint_runners = runner_results.map {|r| r}
    @total_runners = User.count
  end

  def checkpoints
    @checkpoints = Checkpoint.all.sort_by {|c| c.is_finish? ? 'ZZZZ' : c.name}
  end
  
  def locations
    @recent_updates = LocationUpdate.find(:all, :conditions => 'created_at < NOW() - INTERVAL 15 MINUTE')
  end

  def chasers
  end

end
