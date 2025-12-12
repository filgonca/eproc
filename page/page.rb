require_relative '../support/env'
require_relative '../support/base'
require_relative '../elements/elements'

class Page < Base
  def example_test
    fill_text_field(:campo_username, '1')
    fill_text_field(:campo_senha, '2')
    click_element(:botao_entrar)
    sleep 3
  end
end