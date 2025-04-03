local webHook = {}
webHook.__index = webHook

function webHook:create(url)
    local self = {
        _url = url,
        _data = {
            attachments = {}
        }
    }
    setmetatable(self, webHook)
    return self
end

function webHook:content(text)
    if #text > 2000 then
        return text:sub(1, 2000)
    end
    self._data.content = text
    return self
end

function webHook:avater()
    local fn = {}

    function fn:name(a)
        self._data.username = a
        return fn
    end

    function fn:url(a)
        self._data.avatar_url = a
        return fn
    end

    return setmetatable(fn, {__index=self})
end

function webHook:embed(title)
    self._data.embeds = self._data.embeds or {}

    local index = #self._data.embeds + 1

    local embed = {
        title = title
    }

    self._data.embeds[index] = embed

    local fn = {}

    function fn:author()
        embed.author = {}

        local _fn = {}

        function _fn:name(a)
            embed.author.name = a
            return _fn
        end

        function _fn:url(a)
            embed.author.url = a
            return _fn
        end
        
        function _fn:icon(a)
            embed.author.icon_url = a
            return _fn
        end

        return setmetatable(_fn, { 
            __index = function(_, key)
                return fn[key]
            end 
        })
    end

    function fn:footer()
        embed.footer = {}

        local _fn = {}

        function _fn:text(a)
            embed.footer.text = a
            return _fn
        end

        function _fn:icon(a)
            embed.footer.icon_url = a
            return _fn
        end

        function _fn:timestamp()
            local time = os.time()
            local utc = os.date("!*t", time)
            local year = utc.year
            local month = string.format("%02d", utc.month)
            local day = string.format("%02d", utc.day)
            local hour = string.format("%02d", utc.hour)
            local min = string.format("%02d", utc.min)
            local sec = string.format("%02d", utc.sec)
            local milliseconds = "000000"
            embed.timestamp = string.format("%d-%s-%sT%s:%s:%s.%s+00:00", 
            year, month, day, hour, min, sec, milliseconds)
            return _fn
        end

        return setmetatable(_fn, { 
            __index = function(_, key)
                return fn[key]
            end 
        })
    end

    function fn:image(a)
        local _fn = {}

        function _fn:big(a)
            embed.image = {}
            embed.image.url = a
            return _fn
        end

        function _fn:small(a)
            embed.thumbnail = {}
            embed.thumbnail.url = a
            return _fn
        end

        return setmetatable(_fn, { 
            __index = function(_, key)
                return fn[key]
            end 
        })
    end

    function fn:field(a)
        embed.fields = embed.fields or {}
        local index = #embed.fields + 1

        local field = {}

        embed.fields[index] = field

        local _fn = {}

        function _fn:name(a)
            field.name = a
            return _fn
        end

        function _fn:value(a)
            field.value = a
            return _fn
        end

        function _fn:inline()
            field.inline = true
            return _fn
        end

        return setmetatable(_fn, { 
            __index = function(_, key)
                return fn[key]
            end 
        })
    end

    function fn:description(a)
        embed.description = a
        return fn
    end

    function fn:color(a)
        a = a:gsub("#","")
        local r, g, b = tonumber("0x"..a:sub(1,2)), tonumber("0x"..a:sub(3,4)), tonumber("0x"..a:sub(5,6))
        embed.color = r * 65536 + g * 256 + b
        return fn
    end

    return setmetatable(fn, { __index = self })
end

function webHook:send()
    PerformHttpRequest(self._url, function(_status, _, _, _error) if _status ~= 204 then print("^1".._status..": ".._error or nil,"^0") end end, "POST", json.encode(self._data), {["Content-Type"] = "application/json"})
end