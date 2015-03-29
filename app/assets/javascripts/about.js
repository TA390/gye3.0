$(document).ready(function(){

  
  var substringMatcher = function(strs) {
    return function findMatches(q, cb) {
      var matches, substringRegex;

      // an array that will be populated with substring matches
      matches = [];

      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i');

      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(strs, function(i, str) {
        if (substrRegex.test(str)) {
          // the typeahead jQuery plugin expects suggestions to a
          // JavaScript object, refer to typeahead docs for more info
          matches.push({ value: str });
        }
      });

      cb(matches);
    };
  };

  var locations = ['Abbeville', 'Adamsville', 'Addison', 'Adger', 'Alabaster', 'Albertville', 'Alexander City', 'Alexandria', 'Allgood', 'Alpine', 'Andalusia', 'Anniston', 'Arab', 'Arlington', 'Ashfor', 'Ashland', 'Ashville', 'Athens', 'Atmore', 'Attalla', 'Auburn', 'Auburn University', 'Autaugaville', 'Axis', 'Bay Minette', 'Berry', 'Bessemer', 'Birmingham', 'Blountsville', 'Boaz', 'Bremen', 'Brewton', 'Brookwood', 'Brownsboro', 'Bucks', 'Buhl', 'Butler', 'Calera', 'Calhoun County', 'Camden', 'Carrollton', 'Centre', 'Centreville', 'Chapman', 'Chelsea', 'Cherokee', 'Childersburg', 'Clanton', 'Clayton', 'Clio', 'Coffeeville', 'Columbia', 'Columbiana', 'Cottondale', 'Cottonwood', 'Cowarts', 'Creola', 'Crossville', 'Cullman', 'Daleville', 'Daphne', 'Dauphin Island', 'Deatsville', 'Decatur', 'Demopolis', 'Dixons Mills', 'Dothan', 'Eastaboga', 'Eclectic', 'Eight Mile', 'Elba', 'Elberta', 'Enterprise', 'Eufaula', 'Eutaw', 'Evergreen', 'Excel', 'Fairfield', 'Fairhope', 'Fayette', 'Florence', 'Foley', 'Fruitdale', 'Ft Deposit', 'Ft Payne', 'Ft Rucker', 'Fulton', 'Fultondale', 'Gadsden', 'Gardendale', 'Geneva', 'Glenwood', 'Goodwater', 'Gordo', 'Grand Bay', 'Graysville', 'Greensboro', 'Greenville', 'Grove Hill', 'Guin', 'Gulf Shores', 'Guntersville', 'Haleyville', 'Hamilton', 'Hanceville', 'Hartselle', 'Hatchechubbee', 'Hayden', 'Hayneville', 'Hazel Green', 'Headland', 'Heflin', 'Helena', 'Hodges', 'Hope Hull', 'Huntsville', 'Huxford', 'Ider', 'Jack', 'Jackson', 'Jacksonville', 'Jasper', 'Jefferson', 'Kellyton', 'Killen', 'Laceys Spring', 'Lafayette', 'Lanett', 'Leeds', 'Leesburg', 'Lillian', 'Lincoln', 'Linden', 'Lineville', 'Livingston', 'Loachapoka', 'Locust Fork', 'Loxley', 'Luverne', 'Madison', 'Marion', 'Mathews', 'Millport', 'Millry', 'Mobile', 'Monroeville', 'Montevallo', 'Montgomery', 'Montrose', 'Morris', 'Moulton', 'Munford', 'Muscle Shoals', 'New Brockton', 'New Market', 'Newton', 'Newville', 'Normal', 'Northport', 'Notasulga', 'Oakman', 'Oneonta', 'Opelika', 'Opp', 'Orange Beach', 'Oxford', 'Ozark', 'Paint Rock', 'Pelham', 'Pell City', 'Pennington', 'Perdue Hill', 'Phenix City', 'Piedmont', 'Pike Road', 'Pine Hill', 'Pinson', 'Pleasant Grove', 'Prattville', 'Quinton', 'Ragland', 'Rainbow City', 'Rainsville', 'Ramer', 'Red Bay', 'Reform', 'Roanoke', 'Robertsdale', 'Russellville', 'Rutledge', 'Saginaw', 'Saraland', 'Scottsboro', 'Selma', 'Semmes', 'Shannon', 'Sheffield', 'Shelby', 'Spanish Fort', 'Springville', 'Sulligent', 'Sumiton', 'Summerdale', 'Sycamore', 'Sylacauga', 'Talladega', 'Tallassee', 'Theodore', 'Thomasville', 'Toney', 'Troy', 'Trussville', 'Tuscaloosa', 'Tuscumbia', 'Tuskegee', 'Tuskegee Institute', 'Union Springs', 'Valley', 'Vernon', 'Vinemont', 'Wadley', 'Walnut Grove', 'Warrior', 'Webb', 'Wedowee', 'Wetumpka', 'Winfield', 'York', 'Anchorage', 'Anderson', 'Angoon', 'Atqasuk', 'Barrow', 'Bethel', 'Clear', 'Cordova', 'Craig', 'Delta Junction', 'Dillingham', 'Eagle River', 'Eielson Afb', 'Elmendorf Afb', 'Fairbanks', 'Galena', 'Girdwood', 'Glennallen', 'Gustavus', 'Haines', 'Healy', 'Homer', 'Hoonah', 'Juneau', 'Kenai', 'Ketchikan', 'Klawock', 'Kodiak', 'Kotzebue', 'Mc Grath', 'Metlakatla', 'Mountain Village', 'Nikiski', 'Nome', 'North Pole', 'Palmer', 'Pelican', 'Petersburg', 'Port Lions', 'Seward', 'Sitka', 'Skagway', 'Soldotna', 'St Paul Island', 'Tanacross', 'Thorne Bay', 'Tok', 'Tununak', 'Unalaska', 'Valdez', 'Wasilla', 'Whittier', 'Wrangell', 'Yakutat', 'Ajo', 'Alpine', 'Amado', 'Apache Junction', 'Arizona City', 'Ash Fork', 'Avondale', 'Benson', 'Bisbee', 'Buckeye', 'Bullhead City', 'Camp Verde', 'Carefree', 'Casa Grande', 'Catalina', 'Cave Creek', 'Central', 'Chandler', 'Chinle', 'Chino Valley', 'Clarkdale', 'Clifton', 'Cochise', 'Colorado City', 'Congress', 'Coolidge', 'Cortaro', 'Cottonwood', 'Dateland', 'Dewey', 'Douglas', 'Duncan', 'Ehrenberg', 'El Mirage', 'Elgin', 'Eloy', 'Flagstaff', 'Florence', 'Fountain Hills', 'Fredonia', 'Ft Defiance', 'Ft Huachuca', 'Ft Mohave', 'Ft Thomas', 'Ganado', 'Gila Bend', 'Gilbert', 'Glendale', 'Globe', 'Goodyear', 'Grand Canyon', 'Green Valley', 'Hayden', 'Heber', 'Higley', 'Holbrook', 'Hotevilla', 'Joseph City', 'Kayenta', 'Keams Canyon', 'Kearny', 'Kingman', 'Kykotsmovi Village', 'Lake Havasu City', 'Lake Montezuma', 'Lakeside', 'Laveen', 'Litchfield Park', 'Littlefield', 'Luke Afb', 'Mammoth', 'Many Farms', 'Marana', 'Maricopa', 'Mayer', 'Mesa', 'Miami', 'Mohave County', 'Mohave Valley', 'Morenci', 'Morristown', 'Naco', 'New River', 'Nogales', 'Oracle', 'Page', 'Palo Verde', 'Paradise Valley', 'Parker', 'Parks', 'Payson', 'Peoria', 'Phoenix', 'Pima', 'Pinetop', 'Poston', 'Prescott', 'Prescott Valley', 'Quartzsite', 'Queen Creek', 'Red Rock', 'Rio Rico', 'Rio Verde', 'Sacaton', 'Safford', 'Sahuarita', 'Salome', 'San Carlos', 'San Luis', 'San Manuel', 'San Simon', 'Sanders', 'Scottsdale', 'Sedona', 'Seligman', 'Sells', 'Show Low', 'Sierra Vista', 'Skull Valley', 'Snowflake', 'Solomon', 'Somerton', 'Springerville', 'St David', 'St Johns', 'St Michaels', 'Stanfield', 'Sun City', 'Sun City West', 'Superior', 'Surprise', 'Teec Nos Pos', 'Tempe', 'Thatcher', 'Tolleson', 'Tombstone', 'Tonopah', 'Topawa', 'Tuba City', 'Tucson', 'Vail', 'Waddell', 'Wellton', 'Whiteriver', 'Wickenburg', 'Wikieup', 'Willcox', 'Williams', 'Window Rock', 'Winkelman', 'Winslow', 'Wittmann', 'Youngtown', 'Yuma', 'Adona', 'Alexander', 'Alma', 'Altheimer', 'Amity', 'Arkadelphia', 'Armorel', 'Ash Flat', 'Ashdown', 'Augusta', 'Bald Knob', 'Barling', 'Batesville', 'Bauxite', 'Bay', 'Beebe', 'Bella Vista', 'Benton', 'Bentonville', 'Berryville', 'Bigelow', 'Blytheville', 'Booneville', 'Bradford', 'Branch', 'Brinkley', 'Brockwell', 'Brookland', 'Bryant', 'Burdette', 'Cabot', 'Calico Rock', 'Camden', 'Carlisle', 'Carthage', 'Cave City', 'Center Ridge', 'Charleston', 'Charlotte', 'Cherokee Village', 'Clarendon', 'Clarksville', 'Clinton', 'Compton', 'Conway', 'Corning', 'Crossett', 'Danville', 'Dardanelle', 'De Queen', 'De Witt', 'Decatur', 'Dermott', 'Des Arc', 'Dumas', 'Dyess', 'El Dorado', 'Elm Springs', 'England', 'Enola', 'Eureka Springs', 'Fairfield Bay', 'Farmington', 'Fayetteville', 'Flippin', 'Floral', 'Fordyce', 'Forrest City', 'Fountain Hill', 'Friendship', 'Ft Smith', 'Gassville', 'Gentry', 'Gillham', 'Glenwood', 'Gould', 'Grady', 'Gravette', 'Greenbrier', 'Greenwood', 'Guion', 'Hackett', 'Hamburg', 'Hardy', 'Harrisburg', 'Harrison', 'Hartford', 'Hattieville', 'Hazen', 'Heber Springs', 'Hector', 'Helena', 'Higden', 'Hope', 'Hot Springs National Park', 'Hot Springs Village', 'Hoxie', 'Humphrey', 'Huntsville', 'Imboden', 'Jacksonville', 'Jasper', 'Jessieville', 'Joiner', 'Jonesboro', 'Keiser', 'Kensett', 'Lake Village', 'Lavaca', 'Lead Hill', 'Lepanto', 'Leslie', 'Little Rock', 'Little Rock Afb', 'Lockesburg', 'London', 'Lonoke', 'Lowell', 'Luxora', 'Lynn', 'Mabelvale', 'Magnolia', 'Malvern', 'Mammoth Spring', 'Mansfield', 'Marianna', 'Marion', 'Marked Tree', 'Marmaduke', 'Marshall', 'Maumelle', 'Maynard', 'Mc Crory', 'Mc Gehee', 'Mc Rae', 'Melbourne', 'Mena', 'Monticello', 'Morrilton', 'Mount Holly', 'Mount Ida', 'Mount Pleasant', 'Mount Vernon', 'Mountain Home', 'Mountain View', 'Mountainburg', 'Nashville', 'Newark', 'Newport', 'Norfork', 'Norman', 'North Little Rock', 'Osceola', 'Ozark', 'Palestine', 'Paragould', 'Paris', 'Pea Ridge', 'Pearcy', 'Piggott', 'Pine Bluff', 'Plainview', 'Plumerville', 'Pocahontas', 'Poplar Grove', 'Pottsville', 'Prairie Grove', 'Prescott', 'Quitman', 'Rector', 'Rison', 'Rogers', 'Romance', 'Rosston', 'Russellville', 'Salem', 'Saratoga', 'Scotland', 'Searcy', 'Sheridan', 'Sherwood', 'Siloam Springs', 'Smackover', 'Springdale', 'Stamps', 'Star City', 'State University', 'Stuttgart', 'Subiaco', 'Sulphur Rock', 'Swifton', 'Texarkana', 'Timbo', 'Tontitown', 'Trumann', 'Valley Springs', 'Van Buren', 'Vilonia', 'Waldo', 'Waldron', 'Walnut Ridge', 'Ward', 'Warren', 'Washington', 'Weiner', 'West Fork', 'West Helena', 'West Memphis', 'White Hall', 'Winslow', 'Wiseman', 'Wrightsville', 'Wynne', 'Yellville', 'Acton', 'Adelanto', 'Agoura Hills', 'Alameda', 'Alamo', 'Albany', 'Albion', 'Alhambra', 'Aliso Viejo', 'Alleghany', 'Alpaugh', 'Alpine', 'Alta', 'Altadena', 'Altaville', 'Alturas', 'Alviso', 'American Canyon', 'Anaheim', 'Anderson', 'Angels Camp', 'Angwin', 'Annapolis', 'Antelope', 'Antioch', 'Apple Valley', 'Aptos', 'Arbuckle', 'Arcadia', 'Arcata', 'Arnold', 'Aromas', 'Arroyo Grande', 'Artesia', 'Arvin', 'Atascadero', 'Atherton', 'Atwater', 'Auberry', 'Auburn', 'Avalon', 'Avenal', 'Avila Beach', 'Azusa', 'Badger', 'Baker', 'Bakersfield', 'Baldwin Park', 'Bangor', 'Banning', 'Barstow', 'Beale Afb', 'Beaumont', 'Bell', 'Bell Gardens', 'Bella Vista', 'Bellflower', 'Belmont', 'Belvedere Tiburon', 'Ben Lomond', 'Benicia', 'Berkeley', 'Bethel Island', 'Beverly Hills', 'Big Bear City', 'Big Bear Lake', 'Big Bend', 'Big Creek', 'Big Oak Flat', 'Big Pine', 'Big sur', 'Biggs', 'Bishop', 'Blairsden-Graeagle', 'Bloomington', 'Blue Jay', 'Blue Lake', 'Blythe', 'Bodega Bay', 'Bolinas', 'Bonita', 'Bonsall', 'Boonville', 'Boron', 'Borrego Springs', 'Boulder Creek', 'Boyes Hot Springs', 'Bradley', 'Brawley', 'Brea', 'Brentwood', 'Bridgeport', 'Bridgeville', 'Brisbane', 'Brookdale', 'Brooks', 'Buellton', 'Buena Park', 'Burbank', 'Burlingame', 'Burney', 'Burrel', 'Butte City', 'Buttonwillow', 'Byron', 'Cabazon', 'Calabasas', 'Calexico', 'California City', 'California Hot Springs', 'Calimesa', 'Calipatria', 'Calistoga', 'Calpella', 'Camarillo', 'Cambria', 'Camino', 'Camp Pendleton', 'Campbell', 'Campo', 'Camptonville', 'Canoga Park', 'Canyon', 'Canyon Country', 'Capistrano Beach', 'Capitola', 'Cardiff by the Sea', 'Carlsbad', 'Carmel', 'Carmel Valley', 'Carmichael', 'Carpinteria', 'Carson', 'Caruthers', 'Castaic', 'Castro Valley', 'Castroville', 'Cathedral City', 'Cayucos', 'Cazadero', 'Cedar Glen', 'Ceres', 'Cerritos', 'Challenge', 'Chatsworth', 'Chester', 'Chicago Park', 'Chico', 'Chinese Camp', 'Chino', 'Chino Hills', 'Chowchilla', 'Chualar', 'Chula Vista', 'Citrus Heights']

                   
                   

  $('.typeahead').typeahead({
    limit: 10,
    minLength: 1,
    hint: true,
    highlight: true

  },
  {
    name: 'locations',
    displayKey: 'value',
    source: substringMatcher(locations),

  });

}); 