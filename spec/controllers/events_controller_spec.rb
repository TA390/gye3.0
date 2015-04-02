require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  describe "GET index" do
    
    let(:unicef) { Ngo.create!(name: 'unicef', email: 'test123456@gmail.com', password: 'xzyabc123') }
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
      start: DateTime.new(2015,12,1), end: DateTime.new(2015,12,1), location: 'Milan',
      description: 'blah blah', occupancy: '2') }
    let!(:wateraidEvent2) { Event.create!(name: 'wateraid event b', ngo: wateraid, 
      start: DateTime.new(2017,3,1), end: DateTime.new(2017,3,1), location: 'Milan',
      description: 'blah blah', occupancy: '2') }
    
    # let creates test parameters and saves them for all tests in this context
    # Use `let` to define memoized helper method
    # let is lazy evaluated, use the '!' to force method's invocation before each test
    # '!' is not needed if child methods require parents method 
    # (e.g. test_event is needed in test_event_tag)
    let(:dog) { Tag.create!(name: 'dog') }
    let(:cat) { Tag.create!(name: 'cat') }
    let(:mouse) { Tag.create!(name: 'mouse') }

    let!(:test_event_tag_1) { EventTag.create!(tag: dog, event: unicefEvent) }
    let!(:test_event_tag_2) { EventTag.create!(tag: dog, event: gyeEvent) }
    let!(:test_event_tag_3) { EventTag.create!(tag: dog, event: wateraidEvent1) }
    let!(:test_event_tag_4) { EventTag.create!(tag: cat, event: wateraidEvent1) }
    let!(:test_event_tag_5) { EventTag.create!(tag: mouse, event: wateraidEvent1) }
    
    context "when testing index functionality events by location" do
      it "assigns @events when query loc = London" do
        get :index, location: ['London']
        expect(assigns(:events)).to eq([unicefEvent])
      end
      
      it "assigns @events when query loc = NYC" do
        get :index, location: ['NYC']
        expect(assigns(:events)).to eq([gyeEvent])
      end
      
      it "assigns @events when query loc = Milan" do
        get :index, location: ['Milan']
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end
      
      it "assigns @events when query loc = Mars" do
        get :index, location: ['Mars']
        expect(assigns(:events)).to eq([])
      end
    end # /when searching by location
    
    context "when testing index functionality events by start and end dates" do
      #wat1(2015,12,1) uni(2016,1,8) gye(2016,4,8) wat2(2017,3,1)
      it "assigns @events when query start = 2016-04-08" do
        get :index, startdate: ['2016-04-08']
        expect(assigns(:events)).to eq([gyeEvent])
      end
      
      it "assigns @events when query start = 2017-03-01" do
        get :index, startdate: ['2017-03-01']
        expect(assigns(:events)).to eq([wateraidEvent2])
      end    

      it "assigns @events when query end = 2015-12-01" do
        get :index, enddate: ['2015-12-01']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end    
      
      it "assigns @events when query end = 2016-01-08" do
        get :index, enddate: ['2016-01-08']
        expect(assigns(:events)).to eq([unicefEvent])
      end    
      
      it "assigns @events when query end = 2020-01-08" do
        get :index, enddate: ['2020-01-08']
        expect(assigns(:events)).to eq([])
      end    
      
      #wat1(2015,12,1) uni(2016,1,8) gye(2016,4,8) wat2(2017,3,1)
#       it "assigns @events when query start = today end = 2015-12-31" do
#         get :index, startdate: [DateTime.now], enddate: ['2015-12-31']
#         expect(assigns(:events)).to eq([wateraidEvent1])
#       end    
      
      it "assigns @events when query start = 2016-01-01 end = 2016-12-31" do
        get :index, startdate: ['2016-01-01'], enddate: ['2016-12-31']
        expect(assigns(:events)).to eq([unicefEvent,gyeEvent])
      end    
            
#       it "assigns @events when query start = today end = 2017-12-31" do
#         get :index, startdate: [DateTime.now], enddate: ['2017-12-31']
#         expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent,wateraidEvent2])
#       end    
            
      it "assigns @events when query start = 2015-06-01 end = 2015-06-05" do
        get :index, startdate: ['2015-06-01'], enddate: ['2015-06-05']
        expect(assigns(:events)).to eq([])
      end    
    end # /when searching by dates    
    
    context "when testing index functionality of tags" do
#       it "assigns @events when query has no tags" do
#         get :index
#         expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent,wateraidEvent2])
#       end
      
      it "assigns @events when query tags = dog" do
        get :index, tags: ['dog']
        expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent])
      end
      
      it "assigns @events when query tags = cat" do
        get :index, tags: ['cat']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end
      
      it "assigns @events when query tags = cat AND dog" do
        get :index, tags: ['dog' , 'cat']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end

      it "assigns @events when query tags = cat AND dog AND mouse" do
        get :index, tags: ['dog' , 'cat', 'mouse']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end
      
      it "assigns @events when query tags = potato" do
        get :index, tags: ['potato']
        expect(assigns(:events)).to eq([])
      end      
    end # /when tags = dog and cat
    
    
    context "when testing index functionality events for ngos" do
      it "assigns @events when query ngos = gye" do
        get :index, ngos: ['gye']
        expect(assigns(:events)).to eq([gyeEvent])
      end
      
#       it "assigns @events when query ngos = unicef" do
#         get :index, ngos: ['unicef']
#         expect(assigns(:events)).to eq([unicefEvent])
#       end
      
      it "assigns @events when query ngos = wateraid" do
        get :index, ngos: ['wateraid']
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end

      it "assigns @events when query ngos = charity" do
        get :index, ngos: ['charityRus']
        expect(assigns(:events)).to eq([])
      end
    end # /when ngos = unicef, etc
    
    context "when testing index functionality events with vols" do
      let!(:v1) { Volunteer.create!(name: 'aaaa', last_name: 'xyzd', email: 'testtest101@gmail.com', gender: 'M',    
        location: 'London', password: 'giveyoureffort19') }
      let!(:v2) { Volunteer.create!(name: 'bbbb', last_name: 'xyzd', email: 'testtest102@gmail.com', gender: 'F',
        location: 'New York', password: 'giveyoureffort19') }  
      let!(:v3) { Volunteer.create!(name: 'cccc', last_name: 'xyzd', email: 'testtest103@gmail.com', gender: 'F',
        location: 'SF', password: 'giveyoureffort19') }  
      let!(:test_event_vol_1) { EventVolunteer.create!(event: unicefEvent, volunteer: v1) }
      let!(:test_event_vol_2) { EventVolunteer.create!(event: gyeEvent, volunteer: v1) }
      let!(:test_event_vol_3) { EventVolunteer.create!(event: wateraidEvent1, volunteer: v1) }
      let!(:test_event_vol_5) { EventVolunteer.create!(event: wateraidEvent1, volunteer: v2) }
      let!(:test_event_vol_6) { EventVolunteer.create!(event: wateraidEvent2, volunteer: v2) }
      
      it "assigns @events when vol id passed in" do
        get :index, vid: [v1.id]
        expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent])
      end

      it "assigns @events when vol id passed in" do
        get :index, vid: [v2.id]
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end
      
      it "assigns @events when vol id passed in" do
        get :index, vid: [v3.id]
        expect(assigns(:events)).to eq([])
      end
    end # /when vols sign up to events    
    

    context "when testing index functionality events by tags (mult) and dates" do
      # wat1(2015,12,1) uni(2016,1,8) gye(2016,4,8) wat2(2017,3,1)
      it "assigns @events when query tags = dog AND cat, startdate = today enddate = 2015-12-31" do
        get :index, tags: ['dog' , 'cat'], startdate: [DateTime.now], enddate: ['2015-12-31']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end
      
      it "assigns @events when query tags = dog AND cat, startdate = 2015-12-20 enddate = 2015-12-31" do
        get :index, tags: ['dog' , 'cat'], startdate: ['2015-12-02'], enddate: ['2015-12-31']
        expect(assigns(:events)).to eq([])
      end         
      
      it "assigns @events when query tags = dog, startdate = today enddate = 2016-12-31" do
        get :index, tags: ['dog'], startdate: [DateTime.now], enddate: ['2016-12-31']
        expect(assigns(:events)).to eq([wateraidEvent1,unicefEvent,gyeEvent])
      end
      
      it "assigns @events when query tags = dog, startdate = 2016-04-08 enddate = 2016-04-08" do
        get :index, tags: ['dog'], startdate: ['2016-04-08'], enddate: ['2016-04-08']
        expect(assigns(:events)).to eq([gyeEvent])
      end
      
      it "assigns @events when query tags = dog, startdate = 2016-04-09 enddate = 2016-04-09" do
        get :index, tags: ['dog'], startdate: ['2016-04-09'], enddate: ['2016-04-09']
        expect(assigns(:events)).to eq([])
      end
    end # /when searching by tags (mult) and dates
    

    context "when testing index functionality events by loc and dates" do
      # wat1(2015,12,1)Milan, uni(2016,1,8)London, gye(2016,4,8)NYC, wat2(2017,3,1)Milan
      
      it "assigns @events when query loc = NYC, startdate = 2016-04-08 enddate = 2016-04-08" do
        get :index, location: ['NYC'], startdate: ['2016-04-08'], enddate: ['2016-04-08']
        expect(assigns(:events)).to eq([gyeEvent])
      end
      
      it "assigns @events when query loc = Milan, startdate = today enddate = 2017-12-31" do
        get :index, location: ['Milan'], startdate: [DateTime.now], enddate: ['2017-12-31']
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end
            
      it "assigns @events when query loc = Milan, startdate = today enddate = 2015-11-28" do
        get :index, location: ['Milan'], startdate: [DateTime.now], enddate: ['2015-11-28']
        expect(assigns(:events)).to eq([])
      end
      
      it "assigns @events when query loc = London, startdate = today enddate = 2016-01-31" do
        get :index, location: ['London'], startdate: [DateTime.now], enddate: ['2016-01-31']
        expect(assigns(:events)).to eq([unicefEvent])
      end
      
      it "assigns @events when query loc = London, startdate = today enddate = 2016-01-31" do
        get :index, location: ['London'], startdate: ['2016-01-05'], enddate: ['2016-01-07']
        expect(assigns(:events)).to eq([])
      end 
    end # /when searching by loc and dates    

    
    context "when testing index functionality events by loc and tags (mult)" do
      # wat1(2015,12,1)Milan, uni(2016,1,8)London, gye(2016,4,8)NYC, wat2(2017,3,1)Milan
      # [dog,cat,mouse]       [dog]                [dog]             []
      it "assigns @events when query loc = NYC, tags = dog" do
        get :index, location: ['NYC'], tags: ['dog']
        expect(assigns(:events)).to eq([gyeEvent])
      end
            
      it "assigns @events when query loc = NYC, tags = cat" do
        get :index, location: ['NYC'], tags: ['cat']
        expect(assigns(:events)).to eq([])
      end
      
      it "assigns @events when query loc = Milan, tags = cat, dog, mouse" do
        get :index, location: ['Milan'], tags: ['cat' , 'dog' , 'mouse']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end
      
      it "assigns @events when query loc = Milan, tags = mouse, dog, cat" do
        get :index, location: ['Milan'], tags: ['mouse', 'dog', 'cat']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end      
            
      it "assigns @events when query loc = Milan, tags = elephant" do
        get :index, location: ['Milan'], tags: ['elephant']
        expect(assigns(:events)).to eq([])
      end
      
      it "assigns @events when query loc = London, tags = dog" do
        get :index, location: ['London'], tags: ['dog']
        expect(assigns(:events)).to eq([unicefEvent])
      end
      
      it "assigns @events when query loc = London, tags = dog" do
        get :index, location: ['London'], tags: ['mouse']
        expect(assigns(:events)).to eq([])
      end
    end # /when searching by loc and tags (mult)       
   
    
    context "when testing index functionality events by start, end, loc, and tags (mult)" do 
      let!(:test_event_tag_6) { EventTag.create!(tag: mouse, event: wateraidEvent2) }
      # wat1(2015,12,1)Milan, uni(2016,1,8)London, gye(2016,4,8)NYC, wat2(2017,3,1)Milan
      # [dog,cat,mouse]       [dog]                [dog]             [mouse]
      it "assigns @events when query loc = NYC, tags = dog, start = 2016-04-08, end = 2016-04-08" do
        get :index, location: ['NYC'], tags: ['dog'], startdate: ['2016-04-08'], enddate: ['2016-04-08']
        expect(assigns(:events)).to eq([gyeEvent])
      end
            
      it "assigns @events when query loc = NYC, tags = dog, start = today, end = 2016-04-07" do
        get :index, location: ['NYC'], tags: ['dog'], startdate: [DateTime.now], enddate: ['2016-04-07']
        expect(assigns(:events)).to eq([])
      end
      
      it "assigns @events when query loc = Milan, tags = cat, dog, mouse, start = 2015-12-01, end = 2015-12-01" do
        get :index, location: ['Milan'], tags: ['cat' , 'dog' , 'mouse'],
        startdate: ['2015-12-01'], enddate: ['2015-12-01']
        expect(assigns(:events)).to eq([wateraidEvent1])
      end

      it "assigns @events when query loc = Milan, tags = mouse, start = today, end = 2017-03-01" do
        get :index, location: ['Milan'], tags: ['mouse'],
        startdate: [DateTime.now], enddate: ['2017-03-01']
        expect(assigns(:events)).to eq([wateraidEvent1,wateraidEvent2])
      end
      
      it "assigns @events when query loc = Milan, tags = mouse, start = today, end = 2015-11-01" do
        get :index, location: ['Milan'], tags: ['mouse'],
        startdate: [DateTime.now], enddate: ['2015-11-01']
        expect(assigns(:events)).to eq([])
      end
      
      it "assigns @events when query loc = London, tags = dog, start = 2016-01-08, end = 2016-01-08" do
        get :index, location: ['London'], tags: ['dog'], startdate: ['2016-01-08'], enddate: ['2016-01-08']
        expect(assigns(:events)).to eq([unicefEvent])
      end
      
      it "assigns @events when query loc = London, tags = dog, start = 2016-01-08, end = 2016-01-08" do
        get :index, location: ['London'], tags: ['dog'], startdate: ['2016-01-09'], enddate: ['2016-01-09']
        expect(assigns(:events)).to eq([])
      end
    end # /when searching by start, end, loc, and tags (mult)        
    
    
  end # /GET index
end