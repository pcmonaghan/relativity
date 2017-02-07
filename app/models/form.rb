class Form < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :response_properties, through: :responses
  has_many :field_keys, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :model_ranks, dependent: :destroy
  belongs_to :user, optional: true

  def rate_responses()
    default_rating = -1

    #Set all default ratings
    self.responses.update_all({next_rating: default_rating})
    all_responses = self.responses #self.responses.includes(:rating, :next_rating, :rank)

    #Iterate to calculate rating
    iteration = 0
    last_sum = 0.0
    while(1)
      #Copy next_rating to rating
      Response.transaction do
        all_responses.each do |resp|
          resp.rating = resp.next_rating
          resp.save!
        end
      end

      #Recalculate rating
      Response.transaction do
      all_responses.each do |resp|
        review_count = 0.0
        new_rating = 0.0
        old_rating = resp.rating
        resp_name = "response#{resp.id}"
        #All reviews where this one is on left
        result = nil
        response1_reviews = self.reviews.where("response1_id = ?",resp.id) #.includes(:response1_id, :response2_id, :overall).where("response1_id = ?",resp.id)
        response1_reviews.each do |review|
          winner = review.overall
          if(winner == 1)
            result = 1.0
          else
            result = -1.0
          end
          opponent_rating = all_responses.find(review.response2_id).rating
          review_rating = opponent_rating + result
          if(review_rating > old_rating && result >= 0)
              review_count += 1
              new_rating += review_rating
          elsif(review_rating <= old_rating && result <= 0)
            review_count += 1
            new_rating += review_rating
          else
            review_count += 0.05
            new_rating += 0.05*review_rating
          end
        end
        #All reviews where this one is on right
        response2_reviews = self.reviews.where("response2_id = ?",resp.id)#.includes(:response1_id, :response2_id, :overall).where("response2_id = ?",resp.id)
        response2_reviews.each do |review|
          winner = review.overall
          if(winner == 2)
            result = 1.0
          else
            result = -1.0
          end
          opponent_rating = all_responses.find(review.response1_id).rating
          review_rating = opponent_rating + result
          if((review_rating > old_rating && result >= 0) ||
            (review_rating <= old_rating && result <= 0))
              review_count += 1.0
              new_rating += review_rating
          else
            review_count += 0.05
            new_rating += 0.05*review_rating
          end
        end

        if(review_count)
          new_rating = new_rating/review_count
          resp.update_attributes!(:next_rating => (new_rating + old_rating)/2.0)
        end
      end
      end

      iteration += 1
      if((iteration%500) == 0)
        #calculate sum of abs value of shifts
        sum = 0.0
        all_responses.each do |resp|
          new_rating = resp.next_rating - resp.rating
          if(new_rating >= 0)
            sum += new_rating
          elsif
            sum -= new_rating
          end
        end
        #Check exit conditions
        if(sum/self.num_records <= 0.0000001 ||
          (sum >= last_sum && iteration >= 100000) ||
          (iteration >= 500000))
          break;
        end
        last_sum = sum
      end
    end

    #Make average rating 0
    sum = 0.0
    all_responses.each do |resp|
      sum += resp.rating
    end

    sum/=self.num_records
    Response.transaction do
    all_responses.each do |resp|
      resp.rating = resp.rating - sum
      resp.save!
    end
    end

    Response.transaction do
    n = 1
    all_responses.order(rating: :desc).each do |resp|
      resp.rank = n
      n += 1
      resp.save!
    end
    end
  end
end
