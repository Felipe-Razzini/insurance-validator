module ContactNameHelper
  # Method from app.rb used to match the format of the director's name from the API
  def normalized_contact_name(contact_name)
    split_name = contact_name.split
    first_name = split_name[0...-1].map(&:capitalize).join(' ')
    last_name = split_name.last.upcase
    "#{last_name}, #{first_name}"
  end
end

module UserIsDirectorHelper
  include ContactNameHelper
  def user_is_director?(contact_name, user_data)
    normalized_contact_name = normalized_contact_name(contact_name)
    user_data['items'].any? do |officer|
      officer['name'] == normalized_contact_name && officer['officer_role'] == 'director'
    end
  end
end
