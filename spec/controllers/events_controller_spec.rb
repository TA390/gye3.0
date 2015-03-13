require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe "GET index" do
    it "assigns @events in order" do
      #event1 = Event.create!()
      e1 = Event.create!(start: DateTime.new(2015,3,8))
      e2 = Event.create!(start: DateTime.new(2015,3,9))
      e3 = Event.create!(start: DateTime.new(2015,3,10))
      e4 = Event.create!(start: DateTime.new(2015,3,12))
      get :index
      expect(assigns(:events)).to eq([e1,e2,e3,e4])
    end
    
    context "when testing index functionality of tags" do
      # let creates test parameters and saves them for all tests in this context
      # Use `let` to define memoized helper method
      # let is lazy evaluated, use the '!' to force method's invocation before each test
      # '!' is not needed if child methods require parents method 
      # (e.g. test_event is needed in test_event_tag)
      let(:test_event) { Event.create!(name: 'test event dog tag', start: DateTime.new(2015,3,7)) } 
      let!(:test_event_2) { Event.create!(name: 'test event no tags', start: DateTime.new(2015,3,8)) } 
      let(:test_event_3) { Event.create!(name: 'test event dog tag', start: DateTime.new(2015,4,8)) } 
      let(:test_event_4) { Event.create!(name: 'test event dog & cat tags', start: DateTime.new(2015,6,8)) } 
      let(:test_tag) { Tag.create!(name: 'dog') }
      let(:test_tag_2) { Tag.create!(name: 'cat') }
      let!(:test_event_tag) { EventTag.create!(tag: test_tag, event: test_event) }
      let!(:test_event_tag_2) { EventTag.create!(tag: test_tag, event: test_event_3) }
      let!(:test_event_tag_3) { EventTag.create!(tag: test_tag, event: test_event_4) }
      let!(:test_event_tag_4) { EventTag.create!(tag: test_tag_2, event: test_event_4) }
      
      it "assigns @events when query has no tags" do
        get :index
        expect(assigns(:events)).to eq([test_event,test_event_2,test_event_3,test_event_4])
      end
      
      it "assigns @events when query tags = dog" do
        get :index, tags: ['dog'] # <--- tbc query parameters for get request
        expect(assigns(:events)).to eq([test_event,test_event_3,test_event_4])
      end
      
      it "assigns @events when query tags = cat" do
        get :index, tags: ['cat']
        expect(assigns(:events)).to eq([test_event_4])
      end
      
      it "assigns @events when query tags = potato" do
        get :index, tags: ['potato']
        expect(assigns(:events)).to eq([])
      end      
    end # /when tags = dog and cat
    
    
    context "when testing index functionality events for ngos" do
      let(:unicef) { Ngo.create!(name: 'unicef', email: 'test@gmail.com', password: 'xzyabc123') }
      let(:wateraid) { Ngo.create!(name: 'wateraid', email: 'w@gmail.com', password: 'xzyabc123') }
      let!(:charityRus) { Ngo.create!(name: 'charityRus', email: 'crus@gmail.com', password: 'xzyabc123') } 
      
      let!(:test_event_1) { Event.create!(name: 'test event', ngo: unicef, 
        start: DateTime.new(2016,1,8)) }
      let!(:test_event_2) { Event.create!(name: 'test event', ngo: unicef, 
        start: DateTime.new(2016,4,8)) }
      let!(:test_event_3) { Event.create!(name: 'test event', ngo: wateraid, 
        start: DateTime.new(2015,3,1)) }
      

      it "assigns @events when query ngos = unicef" do
        get :index, ngos: ['unicef']
        expect(assigns(:events)).to eq([test_event_1, test_event_2])
      end

      it "assigns @events when query ngos = wateraid" do
        get :index, ngos: ['wateraid']
        expect(assigns(:events)).to eq([test_event_3])
      end

      it "assigns @events when query ngos = charity" do
        get :index, ngos: ['charityRus']
        expect(assigns(:events)).to eq([])
      end
    end # /when ngos = unicef
  end # /GET index
end