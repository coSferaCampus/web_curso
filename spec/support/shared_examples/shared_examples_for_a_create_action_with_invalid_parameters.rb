shared_examples_for "a create action with invalid resource parameters" do |error|
  before do
    parameters[error[:attr]] = error[:value]

    args = { root => parameters }
    args.merge!( arguments ) if defined? arguments

    post :create, args
  end

  it "returns a 422 HTTP status code" do
    response.status.should == 422
  end

  it "returns an error object" do
    response_body_json.should have_key( "errors" )
  end

  it "returns an error in attribute #{error[:attr_error] || error[:attr]}" do
    response_body_json["errors"].should have_key( ( error[:attr_error] || error[:attr] ).to_s )
  end

  it "returns a code specifing why is #{error[:attr]} invalid" do
    response_body_json["errors"][( error[:attr_error] || error[:attr] ).to_s].should include( error[:error] )
  end
end
