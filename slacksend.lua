AddCSLuaFile()

local slackURL = "your server incoming-webhook url here"
local configFile = "slacksend/url.txt" -- Only used when loadURL is true
local loadURL = false -- Load the url from the url.txt file?
local slackChannel = "#general"
local slackUserName = "ZS Reporter"

-- Read the plugin configuration file
function readCFG()
    if file.Exists(configFile, "DATA") then
        slackURL = file.Read(configFile)
        print("[SlackSet] using URL: " .. slackURL)
    else
        print("[SlackSend] Could not find URL config file '" .. configFile .. "', you will need to set the URL manually with slackcfg")
    end
end
-- ######

-- The function to actually send the slack data
function sendReport(author, offender, reason)
    post = "(Player Abuse Report)"

    post = post .. "\nBy: " .. author
    post = post .. "\nOffender: " .. offender
    post = post .. "\nReason: " .. reason

    request = '{"text": "' .. post .. '\n", "channel": "' .. slackChannel .. '", "link_names": 1, "username": "' .. slackUserName .. '", "icon_emoji": ":bangbang:"}'

    -- Send HTTP POST request
    http.Post(slackURL,{payload=request}, function(result)
        if result then -- (Sent sucessfully)
            print("Report submitted")
        end
    end, function(failed) -- (Something went wrong)
        print("Error sending to slack")
    end )
    -- #####
end
-- ######

-- The function that handles the command when issued in chat
function report(ply, text, public)
    comm = string.sub(text, 1, 7)
    if (comm == "!report") or (comm == "/report") then

        length = string.len(text)
        words = {}

        for word in text:gmatch("%w+") do table.insert(words, word) end -- Split string into words
        wordlen = table.Count(words)

        if wordlen > 2 then
            offender = words[2]
            reason = ""

            -- Merge words after command into one string
            for i = 3, wordlen do
                reason = reason .. " " .. words[i]
            end
            -- ######

            sendReport(ply:Nick(), offender, reason)
            ply:PrintMessage(HUD_PRINTTALK, "Report sent")            
        
        else
            ply:PrintMessage(HUD_PRINTTALK, "Incorrect syntax. Correct syntax: !report <playername> <your description of the report>")
        end
    end

    return false -- Make the command hidden
end
-- ######


-- Configure the URL
if loadURL then
    readCFG()
end
-- ######

-- Add chat command hook
hook.Add("PlayerSay", "report", report)
-- ######

print('[SlackSend] Done loading')
