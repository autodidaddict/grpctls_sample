defmodule Zombieserver.Zombies.Server do
    use GRPC.Server, service: Zombies.Zombies.Service 
    alias GRPC.Server
    alias Zombieserver.Data
   
    @spec report_sighting(Enumerable.t, GRPC.Server.Stream.t) :: Zombies.SightingSummary.t 
    def report_sighting(req_enum, _stream) do
        Zombies.SightingSummary.new(sighting_count: 1, radius: 0) 
    end

    @spec zombies_nearby(Zombies.Target.t, GRPC.Server.Stream.t) :: any 
    def zombies_nearby(target, stream) do
        zombies = Data.fetch_zombies
        zombies 
        |> Enum.each( fn zombie -> Server.stream_send(stream, zombie) end)
    end
end