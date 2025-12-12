require 'fox16'
include Fox

class AutomationApp < FXMainWindow
  def initialize(app)
    super(app, "Robô de Automação", width: 400, height: 200)

    # Layout principal
    frame = FXVerticalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Texto de instrução
    FXLabel.new(frame, "Clique no botão para iniciar a automação:")

    # Botão para iniciar a automação
    FXButton.new(frame, "Iniciar Automação", nil, nil, 0, FRAME_THICK | FRAME_RAISED) do |button|
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