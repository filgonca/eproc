require 'selenium-webdriver'

class Base
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(timeout: 15) # Espera de até 15 segundos
  end

  def wait_for_page_load
    @wait.until { @driver.execute_script('return document.readyState') == 'complete' }
  end

  def wait_for_element(selector)
    @wait.until { @driver.find_element(:css, selector).displayed? }
  end

  def handle_consent_popup
    begin
      consent_button = ELEMENTS[:consent_button]
      if @driver.find_elements(:css, consent_button[:value]).any?
        find_element(:consent_button).click
        sleep 1 # Pequena espera para garantir que o pop-up desapareça
      end
    rescue Selenium::WebDriver::Error::NoSuchElementError
      # Ignorar se o botão não estiver presente
    end
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