package models;


public class CovidModel {
	public class CountryInfo{
	    public int _id;
	    public String iso2;
	    public String iso3;
	    public int lat;
	    public int Long;
	    public String flag;
		public int get_id() {
			return _id;
		}
		public void set_id(int _id) {
			this._id = _id;
		}
		public String getIso2() {
			return iso2;
		}
		public void setIso2(String iso2) {
			this.iso2 = iso2;
		}
		public String getIso3() {
			return iso3;
		}
		public void setIso3(String iso3) {
			this.iso3 = iso3;
		}
		public int getLat() {
			return lat;
		}
		public void setLat(int lat) {
			this.lat = lat;
		}
		public int getLong() {
			return Long;
		}
		public void setLong(int l) {
			Long = l;
		}
		public String getFlag() {
			return flag;
		}
		public void setFlag(String flag) {
			this.flag = flag;
		}
	    
	}

	    public long updated;
	    public String country;
	    public CountryInfo countryInfo;
	    public int cases;
	    public int todayCases;
	    public int deaths;
	    public int todayDeaths;
	    public int recovered;
	    public int todayRecovered;
	    public int active;
	    public int critical;
	    public int casesPerOneMillion;
	    public int deathsPerOneMillion;
	    public int tests;
	    public int testsPerOneMillion;
	    public int population;
	    public String continent;
	    public int oneCasePerPeople;
	    public int oneDeathPerPeople;
	    public int oneTestPerPeople;
	    public double activePerOneMillion;
	    public double recoveredPerOneMillion;
	    public double criticalPerOneMillion;
		public long getUpdated() {
			return updated;
		}
		public void setUpdated(long updated) {
			this.updated = updated;
		}
		public String getCountry() {
			return country;
		}
		public void setCountry(String country) {
			this.country = country;
		}
		public CountryInfo getCountryInfo() {
			return countryInfo;
		}
		public void setCountryInfo(CountryInfo countryInfo) {
			this.countryInfo = countryInfo;
		}
		
		public int getCases() {
			return cases;
		}
		public void setCases(int cases) {
			this.cases = cases;
		}
		public int getTodayCases() {
			return todayCases;
		}
		public void setTodayCases(int todayCases) {
			this.todayCases = todayCases;
		}
		public int getDeaths() {
			return deaths;
		}
		public void setDeaths(int deaths) {
			this.deaths = deaths;
		}
		public int getTodayDeaths() {
			return todayDeaths;
		}
		public void setTodayDeaths(int todayDeaths) {
			this.todayDeaths = todayDeaths;
		}
		public int getRecovered() {
			return recovered;
		}
		public void setRecovered(int recovered) {
			this.recovered = recovered;
		}
		public int getTodayRecovered() {
			return todayRecovered;
		}
		public void setTodayRecovered(int todayRecovered) {
			this.todayRecovered = todayRecovered;
		}
		public int getActive() {
			return active;
		}
		public void setActive(int active) {
			this.active = active;
		}
		public int getCritical() {
			return critical;
		}
		public void setCritical(int critical) {
			this.critical = critical;
		}
		public int getCasesPerOneMillion() {
			return casesPerOneMillion;
		}
		public void setCasesPerOneMillion(int casesPerOneMillion) {
			this.casesPerOneMillion = casesPerOneMillion;
		}
		public int getDeathsPerOneMillion() {
			return deathsPerOneMillion;
		}
		public void setDeathsPerOneMillion(int deathsPerOneMillion) {
			this.deathsPerOneMillion = deathsPerOneMillion;
		}
		public int getTests() {
			return tests;
		}
		public void setTests(int tests) {
			this.tests = tests;
		}
		public int getTestsPerOneMillion() {
			return testsPerOneMillion;
		}
		public void setTestsPerOneMillion(int testsPerOneMillion) {
			this.testsPerOneMillion = testsPerOneMillion;
		}
		public int getPopulation() {
			return population;
		}
		public void setPopulation(int population) {
			this.population = population;
		}
		public String getContinent() {
			return continent;
		}
		public void setContinent(String continent) {
			this.continent = continent;
		}
		public int getOneCasePerPeople() {
			return oneCasePerPeople;
		}
		public void setOneCasePerPeople(int oneCasePerPeople) {
			this.oneCasePerPeople = oneCasePerPeople;
		}
		public int getOneDeathPerPeople() {
			return oneDeathPerPeople;
		}
		public void setOneDeathPerPeople(int oneDeathPerPeople) {
			this.oneDeathPerPeople = oneDeathPerPeople;
		}
		public int getOneTestPerPeople() {
			return oneTestPerPeople;
		}
		public void setOneTestPerPeople(int oneTestPerPeople) {
			this.oneTestPerPeople = oneTestPerPeople;
		}
		public double getActivePerOneMillion() {
			return activePerOneMillion;
		}
		public void setActivePerOneMillion(double activePerOneMillion) {
			this.activePerOneMillion = activePerOneMillion;
		}
		public double getRecoveredPerOneMillion() {
			return recoveredPerOneMillion;
		}
		public void setRecoveredPerOneMillion(double recoveredPerOneMillion) {
			this.recoveredPerOneMillion = recoveredPerOneMillion;
		}
		public double getCriticalPerOneMillion() {
			return criticalPerOneMillion;
		}
		public void setCriticalPerOneMillion(double criticalPerOneMillion) {
			this.criticalPerOneMillion = criticalPerOneMillion;
		}
		
		
	
	    
}
