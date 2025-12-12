require 'fox16'
include Fox

class AutomationApp < FXMainWindow
  
  # Torna os campos acessíveis globalmente dentro da classe
  attr_reader :user_field, :password_field, :key_field

  def initialize(app)
    super(app, "Automação EPROC", width: 400, height: 200)

    # Definição de frame antes de seu uso
    frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Definição de hframe antes de seu uso
    hframe = FXHorizontalFrame.new(frame, LAYOUT_FILL_X | LAYOUT_CENTER_Y)
    
    # Campo de entrada Usuário
    vframe = FXVerticalFrame.new(hframe, LAYOUT_FILL_Y | LAYOUT_LEFT)
    FXLabel.new(vframe, "Usuário:")
    @user_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL) # <--- Usar @
    
    # Campo de entrada Senha
    FXLabel.new(vframe, "Senha:")
    @password_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL | TEXTFIELD_PASSWD) # <--- Usar @

    # Campo de entrada para Chave
    FXLabel.new(vframe, "Chave:")
    @key_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL | TEXTFIELD_PASSWD) # <--- Usar @

    # Adiciona checkbox para visualizar ou ocultar valores dos campos Senha e Chave
    FXCheckButton.new(vframe, "Mostrar Senha e Chave") do |checkbox|
      checkbox.connect(SEL_COMMAND) do
        if checkbox.checked?
          @password_field.textStyle &= ~TEXTFIELD_PASSWD
          @key_field.textStyle &= ~TEXTFIELD_PASSWD
        else
          @password_field.textStyle |= TEXTFIELD_PASSWD
          @key_field.textStyle |= TEXTFIELD_PASSWD
        end
      end
    end

    # Botão para iniciar a automação
    FXButton.new(hframe, "Baixar Boletos", nil, nil, 0, FRAME_THICK | FRAME_RAISED | LAYOUT_CENTER_X | LAYOUT_CENTER_Y) do |button|
      button.width = (button.width * 8).to_i
      button.height = (button.height * 8).to_i
      button.connect(SEL_COMMAND) do
        # 1. Capturar os valores e Escapar caracteres especiais para o shell
        user_input = @user_field.text.gsub('"', '\"')
        password_input = @password_field.text.gsub('"', '\"')

        # 2. Executar o run.rb passando os valores como argumentos
        # Usamos aspas duplas para garantir que valores com espaços sejam tratados como um único argumento
        system("ruby run.rb \"#{user_input}\" \"#{password_input}\"")
      end
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $PROGRAM_NAME
  app = FXApp.new
  AutomationApp.new(app)
  app.create
  app.run
end