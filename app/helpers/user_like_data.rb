module UserLikeData
  def set_hash
    initial_hash = {
      activity: {
        liked: [],
        disliked: [],
        tag_likes: {},
        tag_dislikes: {}
      },
      host: {
        liked: {},
        disliked: {},
        tag_likes: {},
        tag_dislikes: {}
      }
    }
    self.update(score_data: initial_hash)
  end

  def like_activity(activity) #add the id of the current activity to score_data[liked_activities]
    score_data = self.score_data
    score_data["activity"]["liked"] << activity.id
    data_with_liked_act_tags = like_act_tag(score_data, activity.tag_ids)
    data_with_liked_host = like_host(data_with_liked_act_tags, activity.host)
    self.update(score_data: data_with_liked_host)
  end

  def dislike_activity(activity) #add the id of the current activity to score_data[disliked_activities]
    score_data = self.score_data
    score_data["activity"]["disliked"] << activity.id
    data_with_disliked_act_tags = dislike_act_tag(score_data, activity.tag_ids)
    data_with_disliked_host = dislike_host(data_with_disliked_act_tags, activity.host)
    self.update(score_data: data_with_disliked_host)
  end

  def like_act_tag(score_data, tag_ids) #takes array of tag_ids
    tag_ids.each do |tag_id|
      included_tag = score_data["activity"]["tag_likes"][tag_id.to_s]
      if included_tag
        score_data["activity"]["tag_likes"][tag_id.to_s] += 1
      elsif !included_tag
        score_data["activity"]["tag_likes"][tag_id.to_s] = 1
      end
    end
    score_data
  end

  def dislike_act_tag(score_data, tag_ids)
    tag_ids.each do |tag_id|
      included_tag = score_data["activity"]["tag_dislikes"][tag_id.to_s]
      if included_tag
        score_data["activity"]["tag_dislikes"][tag_id.to_s] += 1
      elsif !included_tag
        score_data["activity"]["tag_dislikes"][tag_id.to_s] = 1
      end
    end
    score_data
  end

  def like_host(score_data, host)
    included_host = score_data["host"]["liked"][host.id.to_s]
    if !!included_host
      score_data["host"]["liked"][host.id.to_s] += 1
    elsif !included_host
      score_data["host"]["liked"][host.id.to_s] = 1
    end
    score_data_with_liked_host_tags = like_host_tag(score_data, host)
  end

  def dislike_host(score_data, host)
    included_host = score_data["host"]["disliked"][host.id.to_s]
    if !!included_host
      score_data["host"]["disliked"][host.id.to_s] += 1
    elsif !included_host
      score_data["host"]["disliked"][host.id.to_s] = 1
    end
    score_data_with_disliked_host_tags = dislike_host_tag(score_data, host)
  end

  def like_host_tag(score_data, host)
    host.tag_ids.each do |tag_id|
      included_tag = score_data["host"]["tag_likes"][tag_id.to_s]
      if !!included_tag
        score_data["host"]["tag_likes"][tag_id.to_s] += 1
      elsif !included_tag
        score_data["host"]["tag_likes"][tag_id.to_s] = 1
      end
    end
    score_data
  end

  def dislike_host_tag(score_data, host)
    host.tag_ids.each do |tag_id|
      included_tag = score_data["host"]["tag_dislikes"][tag_id.to_s]
      if !!included_tag
        score_data["host"]["tag_dislikes"][tag_id.to_s] += 1
      elsif !included_tag
        score_data["host"]["tag_dislikes"][tag_id.to_s] = 1
      end
    end
    score_data
  end
end
