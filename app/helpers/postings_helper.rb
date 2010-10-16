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
end
