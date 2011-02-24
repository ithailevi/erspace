-include("power.hrl").
-include("engine.hrl").
% -include(ecosys.hrl)


-record(ecosys, {
    ship_temp=36.0, % avarage of unit temps
	gh_temp=30.0
	}).

-record(position, {
    xpos=0.0,
	ypos=0.0,
	zpos=0.0,
	xrot=0.0,
	yrot=0.0,
	zrot=0.0}).



-record(spacecraft, {
		power=#power{}, % main power source
		engine=#engine{}, % convert power to propultion
		ecosys=#ecosys{}, % ship eco system, oxygen, plants, food generation, water purification, recycling
		admin=null, % human resources system, user management, access management etc..
		wellfare=null, % crew wellfare, entertainment system, kitchen etc..
		med=null, % ship medical facilities
		weapons=null, % ship weapon systems
		nav=null, % ship navigation system
		shields=null, % ships shields and defense system
		cargo=null, % cargo and storage management 
		bank=null, % banking and finance
		comms=null, % communications systems
		docks=null, % docks and porting and loading unloading facilities
		safety=null, % safety systems, hatches, fire control, radiation control, firewall, cctv, etc..
		utils=null, % lights, toilets, pumps, 
	   	pos=#position{}	
	    }).
