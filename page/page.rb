require_relative '../support/env'
require_relative '../support/base'
require_relative '../elements/elements'

class Page < Base
  def initialize(driver, username, password)
    super(driver)
    @username = username
    @password = password
  end

  def example_test
    fill_text_field(:campo_username, @username)
    sleep 1
    fill_text_field(:campo_senha, @password)
    click_element(:botao_entrar)
    sleep 3
  end
end