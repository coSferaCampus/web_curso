module ControllerMacros

  def set_content_type( format )
    before( :each ) do
      @request.env["CONTENT_TYPE"] = format
      @request.env["HTTP_ACCEPT"] = format
    end
  end

end
