class Users::ProfilesController < ApplicationController
  def show
    @user = current_user

#    if(!@user || @user.id != params[:id].to_i)
#      redirect_to :unauthenticated_root
#    end
    @forms = @user.forms
    @reviews = Review.where(user_id: @user.id)
    @responses = Form.find(1).responses.order(:rank)
    @display_resp = nil
    #A specific paper has been selected
    if(!params[:response].blank?)
      @display_resp = Form.find(1).responses.find(params[:response].to_i)
      @display_resp_fields = @display_resp.response_properties
    end
  end
end
