# Tinker

`tinker-client` is a project that serves tinker's ui.

## Setting up

### Development

Setting up for development isn't that hard, but there are a few steps to it. In
the future I might make a script to automate this to some extent. For now, here
are the instructions:

```
$ git clone --recursive https://github.com/tinker/tinker-client.git
$ cd tinker-client
$ mkdir public
$ cd ui && npm install && cd -
$ ./ui/bin/devsetup public
$ cp config/config-sample.json config/config.json
$ vim config/config.json
```

At this point you'll want to point all the urls to the correct place on your
system. I use [pow][pow] locally, so I have everything set up under `.dev`
domains. If you use thin or some other server your urls may look more like
`http://localhost:3000` or so.

### Further reading

You can also check out [tinker-ui's readme][readme] for more information on how
that part of the application works.

[pow]: http://pow.cx/
[readme]: https://github.com/tinker/tinker-ui

