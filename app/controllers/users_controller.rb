class UsersController < ApplicationController
  def by_ip
    result = Hash.new
    User.logins_by_ip.each do |u|
      result[u.ip] = Array.new unless result.has_key? u.ip
      result[u.ip] << u.login
    end
    wrap_result = [] << result
    render json: wrap_result, status: :ok
  end
end
