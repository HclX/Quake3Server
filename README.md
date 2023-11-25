# A simple docker based IO Quake3 server
This docker image builds the IO Quake3 executables from source code, and runs
the dedicated server. However, it relies your existing IO Quake3 installation
to load the configuration and game resources. You can get all the resources
according to the IO Quake 3 installation guide, with some extra enhancement
downloads listed here. The idea behind this is that you can put your quake3
game on your NAS, modify server configurations and add new maps without
rebuilding the docker image.

To install/setup the game, do the following steps:

0. This installation requires [baseq3/pak0.pk3 file](https://github.com/nrempel/q3-server/raw/master/baseq3/pak0.pk3) from your owned original quake3 copy
1. Follow [the downloading link on ioquake3 site](https://ioquake3.org/get-it/)
2. Download [the patch data](https://ioquake3.org/extras/patch-data/) into baseq3 directory
3. For better experience, add the [High-Resolution Textures package](https://ioquake3.org/extras/replacement_content/) and the [High-Resolution 2D element package](https://www.moddb.com/games/quake-iii-arena/addons/pak9hqq36-q3q)

Assuming you have followed the above steps and installation directory is
`<Q3Dir>`, to configure the docker image, make sure you:
1. Create `<Q3Dir>/server/configs` and `<Q3Dir>/server/logs` folder to config
the server behavior and export sever logs
2. Map the following volumes:
    * `<Q3Dir>`/baseq3:/q3a/baseq3:ro
    * `<Q3Dir>`/server/logs:/var/log
    * `<Q3Dir>`/server/configs:/usr/local/games/quake3/.q3a/baseq3
3. Expose UDP port `27960`
4. Config environment variables `PUID` and `PGID` to the uid/gid of the `<Q3Dir>`
owner so the docker image can read/write to it.
5. Set `ADMIN_PASSWORD` environment variable if you want to use rcon commands

