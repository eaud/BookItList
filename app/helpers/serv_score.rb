module ServScore
  def set_hash
    initial_hash = {
      activity: {
        liked: [],
        disliked: [],
        tag_likes: [],
        tag_dislikes: [],
      },
      host: {
        liked: [],
        disliked: [],
        tag_likes: [],
        tag_dislikes: []
      }
    }
    self.update(score_data: initial_hash)
  end

  def like_activity(activity) #add the id of the current activity to score_data[liked_activities]
    score_data = self.score_data
    data_with_liked_activity = score_data["activity"][:liked] << activity.id
    data_with_liked_act_tags = like_act_tag(data_with_liked_activity, activity.tag_ids)
    data_with_liked_host = like_host(data_with_liked_act_tags, activity.host)
    self.update(score_data: data_with_liked_host)
  end

  def dislike_activity(activity) #add the id of the current activity to score_data[disliked_activities]
    score_data = self.score_data
    data_with_disliked_activity = score_data[:activity][:disliked] << activity.id
    data_with_disliked_act_tags = dislike_act_tag(data_with_disliked_activity, activity.tag_ids)
    data_with_disliked_host = dislike_host(data_with_disliked_act_tags, activity.host)
    self.update(score_data: data_with_liked_host)
  end

  def like_act_tag(score_data, tag_ids) #takes array of tag_ids
    tag_ids.each do |tag_id|
      included_tag = score_data[tags_liked][tag_id]
      if included_tag
        included_tag += 1
      elsif !included_tag
        included_tag = 1
      end
      score_data
    end
  end

  def dislike_act_tag(score_data, tag_ids)
    tag_ids.each do |tag_id|
      included_tag = score_data[tags_disliked][tag_id]
      if included_tag
        included_tag += 1
      elsif !included_tag
        included_tag = 1
      end
      score_data
    end
  end

  def like_host(score_data, host)
    score_data[:host][:liked] << host.id
    score_data_with_liked_host_tags = like_host_tag(score_data, host)
  end

  def dislike_host(score_data, host)
    score_data[:host][:disliked] << host.id
    score_data_with_disliked_host_tags = like_host_tag(score_data, host)
  end

  def like_host_tag(score_data, host)
    host.tag_ids do |tag_id|
      included_tag = score_data[tags_liked][tag_id]
      if included_tag
        included_tag += 1
      elsif !included_tag
        included_tag = 1
      end
    end
    score_data
  end

  def dislike_host_tag(score_data, host)
    host.tag_ids do |tag_id|
      included_tag = score_data[tags_disliked][tag_id]
      if included_tag
        included_tag += 1
      elsif !included_tag
        included_tag = 1
      end
    end
    score_data
  end
end
