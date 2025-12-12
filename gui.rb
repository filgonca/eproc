require 'fox16'
include Fox

class AutomationApp < FXMainWindow
  def initialize(app)
    super(app, "Automação EPROC", width: 400, height: 200)

    # Layout principal
    frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Botão para iniciar a automação
    FXButton.new(frame, "Baixar Boletos", nil, nil, 0, FRAME_THICK | FRAME_RAISED | LAYOUT_CENTER_X | LAYOUT_CENTER_Y) do |button|
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