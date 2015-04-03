require 'rails_helper'

RSpec.describe VolunteersController, :type => :controller do
  describe "GET index" do
      
    let!(:v1) { Volunteer.create!(name: 'aaaa', last_name: 'xyzd', email: 'testtest3@gmail.com', gender: 'M',
      location: 'London', password: 'giveyoureffort19') }
    let!(:v2) { Volunteer.create!(name: 'bbbb', last_name: 'xyzd', email: 'testtest2@gmail.com', gender: 'F',
      location: 'New York', password: 'giveyoureffort19') }      
    let!(:v3) { Volunteer.create!(name: 'cccc', last_name: 'xyzd', email: 'testtest4@gmail.com', gender: 'F',
      location: 'San Francisco', password: 'giveyoureffort19') }
    let!(:v4) { Volunteer.create!(name: 'dddd', last_name: 'xyzd', email: 'testtest1@gmail.com', gender: 'M',
      location: 'New York', password: 'giveyoureffort19') }    
    
    
    context "when testing index functionality of volunteers for locations" do      
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
        get :index, tags: ['dog','cat']
        expect(assigns(:volunteers)).to eq([v4])
      end

      it "assigns @volunteers when query tag = dog and cat, loc = NY" do
        get :index, tags: ['dog','cat'], location: ['New York']
        expect(assigns(:volunteers)).to eq([v4])
      end  
      
      let!(:test_vol_tag_5) { VolunteerTag.create!(tag: dog, volunteer: v2) }
      it "assigns @volunteers when query tag = dog, loc = NY" do
        get :index, tags: ['dog'], location: ['New York']
        expect(assigns(:volunteers)).to eq([v2,v4])
      end        
            
      it "assigns @volunteers when query tag = cat, loc = SF" do
        get :index, tags: ['cat'], location: ['San Francisco']
        expect(assigns(:volunteers)).to eq([v3])
      end        
      
      it "assigns @volunteers when query tag = elephant" do
        get :index, tags: ['elephant']
        expect(assigns(:volunteers)).to eq([])
      end      
   end # /when testing index functionality of volunteers for tags
    
    
    context "when testing index functionality of volunteers for events" do     
      let!(:unicef) { Ngo.create!(name: 'unicef', email: 'test201@gmail.com', password: 'xzyabc123') }
      
      let!(:dog_sf) { Event.create!(name: 'dog event in SF', start: DateTime.new(2016,3,7),
        end: DateTime.new(2016,3,7), location: 'San Francisco', ngo: unicef, description: 'blah', occupancy: '3') } 
      let!(:none_nyc) { Event.create!(name: 'event no tags in NY', start: DateTime.new(2016,3,8),
        end: DateTime.new(2016,3,8), location: 'New York', ngo: unicef, description: 'blah', occupancy: '3') } 
      let!(:cat_nyc) { Event.create!(name: 'cat event in NY', start: DateTime.new(2016,4,8), 
        end: DateTime.new(2016,4,8), location: 'New York', ngo: unicef, description: 'blah', occupancy: '3') } 
      let!(:dogcat_sf) { Event.create!(name: 'dog and cat event in SF', start: DateTime.new(2016,6,8), 
        end: DateTime.new(2016,6,8), location: 'San Francisco', ngo: unicef, description: 'blah', occupancy: '3') } 
      
      let!(:test_event_vol_1) { EventVolunteer.create!(event: dog_sf, volunteer: v1) }
      let!(:test_event_vol_2) { EventVolunteer.create!(event: none_nyc, volunteer: v1) }
      let!(:test_event_vol_3) { EventVolunteer.create!(event: cat_nyc, volunteer: v1) }
      let!(:test_event_vol_5) { EventVolunteer.create!(event: dog_sf, volunteer: v2) }
      let!(:test_event_vol_6) { EventVolunteer.create!(event: none_nyc, volunteer: v2) }
      let!(:test_event_vol_7) { EventVolunteer.create!(event: cat_nyc, volunteer: v3) }
      let!(:test_event_vol_8) { EventVolunteer.create!(event: dog_sf, volunteer: v4) }
      #       e1 = v1v2v4
      #       e2 = v1v2
      #       e3 = v1v3
      #       e4 = none
      
      it "assigns @volunteers when query event = e1" do
        get :index, event_id: [dog_sf.id]
        expect(assigns(:volunteers)).to eq([v1,v2,v4])
      end
      
      it "assigns @volunteers when query event = e2" do
        get :index, event_id: [none_nyc.id]
        expect(assigns(:volunteers)).to eq([v1,v2])
      end    
      
      it "assigns @volunteers when query event = e3" do
        get :index, event_id: [cat_nyc.id]
        expect(assigns(:volunteers)).to eq([v1,v3])
      end
      
      it "assigns @volunteers when query event = e4" do
        get :index, event_id: [dogcat_sf.id]
        expect(assigns(:volunteers)).to eq([])
      end
 
     end # /when testing index functionality of volunteers for events
  end # /GET index
end