defmodule Zombies.Location do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    latitude:  integer,
    longitude: integer
  }
  defstruct [:latitude, :longitude]

  field :latitude, 1, type: :int32
  field :longitude, 2, type: :int32
end

defmodule Zombies.Sighting do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    name:     String.t,
    location: Zombies.Location.t
  }
  defstruct [:name, :location]

  field :name, 1, type: :string
  field :location, 2, type: Zombies.Location
end

defmodule Zombies.SightingSummary do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    sighting_count: integer,
    radius:         float
  }
  defstruct [:sighting_count, :radius]

  field :sighting_count, 1, type: :int32
  field :radius, 2, type: :float
end

defmodule Zombies.SearchTarget do
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
    center: Zombies.Location.t,
    radius: float
  }
  defstruct [:center, :radius]

  field :center, 1, type: Zombies.Location
  field :radius, 2, type: :float
end

defmodule Zombies.Zombies.Service do
  use GRPC.Service, name: "zombies.Zombies"

  rpc :ReportSighting, stream(Zombies.Sighting), Zombies.SightingSummary
  rpc :ZombiesNearby, Zombies.SearchTarget, stream(Zombies.Sighting)
end

defmodule Zombies.Zombies.Stub do
  use GRPC.Stub, service: Zombies.Zombies.Service
end
