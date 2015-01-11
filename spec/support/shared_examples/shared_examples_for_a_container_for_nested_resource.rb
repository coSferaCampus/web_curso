require 'spec_helper'

shared_examples_for "a container for nested resource" do |options, resource, attributes|

  if options.include?( :index )
    describe "GET #index" do
      before do
        get :index
      end

      let( :root ){ model.to_s.tableize }

      it "include the attribute #{resource}" do
        response_body_json[ root ].each do |r|
          r.should have_key( resource )
        end
      end

      describe "#{resource.capitalize}" do
        attributes.each do |attr|
          it "include the attribute #{attr}" do
            response_body_json[root].each do |r|
              r[resource].each do |nested|
                nested.should have_key( attr.to_s ) || r[resource].should == []
              end
            end
          end
        end
      end
    end
  end
  
  if options.include?( :show )
    describe "GET #show" do
       before do
        get :show, id: show_resource.id
      end

      let( :root ){ model.to_s.tableize.singularize }

      it "include the attribute #{resource}" do
        response_body_json[ root ].should have_key( resource )
      end

      describe "#{resource.capitalize}" do
        attributes.each do |attr|
          it "include the attribute #{attr}" do
            response_body_json[root][resource].each do |nested|
              nested.should have_key( attr.to_s ) || r[resource].should == []
            end
          end
        end
      end
    end
  end
end
