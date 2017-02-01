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


    if(!!@response1)
      @response1_fields = @response1.response_properties
    else
      @response1_fields = nil
    end

    if(!!@response2)
      @response2_fields = @response2.response_properties
    else
      @response2_fields = nil
    end
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
                        response1_id: params[:response1_id],
                        response2_id: params[:response2_id],
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
    response1 = @form.responses.find(params[:response1_id])
    response1.times_reviewed += 1
    response1.save!
    response2 = @form.responses.find(params[:response2_id])
    response2.times_reviewed += 1
    response2.save!
    redirect_to authenticated_root_path

    #Add reviewer to ranking matrix if not already present
    col_header = "user#{current_user.id}"
    column_list = ModelRank.columns.map(&:name)
    if !(column_list.include?(col_header))
      ModelRank.connection.add_column(:model_ranks, "#{col_header}", :integer, options = {default: 0})
      ModelRank.connection.schema_cache.clear!
      ActiveRecord::Base.clear_active_connections!
      reviewer_row_pos = @form.model_ranks.new()
      reviewer_row_pos.save!
      reviewer_row_pos.update_column(col_header, 1)
      reviewer_row_pos.save!
      reviewer_row_neg = @form.model_ranks.new()
      reviewer_row_neg.save!
      reviewer_row_neg.update_column(col_header, -1)
      reviewer_row_neg.save!
    end
    if(review.overall == 1)
      winner_num = review.response1_id
      loser_num = review.response2_id
    elsif(review.overall == 2)
      winner_num = review.response2_id
      loser_num = review.response1_id
    end
    winner_header = "response#{winner_num}"
    loser_header = "response#{loser_num}"

    review_row = @form.model_ranks.new()
    review_row.save!
    review_row.update_column(col_header, 1)
    review_row.update_column(winner_header, 1)
    review_row.update_column(loser_header, -1)
    review_row.save!
  end
end
