defmodule Zombieclient.App do
    use Application

    @ca_cert_path   Path.expand("./Zombie_Spotters_Ltd.crt", :code.priv_dir(:zombieclient))
    @cert_path      Path.expand("./zombieclient.crt", :code.priv_dir(:zombieclient))
    @key_path       Path.expand("./zombieclient.key", :code.priv_dir(:zombieclient))

    def start(_type, _args) do
        import Supervisor.Spec

        cred = GRPC.Credential.new(ssl: [cacertfile: @ca_cert_path, certfile: @cert_path, keyfile: @key_path])

        children = [
            supervisor(Zombieclient.Consumer, [cred]),            
        ]
          
        opts = [strategy: :one_for_one, name: Routeguide]
        Supervisor.start_link(children, opts)
    end    
end