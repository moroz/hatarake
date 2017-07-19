class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    conn = ActiveRecord::Base.connection
    query = ActiveRecord::Base.send(:sanitize_sql_array, ["INSERT INTO raw_payments_data (data) VALUES (?)", request.raw_post])
    conn.execute(query)
    render plain: 'OK'
  end
end
