module Valyrian
  module Utils

    def handle_exception(ex,attributes)
      logger.warn ex
      logger.warn ex.backtrace.join("\n")
    end

    def logger
      Valyrian.logger
    end
  end
end
