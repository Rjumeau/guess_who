module ApplicationHelper
  def format_question(feature, adjective)
    case feature
    when "gender"
      "Is #{adjective == 'Male' ? 'he a man ?' : 'she a girl ?'}"
    when Persona::PLURALS_FEATURES.include?(feature)
      "Are his #{feature.to_s.humanize.downcase} #{adjective.downcase} ?"
    else
      "Is his #{feature.to_s.humanize.downcase} #{adjective.downcase} ?"
    end
  end
end
