class ProfileController < ApplicationController
  include ProfileHelper
  before_action :set_user

  def show
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
    respond_to do |format|
      format.turbo_stream do
        #  Rutik with a user_id 1
        #  dom_id_for_follower(@user) --> user_1
        render turbo_stream: [
                 turbo_stream.replace(dom_id_for_follower(@user),
                                      partial: "profile/follow_button",
                                      locals: { user: @user }),
                 turbo_stream.update("#{@user.id}Follower-Count",
                                     partial: "profile/follower_count",
                                     locals: { user: @user }),
               ]
      end
    end
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
    respond_to do |format|
      format.turbo_stream do
        #  Rutik with a user_id 1
        #  dom_id_for_follower(@user) --> user_1
        render turbo_stream: [
                 turbo_stream.replace(dom_id_for_follower(@user),
                                      partial: "profile/follow_button",
                                      locals: { user: @user }),
                 turbo_stream.update("#{@user.id}Follower-Count",
                                     partial: "profile/follower_count",
                                     locals: { user: @user }),
               ]
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
