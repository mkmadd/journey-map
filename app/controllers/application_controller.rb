class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  after_filter :catch_js_response_errors
  protect_from_forgery with: :exception
  
  private
  def catch_js_response_errors
    if response.content_type == 'text/javascript'
      literal_js = (response.body.strip.inspect)[1..-2]
      puts literal_js
      response.body = "try { eval(\"#{literal_js}\"); }\ncatch (e) { console.log(e); }"
    end
  end
end
