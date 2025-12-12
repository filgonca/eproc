require_relative 'env'

Before do
  puts '=== Automação Iniciada ==='
end

After do
  if $!.nil?
    puts '=== Automação Finalizada com Sucesso ==='
  else
    puts "Erro durante a automação: #{$!.message}"
    puts '=== Automação Finalizada com Falha ==='
  end
  DRIVER.quit
end