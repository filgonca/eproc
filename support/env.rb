require 'selenium-webdriver'

# Configuração do driver para abrir uma nova janela do Chrome
CHROME_OPTIONS = Selenium::WebDriver::Chrome::Options.new
CHROME_OPTIONS.add_argument('--start-maximized')
CHROME_OPTIONS.add_argument('--disable-infobars')
CHROME_OPTIONS.add_argument('--disable-extensions')

# Inicializar uma nova instância do Chrome e navegar para a URL inicial
DRIVER = Selenium::WebDriver.for(:chrome, options: CHROME_OPTIONS)
DRIVER.navigate.to('https://www.amazon.com.br/')