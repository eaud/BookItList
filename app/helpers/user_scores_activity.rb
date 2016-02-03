module UserScoresActivity
  def overall_score(activity)

  end

  def activity_tag_score

  end

  def host_tag_score

  end

  def own_tag_score

  end

  def host_score

  end

  def activity_tag_like_percentage(activity)
    occurence = []
    raw_like_percent = activity.tags.map do |tag|
      previously_liked = self.score_data["activity"]["tag_likes"][tag.id.to_s]
      previously_disliked = self.score_data["activity"]["tag_dislikes"][tag.id.to_s]
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
    end.compact #this gets rid of cases in which tag has never been seen before (liked or not liked)
    occurence_total = occurence.inject(0){|sum, occurence| sum + occurence}
    raw_like_percent.each.with_index.inject(0) do |sum, (percentage, i)|
      weight = occurence[i] / occurence_total
      sum + percentage*weight
    end
  end

  def like_percentage_to_score(like_percentage)
    case like_percentage
    when 0 <= like_percentage && like_percentage < 25
      0
    when 25 <= like_percentage && like_percentage < 50
      3000
    when 50 <= like_percentage && like_percentage < 75
      5000
    when 75 <= like_percentage && like_percentage <= 100
      10000
    end
  end

end
