class CompaniesController < ApplicationController
  expose :companies { Company.all }
  def index

  end
end
