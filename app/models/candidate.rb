class Candidate < User
  devise :registerable
  validates_presence_of :first_name, :last_name

  def full_name
    first_name + " " + last_name
  end

  def display_name
    full_name
  end
end
