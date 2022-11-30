Config = {}

Config.Debug = true

Config.Blips = {}

Config.Tracker = {
    UpdateTime = 10,
    BlipTypes = {
        { -- Plane
            Label = "Plane",
            ID = 423,
            Color = 38,
            Scale = 0.75,
        },
        { -- Helicopter
            Label = "Helicopter",
            ID = 64,
            Color = 38,
            Scale = 0.75,
        },
    }
}

Config.Missions = {
    Blips = {
        PackagePickup = {
            Label = "Pickup Package",
            ID = 569,
            Color = 5,
            Scale = 0.75
        },
        PackageDropoff = {
            Label = "Drop-off Package",
            ID = 569,
            Color = 5,
            Scale = 0.75
        },
        PassengerPickup = {
            Label = "Pickup Passengers",
            ID = 569,
            Color = 5,
            Scale = 0.75
        },
        PassengerDropoff = {
            Label = "Drop-off Passengers",
            ID = 569,
            Color = 5,
            Scale = 0.75
        },
    },
    Sequences = {
        {
            Type = "Passenger",
            PassengerPickup = vector3(-1215.0138, -2647.5029, 14.5475),
            PassengerDropoff = vector3(1713.7322, 3253.1628, 41.6815),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Passenger",
            PassengerPickup = vector3(1713.7322, 3253.1628, 41.6815),
            PassengerDropoff = vector3(-1215.0138, -2647.5029, 14.5475),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Passenger",
            PassengerPickup = vector3(-1215.0138, -2647.5029, 14.5475),
            PassengerDropoff = vector3(2124.8884, 4804.3428, 41.7431),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Passenger",
            PassengerPickup = vector3(2124.8884, 4804.3428, 41.7431),
            PassengerDropoff = vector3(-1215.0138, -2647.5029, 14.5475),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Delivery",
            PackagePickup = vector3(-940.9973, -2954.2285, 13.9450),
            PackageDropoff = vector3(1720.2944, 3306.6436, 41.2235),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Delivery",
            PackagePickup = vector3(1720.2944, 3306.6436, 41.2235),
            PackageDropoff = vector3(-940.9973, -2954.2285, 13.9450),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Delivery",
            PackagePickup = vector3(-940.9973, -2954.2285, 13.9450),
            PackageDropoff = vector3(2137.6079, 4791.4370, 40.9703),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
        {
            Type = "Delivery",
            PackagePickup = vector3(2137.6079, 4791.4370, 40.9703),
            PackageDropoff = vector3(-940.9973, -2954.2285, 13.9450),
            Rewards = {
                {name = "money", min = 300, max = 500}
            }
        },
    }
}

Config.Airports = {
    {
        AirportTitle = "LSIA Airport",
        Blips = {
            Boarding = {
                Label = "Airport",
                ID = 423,
                Color = 5,
                Scale = 0.75
            }
        },
        Locations = {
            Boarding = vector3(-1042.4271, -2745.5457, 21.3594),
            Flight = vector3(-1287.2458, -2599.4785, 14.5466),
            Hangar = vector4(-1058.8749, -2963.2598, 13.9645, 147.2194),
        },
    },
    {
        AirportTitle = "Sandy Airfield",
        Blips = {
            Boarding = {
                Label = "Airport",
                ID = 423,
                Color = 5,
                Scale = 0.75
            }
        },
        Locations = {
            Boarding = vector3(1768.0939, 3296.6040, 41.1809),
            Flight = vector3(1740.0123, 3282.0764, 41.0884),
            Hangar = vector4(1766.9825, 3245.4485, 41.8806, 14.1263),
        },
    },
    {
        AirportTitle = "Grapeseed Airfield",
        Blips = {
            Boarding = {
                Label = "Airport",
                ID = 423,
                Color = 5,
                Scale = 0.75
            }
        },
        Locations = {
            Boarding = vector3(2159.0381, 4782.0737, 41.9610),
            Flight = vector3(2140.8184, 4815.4282, 41.2161),
            Hangar = vector4(2149.6863, 4808.7354, 41.1853, 107.2027),
        },
    },
}

Config.AirportSettings = {
    DepartureTime = 20,
    NPCFlightCost = 6500,
}

Config.Spawner = {
    Vehicles = {
        {label = "Luxor", description = "", model = `luxor`},
        {label = "Shamal", description = "", model = `shamal`},
        {label = "Cuban 800", description = "", model = `cuban800`},
        {label = "Jet", description = "", model = `jet`},
        {label = "Maverick", description = "", model = `maverick`},
        {label = "Super Volito", description = "", model = `supervolito`},
    }
}

U = {}

U.permission_denied = "You can't do this."

-- Delivery Mission

U.package_pickup_notify = "Go to the pickup location."
U.package_pickup = "Press ~INPUT_CONTEXT~ to pick up the package."
U.package_load_notify = "Bring the package into the aircraft."
U.package_flight_notify = "Fly the aircraft to the desination."
U.package_dropoff_notify = "Go to the drop-off location."
U.package_dropoff = "Press ~INPUT_CONTEXT~ to drop-off package."

-- Passenger Mission

U.passenger_pickup_notify = "Go to the flight terminal."
U.passenger_pickup = "Press ~INPUT_CONTEXT~ to pick up the passengers."
U.passenger_loading = "Loading Passengers..."
U.passenger_unloading = "Unloading Passengers..."
U.passenger_dropoff_notify = "Fly the aircraft to the desination."
U.passenger_dropoff = "Press ~INPUT_CONTEXT~ to drop-off the passengers."

-- Airport
U.Boarding_interact = "Press ~INPUT_CONTEXT~ to board a flight."
U.Boarding_npc_interact = "Press ~INPUT_CONTEXT~ to fly for: $"
U.Boarding_unavailable = "There are no flights available."
U.Boarding_broke = "You can't afford to purchase this plane ticket."
U.Boarding_full = "You can't join the flight as it is full."

U.Flight_interact = "Press ~INPUT_CONTEXT~ to start a flight."
U.Flight_return = "Press ~INPUT_CONTEXT~ to drop-off your passengers."
U.Flight_reject = "You need to be in a plane to start a flight."
U.Flight_denied = "You can't do this."

U.Hangar_interact = "Press ~INPUT_CONTEXT~ to retreive an aircraft."
U.Hangar_return = "Press ~INPUT_CONTEXT~ to return your aircraft."
U.Hangar_denied = "You can't do this."