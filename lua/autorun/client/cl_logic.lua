local lSD1 = 0
local lSD2 = 0
local nCT = 0
local sDOWN = false
local cSCREEN = nil
local function CheckServerStatusWithSteamAPI()
    local serverIP = game.GetIPAddress()
    http.Fetch( "http://api.steampowered.com/ISteamApps/GetServersAtAddress/v0001?addr=" .. serverIP, function( body, len, headers, code )
        local data = util.JSONToTable( body )
        if data and data.response and data.response.servers and #data.response.servers > 0 then
            sDOWN = false
        else
            sDOWN = true
        end
    end, function( error )
        print( "Failed to fetch server status from Steam API: " .. error )
        sDOWN = true
    end )
end

hook.Add( "Think", "CSS_Think", function()
    if nCT < CurTime() then
        nCT = CurTime() + 0.66
        local a, b = engine.ServerFrameTime()
        if a == lSD1 and b == lSD2 then
            sDOWN = true
            CheckServerStatusWithSteamAPI()
        else
            sDOWN = false
            if IsValid( cSCREEN ) then
                cSCREEN:AlphaTo( 0, 1.5, 0, function()
                    if IsValid( cSCREEN ) then
                        cSCREEN:Remove()
                        cSCREEN = nil
                    end
                end )
            end
        end

        lSD1 = a
        lSD2 = b
    end
end )

hook.Add( "HUDPaint", "CSS_HudPaint", function()
    if sDOWN and not IsValid( cSCREEN ) then
        cSCREEN = vgui.Create( "aCrashScreen" )
        cSCREEN.fadin = false
    end
end )