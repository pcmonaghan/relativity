class ComparisonsController < ApplicationController

  before_filter :set_form

  def set_form
    form_num = 1 #DSapp 2017 app
    @form = Form.find(form_num)
  end

  def compare
    # Pick two responses for viewing
    @response1 = select_response(@form)
    puts @response1
    @response2 = select_response(@form)
    puts @response2

    # Ensure that the same record isn't displayed twice
    unless (@form.num_records < 2) #prevent infinite loop if too few responses
      while(@response2.id == @response1.id)
        @response2 = select_response(@form)
        puts @response2
      end
    end

    @response1_fields = @response1.response_properties
    @response2_fields = @response2.response_properties
  end

  #Implement matching algorithm here
  def select_response(form, method = nil)
    if(method == nil)
      return form.responses.find_by(form_record_id: (rand(form.num_records) + 1))
    end
    return nil
  end

  def new_review
    #Create new review record
    review = @form.reviews.new(user_id: params[:user_id],
                        response_one_id: params[:response_one_id],
                        response_two_id: params[:response_two_id],
                        stat_machine_learning_skill: params[:sml],
                        social_science_skill: params[:ss],
                        programming_cs_skill: params[:pcs],
                        team_skill: params[:team],
                        data_skill: params[:data],
                        communication_skill: params[:comm],
                        care_about_social_good: params[:csg],
                        overall: params[:overall])
    review.save!

    #Increment number of reviews
    response1 = @form.responses.find(params[:response_one_id])
    response1.times_reviewed += 1
    response1.save!
    response1 = @form.responses.find(params[:response_two_id])
    response2.times_reviewed += 1
    response2.save!
    redirect_to authenticated_root_path
  end
end
