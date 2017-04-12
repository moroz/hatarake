class EmployersController < ApplicationController
  expose :employers { Employer.all }
  def index

  end
end
