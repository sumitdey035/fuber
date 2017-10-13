class CustomerDecorator < Draper::Decorator
  def status
    "<i class='fa fa-user-circle text-#{object.hipster ? 'danger' : 'default'}'></i>".html_safe
  end
end