require_relative './support/env'
require_relative './page/page'

# Inicializa o driver e executa o teste
begin
  puts '=== Automação Iniciada ==='
  page = Page.new(DRIVER)
  page.example_test
  puts '=== Automação Finalizada com Sucesso ==='
rescue StandardError => e
  puts "Erro durante a automação: #{e.message}"
  puts '=== Automação Finalizada com Falha ==='
ensure
  DRIVER.quit
end