module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    del = button_to("Destroy", item, method: :delete, class: "btn btn-danger")
    raw("#{edit} #{del}")
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
