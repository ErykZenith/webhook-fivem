# webhook-fivem
Discord Webhook API Wrapper For Fivem

# Code example
```lua
local dc_log = webHook:create("https://discord.com/api/webhooks/*")
:content("* discord webhook module")
:avater()
    :name("kazuma")
    :url("https://i.pinimg.com/736x/ff/1b/24/ff1b245dcefdcb7c0c9c0f26f5d48777.jpg")
:embed("What.av")
    :color("#f54242")
    :author()
        :name("click me")
        :url("https://discord.gg/VfefXFnYf8")
        :icon("https://cdn.discordapp.com/avatars/467648136299413509/6189598c19e76ccb4acedbba9c32d457?size=1024")
:embed("Code")
    :description("tutorial lua and js")
    :color("#58b9ff")
    :author()
        :name("kazuma")
        :icon("https://i.pinimg.com/736x/ff/1b/24/ff1b245dcefdcb7c0c9c0f26f5d48777.jpg")
    :image()
        :big("https://i.pinimg.com/originals/fe/93/6b/fe936b6fdad733399bcd35bf2b02e465.gif")
        :small("https://i.imgur.com/gw6GRaU.gif")
    :field()
        :name("JS")
        :value("```javascript\nconsole.log('ok')```")
    :field()
        :inline()
        :name("LUA")
        :value("```lua\nprint(\"ok\")```")
    :footer()
        :text("what.av")
        :timestamp()

dc_log:send()
```
# Result
<p align="center">
  <img src="https://raw.githubusercontent.com/ErykZenith/webhook-fivem/refs/heads/main/img.png" width="1000"> 
</p>
