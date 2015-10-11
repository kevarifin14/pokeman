module DashboardHelper
  PROGRESS_BAR_WIDTH = 400 # px

  def self.exp_req(lvl)
    (6/5) * lvl**3 - 15 * lvl**2 + 100 * lvl - 140
  end

  def self.level_upper_bound
    lvl = current_user.level
    exp_req(lvl + 1)
  end

  def self.level_lower_bound
    lvl = current_user.level
    exp_req(lvl)
  end

  def self.fill_width
    PROGRESS_BAR_WIDTH * (current_user.experience_points - level_lower_bound) / (level_upper_bound - level_lower_bound)
  end

end
