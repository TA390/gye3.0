require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe "GET index" do
    # it "assigns @events in order" do
    #   #event1 = Event.create!()
    #   e1 = Event.create!(start: DateTime.new(2015,3,8))
    #   e2 = Event.create!(start: DateTime.new(2015,3,9))
    #   e3 = Event.create!(start: DateTime.new(2015,3,10))
    #   e4 = Event.create!(start: DateTime.new(2015,3,12))
    #   get :index
    #   expect(assigns(:events)).to eq([e1,e2,e3,e4])
    # end
    
    let(:unicef) { Ngo.create!(name: 'unicef', email: 'test@gmail.com', password: 'xzyabc123') }
    let(:wateraid) { Ngo.create!(name: 'wateraid', email: 'w@gmail.com', password: 'xzyabc123') }
    let(:gye) { Ngo.create!(name: 'gye', email: 'gye@gmail.com', password: 'xzyabc1234') }
    let!(:charityRus) { Ngo.create!(name: 'charityRus', email: 'crus@gmail.com', password: 'xzyabc123') } 
    
    let!(:unicefEvent) { Event.create!(name: 'unicef event', ngo: unicef, 
      start: DateTime.new(2016,1,8), end: DateTime.new(2016,1,8), location: 'London',
      description: 'blah blah', occupancy: '3') }
    let!(:gyeEvent) { Event.create!(name: 'gye event', ngo: gye, 
      start: DateTime.new(2016,4,8), end: DateTime.new(2016,4,8), location: 'NYC',
      description: 'blah blah', occupancy: '2') }
    let!(:wateraidEvent1) { Event.create!(name: 'wateraid event a', ngo: wateraid, 
      start: DateTime.new(2015,3,1), end: DateTime.new(2016,3,1), location: 'Milan',
      description: 'blah blah', occupancy: '1') }
    let!(:wateraidEvent2) { Event.create!(name: 'wateraid event b', ngo: wateraid, 
      start: DateTime.new(2017,3,1), end: DateTime.new(2017,3,1), location: 'Milan',
      description: 'blah blah', occupancy: '1') }


    context "when testing index functionality of tags" do
      # let creates test parameters and saves them for all tests in this context
      # Use `let` to define memoized helper method
      # let is lazy evaluated, use the '!' to force method's invocation before each test
      # '!' is not needed if child methods require parents method 
      # (e.g. test_event is needed in test_event_tag)
      let(:dog) { Tag.create!(name: 'dog') }
      let(:cat) { Tag.create!(name: 'cat') }
      
      let!(:test_event_tag_1) { EventTag.create!(tag: dog, event: unicefEvent) }
      let!(:test_event_tag_2) { EventTag.create!(tag: dog, event: gyeEvent) }
      let!(:test_event_tag_3) { EventTag.create!(tag: dog, event: wateraidEvent1) }
      let!(:test_event_tag_4) { EventTag.create!(tag: cat, event: wateraidEvent1) }
      
      it "assigns @events when query has no tags" do
        get :index
        expect(assigns(:events)).to eq([unicefEvent,wateraidEvent1,gyeEvent,wateraidEvent2])
      end
      
      it "assigns @events when query tags = dog" do
        get :index, tags: ['dog'] # <--- tbc query parameters for get request
        expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent])
      end
      
      it "assigns @events when query tags = cat" do
        get :index, tags: ['cat']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end
      
      it "assigns @events when query tags = potato" do
        get :index, tags: ['potato']
        expect(assigns(:events)).to eq([])
      end      
    end # /when tags = dog and cat
    
    
    context "when testing index functionality events for ngos" do

      it "assigns @events when query ngos = unicef" do
        get :index, ngos: ['unicef']
        expect(assigns(:events)).to eq([unicefEvent])
      end

      it "assigns @events when query ngos = wateraid" do
        get :index, ngos: ['wateraid']
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end

      it "assigns @events when query ngos = charity" do
        get :index, ngos: ['charityRus']
        expect(assigns(:events)).to eq([])
      end
    end # /when ngos = unicef, etc
    
  end # /GET index
end