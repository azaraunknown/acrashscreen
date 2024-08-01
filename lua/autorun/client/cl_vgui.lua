local PANEL = {}
surface.CreateFont( "aCrashScreenHeader", {
    font = "Trebuchet24",
    size = 50,
    weight = 800,
    antialias = true,
    shadow = false
} )

surface.CreateFont( "aCrashScreenSubHeader", {
    font = "Trebuchet24",
    size = 30,
    weight = 800,
    antialias = true,
    shadow = false
} )

--[[ CONFIG ]]
aCrashScreen = aCrashScreen or {}
aCrashScreen.Header = "Server is currently down. Please wait..."
aCrashScreen.SubHeader = "We are working on it!"
aCrashScreen.ImgurID = "Wjdrmch"
--[[ END CONFIG ]]
function PANEL:Init()
    self:SetSize( ScrW(), ScrH() )
    self:Center()
    self:SetAlpha( 0 )
    self:AlphaTo( 255, 1, 0 )
    self.imgurID = aCrashScreen.ImgurID
    self.logo = nil
    if self.imgurID then self:FetchImage( self.imgurID ) end
end

function PANEL:FetchImage( imgurID )
    local url = "https://i.imgur.com/" .. imgurID .. ".png"
    http.Fetch( url, function( body, len, headers, code )
        if code == 200 then
            file.Write( "imgur_image.png", body )
            self.logo = Material( "data/imgur_image.png" )
        else
            print( "Failed to fetch Imgur image: " .. code )
        end
    end, function( error ) print( "Failed to fetch Imgur image: " .. error ) end )
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
    if self.logo then
        local logoWidth, logoHeight = self.logo:Width(), self.logo:Height()
        -- Calculate the scaled dimensions
        local maxWidth, maxHeight = 336, 280
        local aspectRatio = logoWidth / logoHeight
        if logoWidth > maxWidth or logoHeight > maxHeight then
            if logoWidth / maxWidth > logoHeight / maxHeight then
                logoWidth = maxWidth
                logoHeight = maxWidth / aspectRatio
            else
                logoHeight = maxHeight
                logoWidth = maxHeight * aspectRatio
            end
        end

        local x, y = ( w - logoWidth ) / 2, h * 0.2 - logoHeight / 2
        surface.SetMaterial( self.logo )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( x, y, logoWidth, logoHeight )
    end

    draw.SimpleText( aCrashScreen.Header, "aCrashScreenHeader", w / 2, h * 0.2 + 150, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.SimpleText( aCrashScreen.SubHeader, "aCrashScreenSubHeader", w / 2, h * 0.2 + 190, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

vgui.Register( "aCrashScreen", PANEL, "DPanel" )