class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def level
  # Pokemon 'medium slow' experience formula
    n = (1.0/6) * 5**(1.0/3) * (2 * (81 * self.experience_points**2-16695 * self.experience_points+1387600)**(1.0/2) + 18 * self.experience_points-1855)**(1.0/3)-(25 * 5**(2.0/3))/(2 * (2 * (81 * self.experience_points**2 - 16695 * self.experience_points+1387600)**(1.0/2)+18 * self.experience_points-1855)**(1.0/3))+25.0/6
    n.round(0)
  end
end
