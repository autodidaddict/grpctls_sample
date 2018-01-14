defmodule Zombieserver.App do
    use Application

    @ca_cert_path   Path.expand("./Zombie_Spotters_Ltd.crt", :code.priv_dir(:zombieserver))
    @cert_path      Path.expand("./zombieserver.crt", :code.priv_dir(:zombieserver))
    @key_path       Path.expand("./zombieserver.key", :code.priv_dir(:zombieserver))

    def start(_type, _args) do
        import Supervisor.Spec

        children = [
            supervisor(Zombieserver.Data, []),
            supervisor(GRPC.Server.Supervisor, [start_args()])
        ]

        opts = [strategy: :one_for_one, name: Zombieserver]
        Supervisor.start_link(children, opts)
    end

    defp start_args do
        cred = GRPC.Credential.new(ssl: [certfile: @cert_path, 
                keyfile: @key_path,
                cacertfile: @ca_cert_path,
                secure_renegotiate: true, 
                reuse_sessions: true,
                verify: :verify_peer,                                 
                fail_if_no_peer_cert: true]
            )
        IO.inspect cred
        {Zombieserver.Zombies.Server, 10000, cred: cred}
    end
end