module DashboardHelper
  PROGRESS_BAR_WIDTH = 400 # px

  def exp_req(lvl)
    (6.0/5) * lvl**3 - 15 * lvl**2 + 100 * lvl - 140
  end

  def level_upper_bound
    lvl = current_user.level
    exp_req(lvl + 1)
  end

  def level_lower_bound
    lvl = current_user.level
    exp_req(lvl)
  end

  def exp_percent
    ((current_user.experience_points - level_lower_bound).to_f / (level_upper_bound - level_lower_bound)).round(2)
  end

  def fill_width
    (PROGRESS_BAR_WIDTH * exp_percent).to_i
  end

end
