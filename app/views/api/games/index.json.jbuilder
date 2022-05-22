# frozen_string_literal: true

json.stats do
  @stats.each do |stat|
    json.partial! '/api/games/stat', stat:
  end
end
