require_relative '../support/env'
require_relative '../support/base'
require_relative '../elements/elements'

class Page < Base
  def example_test
    fill_text_field(:text_field_example, 'Texto de exemplo')
    click_element(:button_example)
  end
end