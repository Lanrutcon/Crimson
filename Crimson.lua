local Addon = CreateFrame("FRAME", "Crimson");


local lastWhisperer;
local myLastMessage;

function bindPressed()
    ChatFrame1EditBox:Show();
    ChatFrame1EditBox:SetFocus();
    if(lastWhisperer) then
        ChatFrame1EditBox:SetText("/crs "..lastWhisperer.."@");
    else
        ChatFrame1EditBox:SetText("/crs ");
    end
end


local function sendMessage(message, toPlayer)
    myLastMessage = message;
    lastWhisperer = toPlayer;
    SendAddonMessage("CRS", message, "WHISPER", toPlayer);
end


local function handleMessage(message, fromPlayer)
    SendAddonMessage("CRS", "CRS:ACK", "WHISPER", fromPlayer);
    print("|cff777777["..date("%H:%M:%S").."] |cffaa0000[Crimson] |cffff70ff[To: |cffffffff"..fromPlayer.."|cffff70ff]: " .. message .. "|r");
end


SLASH_Crimson1, SLASH_Crimson2 = "/crimson", "/crs";

function SlashCmd(cmd)
    if (cmd:match"@") then
        local toPlayer = cmd:sub(0,cmd:find("@")-1);
        local message = cmd:sub(cmd:find("@")+1,-1);
        sendMessage(message,toPlayer);
    end
end

SlashCmdList["Crimson"] = SlashCmd;


Addon:SetScript("OnEvent", function(self, event, ...)
    if(event == "CHAT_MSG_ADDON") then
        local prefix, message, channel, sender = ...;
        if(prefix == "CRS" and channel == "WHISPER" and message:match("CRS:ACK")) then
            print("|cff777777["..date("%H:%M:%S").."] |cffaa0000[Crimson] |cffff70ff[To: |cffffffff"..sender.."|cffff70ff]: " .. myLastMessage .. "|r");
        elseif(prefix == "CRS" and channel == "WHISPER") then
            handleMessage(message, sender);
        end
    end
end);

Addon:RegisterEvent("CHAT_MSG_ADDON");
Addon:RegisterAddonMessagePrefix("CRS");


-- Binding Variables
BINDING_HEADER_HEADER = "Crimson";
BINDING_NAME_ENTRY = "Get Last Whisperer";
