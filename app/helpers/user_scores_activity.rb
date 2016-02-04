module UserScoresActivity
  def overall_score(activity)
    activity_tag_score = tag_score(activity)
    host_tag_score = tag_score(activity.host)
    my_tag_score = own_tag_score(activity)
    my_host_score = host_score(activity)
    my_overall_score = (activity_tag_score + host_tag_score + my_tag_score + my_host_score) / 4
  end

  def tag_score(comp_object) #takes in argument of comp_object (activity or host), calculates percentage and returns the score
    like_percentage_to_score(tag_like_percentage(comp_object))
  end

  def own_tag_score(activity)
    like_percentage_to_score(own_tag_percentage(activity))
  end

  def host_score(activity)
    like_percentage_to_score(host_percentage(activity))
  end

  def tag_like_percentage(comp_object) #calculates the weighted avg percentage of likes for a given comp_object(either acitvity or host) and the users score data for the comp_objects type
    occurence = []
    comp_object.class == Activity ? kind = "activity" : kind = "host"
    raw_like_percent = comp_object.tags.map do |tag|
      previously_liked = self.score_data[kind]["tag_likes"][tag.id.to_s]
      previously_disliked = self.score_data[kind]["tag_dislikes"][tag.id.to_s]
      if !!previously_liked && !!previously_disliked
        occurence << (previously_liked + previously_disliked)
        (previously_liked * 100) / (previously_liked + previously_disliked)
      elsif !previously_liked && !!previously_disliked #only disliked, never liked
        occurence << (previously_disliked)
        (0  * 100) / previously_disliked
      elsif !!previously_liked && !previously_disliked #only liked, never disliked
        occurence << (previously_liked)
        (previously_liked * 100)/ previously_liked
      end
    end.compact
    #this gets rid of cases in which tag has never been seen before (liked or not liked)
    occurence_total = occurence.inject(0){|sum, occurence| sum + occurence}
    raw_like_percent.each.with_index.inject(0) do |sum, (percentage, i)|
      weight = (occurence[i] *100) / occurence_total #scale up by 100 because ratio returns 0
      (sum + percentage*weight)
    end / 100 #reduce result to usable percentage
  end

  def own_tag_percentage(activity)
    return 0 if my_tags.length == 0
    my_tags = self.tags
    activity_tags = activity.tags
    intersection = my_tags & activity_tags
    tag_percentage = (intersection.length) *100 / my_tags.length
  end

  def host_percentage(activity)
    id = activity.host.id.to_s
    likes = self.score_data["host"]["liked"][id] || 0
    dislikes = self.score_data["host"]["disliked"][id] || 0
    if (likes + dislikes) >= 1
      return likes * 100 / (likes + dislikes)
    else
      return 0
    end
  end

  def like_percentage_to_score(like_percentage)
    case like_percentage
    when (0...25)
      return 0
    when  (25...50)
      return 3000
    when  (50...75)
      return 5000
    when  (75..100)
      return 10000
    end
  end

end
