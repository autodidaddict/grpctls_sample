defmodule Zombieserver.Data do
    @json_path Path.expand("../priv/zombie_db.json", __DIR__)

    def start_link do        
        zombies = load_zombies()
        Agent.start_link(fn -> %{zombies: zombies} end, name: __MODULE__)
    end
   
    def fetch_zombies do
        Agent.get(__MODULE__, &Map.get(&1, :zombies))
    end

    defp load_zombies(path \\ @json_path) do
        data = File.read!(path)
        items = Poison.Parser.parse!(data)
        Enum.map items, fn (%{"location" => location, "name" => name}) ->
            loc = Zombies.Location.new(latitude: location["latitude"], longitude: location["longitude"])
            Zombies.Sighting.new(name: name, location: loc)
        end 
    end
end