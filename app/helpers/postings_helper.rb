module PostingsHelper  
  def title(posting)
    posting.title
  end
  def link(posting)
    url_for posting
  end
  def location(posting)
    posting.location
  end
  def description(posting)
    truncate(posting.description, :length => 250)
  end
  def category(posting)
    if(posting.present? && posting.category.present? && posting.category.name.present?)
      link_to(posting.category.name, posting.category)
    end
  end
  def age(posting)
    time_ago_in_words posting.created_at
  end
end
