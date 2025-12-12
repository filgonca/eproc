require 'fox16'
include Fox

class AutomationApp < FXMainWindow
  def initialize(app)
    super(app, "Automação EPROC", width: 400, height: 200)

    # Layout principal
    frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Layout principal ajustado para organizar os campos e o botão
    hframe = FXHorizontalFrame.new(frame, LAYOUT_FILL_X | LAYOUT_CENTER_Y)

    # Campo de entrada Usuário
    vframe = FXVerticalFrame.new(hframe, LAYOUT_FILL_Y | LAYOUT_LEFT)
    FXLabel.new(vframe, "Usuário:")
    user_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL)

    # Campo de entrada Senha
    FXLabel.new(vframe, "Senha:")
    password_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL | TEXTFIELD_PASSWD)

    # Campo de entrada para Chave
    FXLabel.new(vframe, "Chave:")
    key_field = FXTextField.new(vframe, 25, nil, 0, TEXTFIELD_NORMAL | TEXTFIELD_PASSWD)

    # Adiciona checkbox para visualizar ou ocultar valores dos campos Senha e Chave
    FXCheckButton.new(vframe, "Mostrar Senha e Chave") do |checkbox|
      checkbox.connect(SEL_COMMAND) do
        if checkbox.checked?
          password_field.textStyle &= ~TEXTFIELD_PASSWD
          key_field.textStyle &= ~TEXTFIELD_PASSWD
        else
          password_field.textStyle |= TEXTFIELD_PASSWD
          key_field.textStyle |= TEXTFIELD_PASSWD
        end
      end
    end

    # Ajusta o botão para ficar ainda mais à esquerda, centralizado horizontalmente no espaço vazio
    spacer = FXHorizontalFrame.new(hframe, LAYOUT_FIX_WIDTH | LAYOUT_CENTER_Y, 0, 0, 50, 0, 0, 0, 0, 0)

    # Botão para iniciar a automação
    FXButton.new(hframe, "Baixar Boletos", nil, nil, 0, FRAME_THICK | FRAME_RAISED | LAYOUT_CENTER_Y) do |button|
      button.width = (button.width * 8).to_i
      button.height = (button.height * 8).to_i
      button.connect(SEL_COMMAND) do
        system("ruby run.rb")
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