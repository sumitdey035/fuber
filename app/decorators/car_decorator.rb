class CarDecorator < Draper::Decorator
  def status
    "<i class='fa fa-circle text-#{object.available ? 'success' : 'danger'}'></i>".html_safe
  end

  def title
    "<i class='fa fa-car text-#{object.is_a?(PinkCar) ? 'danger' : 'default'}'></i> #{object.uniq_id} <small>#{object.model}</small>".html_safe
  end
end