protoc -I priv --elixir_out=plugins=grpc:apps/zombieserver/lib priv/zombies.proto
protoc -I priv --elixir_out=plugins=grpc:apps/zombieclient/lib priv/zombies.proto