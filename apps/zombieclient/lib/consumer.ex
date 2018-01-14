defmodule Zombieclient.Consumer do
    
    def start_link(cred) do
        IO.puts "started zombie sighting consumer"
        opts = [cred: cred]
        {:ok, channel} = GRPC.Stub.connect("localhost:10000", opts)
        get_zombies(channel)
        Agent.start_link(fn -> %{zombies: []} end, name: __MODULE__)
    end


    def get_zombies(channel) do
        IO.puts "getting zombies"
        center = Zombies.Location.new(latitude: 400000000, longitude: -750000000)
        target = Zombies.SearchTarget.new(center: center, radius: 12.5)
        stream = channel |> Zombies.Zombies.Stub.zombies_nearby(target)
        Enum.each stream, fn (zombie)->
            IO.inspect zombie
        end 
    end  
end