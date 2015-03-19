require 'rails_helper'

RSpec.describe VolunteersController, :type => :controller do
  describe "GET index" do
      
    let!(:v1) { Volunteer.create!(first_name: 'aaaa', last_name: 'xyzd', email: 'testtest3@gmail.com', gender: 'M',
      location: 'London', password: 'giveyoureffort19') }
    let!(:v2) { Volunteer.create!(first_name: 'bbbb', last_name: 'xyzd', email: 'testtest2@gmail.com', gender: 'F',
      location: 'New York', password: 'giveyoureffort19') }      
    let!(:v3) { Volunteer.create!(first_name: 'cccc', last_name: 'xyzd', email: 'testtest4@gmail.com', gender: 'F',
      location: 'San Francisco', password: 'giveyoureffort19') }
    let!(:v4) { Volunteer.create!(first_name: 'dddd', last_name: 'xyzd', email: 'testtest1@gmail.com', gender: 'M',
      location: 'New York', password: 'giveyoureffort19') }    
    
    
    context "when testing index functionality of volunteers for locations" do      
 
#       let!(:test_event_tag_1) { EventTag.create!(tag: dog, event: test_event_1) }
#       let!(:test_event_tag_2) { EventTag.create!(tag: cat, event: test_event_3) }
#       let!(:test_event_tag_3) { EventTag.create!(tag: dog, event: test_event_4) }
#       let!(:test_event_tag_4) { EventTag.create!(tag: cat, event: test_event_4) }

      #        NY = v2v4
      #        SF = v3
      #        Lon = v1
      #        Paris = none       
      it "assigns @volunteers when query has no params" do
        get :index
        expect(assigns(:volunteers)).to eq([v1,v2,v3,v4])
      end
          
      it "assigns @volunteers when query location = NY" do
        get :index, location: ['New York']
        expect(assigns(:volunteers)).to eq([v2,v4])
      end

      it "assigns @volunteers when query location = SF" do
        get :index, location: ['San Francisco']
        expect(assigns(:volunteers)).to eq([v3])
      end
      
      it "assigns @volunteers when query location = Lon" do
        get :index, location: ['London']
        expect(assigns(:volunteers)).to eq([v1])
      end
      
      it "assigns @volunteers when query location = Paris" do
        get :index, location: ['Paris']
        expect(assigns(:volunteers)).to eq([])
      end
    end # /when testing index functionality of volunteers for locations
    
    
    context "when testing index functionality of volunteers for tags" do    
      let!(:dog) { Tag.create!(name: 'dog') }
      let!(:cat) { Tag.create!(name: 'cat') }
      
      let!(:test_vol_tag_1) { VolunteerTag.create!(tag: dog, volunteer: v1) }
      let!(:test_vol_tag_2) { VolunteerTag.create!(tag: cat, volunteer: v3) }
      let!(:test_vol_tag_3) { VolunteerTag.create!(tag: dog, volunteer: v4) }
      let!(:test_vol_tag_4) { VolunteerTag.create!(tag: cat, volunteer: v4) }
      
      #       cat = v3v4
      #       dog = v1v4
      #       cat and dog = v4
      #       elephant = none
      it "assigns @volunteers when query tag = cat" do
        get :index, tags: ['cat']
        expect(assigns(:volunteers)).to eq([v3,v4])
      end

      it "assigns @volunteers when query tag = dog" do
        get :index, tags: ['dog']
        expect(assigns(:volunteers)).to eq([v1,v4])
      end      

      it "assigns @volunteers when query tag = dog and cat" do
        get :index, tags: ['dog' && 'cat']
        expect(assigns(:volunteers)).to eq([v4])
      end
      
      it "assigns @volunteers when query tag = elephant" do
        get :index, tags: ['elephant']
        expect(assigns(:volunteers)).to eq([])
        #assert_nil(assigns(:volunteers))
      end      
   end # /when testing index functionality of volunteers for tags
    
    
    context "when testing index functionality of volunteers for events" do     
      let!(:test_event_1) { Event.create!(name: 'dog event in SF', start: DateTime.new(2015,3,7), location: 'San Francisco') } 
      let!(:test_event_2) { Event.create!(name: 'event no tags in NY', start: DateTime.new(2015,3,8), location: 'New York') } 
      let!(:test_event_3) { Event.create!(name: 'cat event in NY', start: DateTime.new(2015,4,8), location: 'New York') } 
      let!(:test_event_4) { Event.create!(name: 'dog and cat event in SF', start: DateTime.new(2015,6,8), location: 'San Francisco') } 
      
      let!(:test_event_vol_1) { EventVolunteer.create!(event: test_event_1, volunteer: v1) }
      let!(:test_event_vol_2) { EventVolunteer.create!(event: test_event_2, volunteer: v1) }
      let!(:test_event_vol_3) { EventVolunteer.create!(event: test_event_3, volunteer: v1) }
      let!(:test_event_vol_5) { EventVolunteer.create!(event: test_event_1, volunteer: v2) }
      let!(:test_event_vol_6) { EventVolunteer.create!(event: test_event_2, volunteer: v2) }
      let!(:test_event_vol_7) { EventVolunteer.create!(event: test_event_3, volunteer: v3) }
      let!(:test_event_vol_8) { EventVolunteer.create!(event: test_event_1, volunteer: v4) }
     
      
      #       e1 = v1v2v4
      #       e2 = v1v2
      #       e3 = v1v3
      #       e4 = none
      it "assigns @volunteers when query event = e1" do
        get :index, event_ids: [test_event_1.id]
        expect(assigns(:volunteers)).to eq([v1,v2,v4])
      end
      
      it "assigns @volunteers when query event = e2" do
        get :index, event_ids: [test_event_2.id]
        expect(assigns(:volunteers)).to eq([v1,v2])
      end    
      
      it "assigns @volunteers when query event = e3" do
        get :index, event_ids: [test_event_3.id]
        expect(assigns(:volunteers)).to eq([v1,v3])
      end
      
      it "assigns @volunteers when query event = e4" do
        get :index, event_ids: [test_event_4.id]
        expect(assigns(:volunteers)).to eq([])
      end
     end # /when testing index functionality of volunteers for events
  end # /GET index
end