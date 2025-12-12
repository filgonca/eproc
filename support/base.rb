require 'selenium-webdriver'

class Base
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 30)
    puts "Driver inicializado com sucesso."
  end

  def wait_for_page_load
    @wait.until { @driver.execute_script('return document.readyState') == 'complete' }
  end

  def wait_for_element(selector)
    @wait.until { @driver.find_element(:css, selector).displayed? }
  end

  def find_element(element)
    details = ELEMENTS[element]
    wait_for_element(details[:value])
    case details[:type]
    when :text_field
      @driver.find_element(:css, details[:value])
    when :button
      @driver.find_element(:css, details[:value])
    else
      raise "Tipo de elemento não suportado: #{details[:type]}"
    end
  end

  def click_element(element)
    find_element(element).click
  end

  def fill_text_field(element, text)
    find_element(element).send_keys(text)
  end
end