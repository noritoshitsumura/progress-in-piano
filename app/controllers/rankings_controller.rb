class RankingsController < ApplicationController
  def rank
    @users = User.
              left_joins(:practices).
              distinct.
              sort_by do |user|
                hoges = user.practices
                if hoges.present?
                  hoges.map(&:time).sum
                else
                  0
                end
              end.
              reverse
  end


end