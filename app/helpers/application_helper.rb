module ApplicationHelper
  def ms (posting, output)
    output = output.to_s
    # In cases where we just need the mustache template
    # we'll get back the param name with {{.}} added
    unless posting
      return '{{'+output.to_s+'}}'
    else
      return send(output, posting)
    end
  end
  
  def active_link_to(*args)
    args.push({:class=>'current'}) if current_page?(args[1])
    link_to(*args)
  end
end
