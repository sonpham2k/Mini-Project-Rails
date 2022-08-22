class ApplicationController < ActionController::Base
    def Hello
        render html: "Hello!"
    end
end
