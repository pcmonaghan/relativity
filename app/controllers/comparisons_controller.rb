class ComparisonsController < ApplicationController

  def compare
    form_num = 1 #DSapp 2017 app

    # Pick two responses for viewing
    form = Form.find(form_num)
    response1 = select_response(form)
    puts response1
    response2 = select_response(form)
    puts response2

    # Ensure that the same record isn't displayed twice
    unless (form.num_records < 2) #prevent infinite loop if too few responses
      while(response2.id == response1.id)
        response2 = select_response(form)
        puts response2
      end
    end

    @response1_fields = response1.response_properties
    @response2_fields = response2.response_properties
  end

  #Implement matching algorithm here
  def select_response(form, method = nil)
    if(method == nil)
      return form.responses.find_by(form_record_id: (rand(form.num_records) + 1))
    end
    return nil
  end
end
