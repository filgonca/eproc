require_relative './support/env'
require_relative './page/page'

# 1. Recebe os argumentos passados pelo gui.rb
username = ARGV[0]
password = ARGV[1]

# Inicializa o driver e executa o teste
begin
  puts '=== Automação Iniciada ==='
  # 2. Passa os dados para o construtor da classe Page
  page = Page.new(DRIVER, username, password) 
  page.example_test
  puts '=== Automação Finalizada com Sucesso ==='
rescue StandardError => e
ensure
  DRIVER.quit
end