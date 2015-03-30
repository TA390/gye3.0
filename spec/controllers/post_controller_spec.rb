require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe "GET index" do
    
    let(:unicef) { Ngo.create!(name: 'unicef', email: 'test@gmail.com', password: 'xzyabc123') }
    let(:wateraid) { Ngo.create!(name: 'wateraid', email: 'w@gmail.com', password: 'xzyabc123') }
    let!(:charityRus) { Ngo.create!(name: 'charityRus', email: 'crus@gmail.com', password: 'xzyabc123') } 
    
    let!(:unicefEvent) { Event.create!(name: 'test event a', ngo: unicef, 
      start: DateTime.new(2016,1,8), end: DateTime.new(2016,1,8), location: 'London',
      description: 'blah blah', occupancy: '3') }
    let!(:gyeEvent) { Event.create!(name: 'test event b', ngo: gye, 
      start: DateTime.new(2016,4,8), end: DateTime.new(2016,4,8), location: 'NYC',
      description: 'blah blah', occupancy: '2') }
    let!(:wateraidEvent1) { Event.create!(name: 'test event c', ngo: wateraid, 
      start: DateTime.new(2015,3,1), end: DateTime.new(2016,3,1), location: 'Milan',
      description: 'blah blah', occupancy: '1') }
    let!(:wateraidEvent2) { Event.create!(name: 'test event d', ngo: wateraid, 
      start: DateTime.new(2017,3,1), end: DateTime.new(2017,3,1), location: 'Milan',
      description: 'blah blah', occupancy: '1') }
  

    context "When users write on walls" do
      let!(:unicefEventWall) { Wall.create!(event: unicefEvent) }
      let!(:gyeEventWall) { Wall.create!(event: gyeEvent) }
      let!(:wateraidEvent1Wall) { Wall.create!(event: wateraidEvent1) }
      let!(:wateraidEvent2Wall) { Wall.create!(event: wateraidEvent2) }

      let!(:v1) { Volunteer.create!(name: 'aaaa', last_name: 'xyzd', email: 'testtest3@gmail.com', gender: 'M',
        location: 'London', password: 'giveyoureffort19') }
      let!(:v2) { Volunteer.create!(name: 'bbbb', last_name: 'xyzd', email: 'testtest2@gmail.com', gender: 'F',
        location: 'New York', password: 'giveyoureffort19') }      
      let!(:v3) { Volunteer.create!(name: 'cccc', last_name: 'xyzd', email: 'testtest4@gmail.com', gender: 'F',
        location: 'San Francisco', password: 'giveyoureffort19') }
      let!(:v4) { Volunteer.create!(name: 'dddd', last_name: 'xyzd', email: 'testtest1@gmail.com', gender: 'M',
        location: 'New York', password: 'giveyoureffort19') }    


      it "assigns @events when query ngos = charity" do
        get :index
        expect(assigns(:events)).to eq([])
      end


    # test event.wall show []

    # user a post wall
    # user b post wall
    # user c post wall

    # test event.wall show a,b,c

    # user b delete post wall

    # test event.wall show a,c



    # sort timestamp


    end # /when users write on walls






  end # /GET index
end