Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function New-Color {
    param(
        [string]$Hex
    )

    return [System.Drawing.ColorTranslator]::FromHtml($Hex)
}

function U {
    param(
        [string]$Base64
    )

    return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Base64))
}

function Get-InitialTheme {
    try {
        $personalize = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -ErrorAction Stop
        if ($personalize.AppsUseLightTheme -eq 0) {
            return "dark"
        }
    } catch {
    }

    return "light"
}

$inviteUrl = "https://discord.gg/PFkjeKBuxH"
$discordDmUrl = "https://discord.com/channels/@me"
$logoPath = Join-Path -Path $PSScriptRoot -ChildPath "bggmlogo.png"
$script:logoImage = $null
$script:currentLanguage = if ([System.Globalization.CultureInfo]::CurrentUICulture.TwoLetterISOLanguageName -eq "bg") { "bg" } else { "en" }
$script:currentTheme = Get-InitialTheme
$script:lastTemplateId = "friendly"

$uiText = @{
    en = @{
        FormTitle = "BG-GAMER Invite Helper"
        Header = "Invite helper"
        Subtitle = "Choose a template, adjust the text and send it manually in Discord."
        LanguageLabel = "Language"
        ThemeLabel = "Theme"
        ThemeLight = "Light"
        ThemeDark = "Dark"
        TemplateLabel = "Template"
        InviteLabel = "Invite link"
        MessageLabel = "Message"
        RandomButton = "Random"
        CopyButton = "Copy message"
        OpenButton = "Open Discord"
        CopyAndOpenButton = "Copy + Open"
        DefaultStatus = "Manual send only. Edit, copy and paste in Discord."
        CopiedStatus = "Message copied to clipboard."
        OpenedStatus = "Discord opened in your default browser."
        CopyAndOpenStatus = "Message copied and Discord opened."
        CopyOpenFallbackStatus = "Message copied. Open Discord manually if needed."
        CopyFailedTitle = "Copy failed"
        CopyFailedMessage = "Clipboard copy failed. You can still select the text and copy it manually."
        OpenFailedTitle = "Open failed"
        OpenFailedMessage = "Discord could not be opened automatically."
        LogoMissing = "BG-GAMER logo not found."
    }
    bg = @{
        FormTitle = U "QkctR0FNRVIg0J/QvtC80L7RidC90LjQuiDQt9CwINC/0L7QutCw0L3QuA=="
        Header = U "0J/QvtC80L7RidC90LjQuiDQt9CwINC/0L7QutCw0L3QuA=="
        Subtitle = U "0JjQt9Cx0LXRgNC4INGI0LDQsdC70L7QvSwg0YDQtdC00LDQutGC0LjRgNCw0Lkg0YLQtdC60YHRgtCwINC4INCz0L4g0LjQt9C/0YDQsNGC0Lgg0YDRitGH0L3QviDQsiBEaXNjb3JkLg=="
        LanguageLabel = U "0JXQt9C40Lo="
        ThemeLabel = U "0KLQtdC80LA="
        ThemeLight = U "0KHQstC10YLQu9Cw"
        ThemeDark = U "0KLRitC80L3QsA=="
        TemplateLabel = U "0KjQsNCx0LvQvtC9"
        InviteLabel = U "0JvQuNC90Log0LfQsCDQv9C+0LrQsNC90LA="
        MessageLabel = U "0KHRitC+0LHRidC10L3QuNC1"
        RandomButton = U "0KHQu9GD0YfQsNC10L0="
        CopyButton = U "0JrQvtC/0LjRgNCw0Lkg0YHRitC+0LHRidC10L3QuNC10YLQvg=="
        OpenButton = U "0J7RgtCy0L7RgNC4IERpc2NvcmQ="
        CopyAndOpenButton = U "0JrQvtC/0LjRgNCw0LkgKyDQvtGC0LLQvtGA0Lg="
        DefaultStatus = U "0KHQsNC80L4g0YDRitGH0L3QviDQuNC30L/RgNCw0YnQsNC90LUuINCg0LXQtNCw0LrRgtC40YDQsNC5LCDQutC+0L/QuNGA0LDQuSDQuCDQv9C10LnRgdGC0L3QuCDQsiBEaXNjb3JkLg=="
        CopiedStatus = U "0KHRitC+0LHRidC10L3QuNC10YLQviDQtSDQutC+0L/QuNGA0LDQvdC+INCyINC60LvQuNC/0LHQvtGA0LTQsC4="
        OpenedStatus = U "RGlzY29yZCDQsdC10YjQtSDQvtGC0LLQvtGA0LXQvSDQsiDQsdGA0LDRg9C30YrRgNCwINC/0L4g0L/QvtC00YDQsNC30LHQuNGA0LDQvdC1Lg=="
        CopyAndOpenStatus = U "0KHRitC+0LHRidC10L3QuNC10YLQviDQtSDQutC+0L/QuNGA0LDQvdC+INC4IERpc2NvcmQg0LUg0L7RgtCy0L7RgNC10L0u"
        CopyOpenFallbackStatus = U "0KHRitC+0LHRidC10L3QuNC10YLQviDQtSDQutC+0L/QuNGA0LDQvdC+LiDQn9GA0Lgg0L3Rg9C20LTQsCDQvtGC0LLQvtGA0LggRGlzY29yZCDRgNGK0YfQvdC+Lg=="
        CopyFailedTitle = U "0JPRgNC10YjQutCwINC/0YDQuCDQutC+0L/QuNGA0LDQvdC1"
        CopyFailedMessage = U "0JrQvtC/0LjRgNCw0L3QtdGC0L4g0LIg0LrQu9C40L/QsdC+0YDQtNCwINC90LUg0YPRgdC/0Y8uINCS0YHQtSDQv9Cw0Log0LzQvtC20LXRiCDQtNCwINC80LDRgNC60LjRgNCw0Ygg0YLQtdC60YHRgtCwINC4INC00LAg0LPQviDQutC+0L/QuNGA0LDRiCDRgNGK0YfQvdC+Lg=="
        OpenFailedTitle = U "0JPRgNC10YjQutCwINC/0YDQuCDQvtGC0LLQsNGA0Y/QvdC1"
        OpenFailedMessage = U "RGlzY29yZCDQvdC1INC80L7QttCwINC00LAg0LHRitC00LUg0L7RgtCy0L7RgNC10L0g0LDQstGC0L7QvNCw0YLQuNGH0L3Qvi4="
        LogoMissing = U "0JvQvtCz0L7RgtC+INC90LAgQkctR0FNRVIg0L3QtSDQtSDQvdCw0LzQtdGA0LXQvdC+Lg=="
    }
}

$themes = @{
    light = @{
        FormBack = New-Color "#F3F4F6"
        CardBack = New-Color "#FFFFFF"
        LogoBack = New-Color "#0F1115"
        PrimaryText = New-Color "#16181D"
        SecondaryText = New-Color "#667085"
        InputBack = New-Color "#F8FAFC"
        InputBorder = New-Color "#D8DEE8"
        SurfaceAlt = New-Color "#F1F5F9"
        Accent = New-Color "#F0C33C"
        AccentHover = New-Color "#E1B42C"
        AccentText = New-Color "#151515"
        ButtonBack = New-Color "#FFFFFF"
        ButtonHover = New-Color "#EEF2F6"
        ButtonText = New-Color "#16181D"
        Link = New-Color "#A67C00"
    }
    dark = @{
        FormBack = New-Color "#0D1015"
        CardBack = New-Color "#151922"
        LogoBack = New-Color "#090B0F"
        PrimaryText = New-Color "#F5F7FA"
        SecondaryText = New-Color "#98A2B3"
        InputBack = New-Color "#0F131B"
        InputBorder = New-Color "#242B38"
        SurfaceAlt = New-Color "#1A2030"
        Accent = New-Color "#F0C33C"
        AccentHover = New-Color "#FFD257"
        AccentText = New-Color "#151515"
        ButtonBack = New-Color "#1C2230"
        ButtonHover = New-Color "#252D3C"
        ButtonText = New-Color "#F5F7FA"
        Link = New-Color "#FFD257"
    }
}

$templates = @(
    @{
        Id = "friendly"
        Name = @{
            en = "Friendly invite"
            bg = U "0J/RgNC40Y/RgtC10LvRgdC60LAg0L/QvtC60LDQvdCw"
        }
        Text = @{
            en = "Hey! Join my BG-GAMER Discord server: $inviteUrl"
            bg = U "0KXQtdC5ISDQldC70LAg0LIg0LzQvtGPIEJHLUdBTUVSIERpc2NvcmQg0YHRitGA0LLRitGAOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "community"
        Name = @{
            en = "Community invite"
            bg = U "0J/QvtC60LDQvdCwINC30LAg0L7QsdGJ0L3QvtGB0YLRgtCw"
        }
        Text = @{
            en = "We are building a cool community in BG-GAMER. Join us here: $inviteUrl"
            bg = U "0J/RgNCw0LLQuNC8INGP0LrQsCDQvtCx0YnQvdC+0YHRgiDQsiBCRy1HQU1FUi4g0J/RgNC40YHRitC10LTQuNC90Lgg0YHQtSDQvtGC0YLRg9C6OiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "hangout"
        Name = @{
            en = "Casual hangout"
            bg = U "0J3QtdGE0L7RgNC80LDQu9C90LAg0L/QvtC60LDQvdCw"
        }
        Text = @{
            en = "We hang out, chat and play on BG-GAMER. Come in when you want: $inviteUrl"
            bg = U "0KHRitCx0LjRgNCw0LzQtSDRgdC1LCDQu9Cw0YTQuNC8INC4INC40LPRgNCw0LXQvCDQsiBCRy1HQU1FUi4g0JXQu9CwLCDQutC+0LPQsNGC0L4g0LjRgdC60LDRiDogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "events"
        Name = @{
            en = "Events and games"
            bg = U "0JjQs9GA0Lgg0Lgg0YHRitCx0LjRgtC40Y8="
        }
        Text = @{
            en = "If you want games, events and a friendly Discord, check out BG-GAMER: $inviteUrl"
            bg = U "0JDQutC+INGC0Lgg0YHQtSDRhtGK0LrQsNGCINC40LPRgNC4LCDRgdGK0LHQuNGC0LjRjyDQuCDQv9GA0LjRj9GC0LXQvSBEaXNjb3JkLCDRgNCw0LfQs9C70LXQtNCw0LkgQkctR0FNRVI6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "quick"
        Name = @{
            en = "Quick invite"
            bg = U "0JrRgNCw0YLQutCwINC/0L7QutCw0L3QsA=="
        }
        Text = @{
            en = "Come join BG-GAMER: $inviteUrl"
            bg = U "0JXQu9CwINCyIEJHLUdBTUVSOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "gaming-nights"
        Name = @{
            en = "Gaming nights"
            bg = U "0JPQtdC50LzQuNC90LMg0LLQtdGH0LXRgNC4"
        }
        Text = @{
            en = "Join BG-GAMER for gaming nights and chill chat: $inviteUrl"
            bg = U "0JXQu9CwINCyIEJHLUdBTUVSINC30LAg0LPQtdC50LzQuNC90LMg0LLQtdGH0LXRgNC4INC4INC/0YDQuNGP0YLQtdC9INGH0LDRgjogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "squad-up"
        Name = @{
            en = "Squad up"
            bg = U "0KHRitCx0LXRgNC4INC+0YLQsdC+0YDQsA=="
        }
        Text = @{
            en = "If you want teammates and active chat, join BG-GAMER: $inviteUrl"
            bg = U "0JDQutC+INGC0YrRgNGB0LjRiCDRgdGK0L7RgtCx0L7RgNC90LjRhtC4INC4INCw0LrRgtC40LLQtdC9INGH0LDRgiwg0LXQu9CwINCyIEJHLUdBTUVSOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "new-friends"
        Name = @{
            en = "New friends"
            bg = U "0J3QvtCy0Lgg0L/RgNC40Y/RgtC10LvQuA=="
        }
        Text = @{
            en = "Meet new people in BG-GAMER and jump into the server here: $inviteUrl"
            bg = U "0JfQsNC/0L7Qt9C90LDQuSDRgdC1INGBINC90L7QstC4INGF0L7RgNCwINCyIEJHLUdBTUVSINC4INCy0LvQtdC3INGC0YPQujogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "voice-chat"
        Name = @{
            en = "Voice chat"
            bg = U "0JPQu9Cw0YHQvtCyINGH0LDRgg=="
        }
        Text = @{
            en = "We are often in voice chat on BG-GAMER. Join us: $inviteUrl"
            bg = U "0KfQtdGB0YLQviDRgdC80LUg0L3QsCDQs9C70LDRgdC+0LIg0YfQsNGCINCyIEJHLUdBTUVSLiDQldC70LAg0L/RgNC4INC90LDRgTogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "minecraft"
        Name = @{
            en = "Minecraft crew"
            bg = U "TWluZWNyYWZ0INC60L7QvNC/0LDQvdC40Y8="
        }
        Text = @{
            en = "If you are into Minecraft and community servers, join BG-GAMER: $inviteUrl"
            bg = U "0JDQutC+INGF0LDRgNC10YHQstCw0YggTWluZWNyYWZ0INC4IGNvbW11bml0eSDRgdGK0YDQstGK0YDQuCwg0LXQu9CwINCyIEJHLUdBTUVSOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "events-alert"
        Name = @{
            en = "Event alerts"
            bg = U "0JjQt9Cy0LXRgdGC0LjRjyDQt9CwINGB0YrQsdC40YLQuNGP"
        }
        Text = @{
            en = "Get updates for games, events and community activities in BG-GAMER: $inviteUrl"
            bg = U "0J/QvtC70YPRh9C4INC90L7QstC40L3QuCDQt9CwINC40LPRgNC4LCDRgdGK0LHQuNGC0LjRjyDQuCDQsNC60YLQuNCy0L3QvtGB0YLQuCDQsiBCRy1HQU1FUjogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "after-school"
        Name = @{
            en = "After school chill"
            bg = U "0KHQu9C10LQg0YPRh9C40LvQuNGJ0LU="
        }
        Text = @{
            en = "Come chill after school or work in BG-GAMER: $inviteUrl"
            bg = U "0JXQu9CwINC00LAg0YDQsNC30L/Rg9GB0L3QtdGIINGB0LvQtdC0INGD0YfQuNC70LjRidC1INC40LvQuCDRgNCw0LHQvtGC0LAg0LIgQkctR0FNRVI6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "weekend"
        Name = @{
            en = "Weekend invite"
            bg = U "0KPQuNC60LXQvdC0INC/0L7QutCw0L3QsA=="
        }
        Text = @{
            en = "Need a place to hang out this weekend? Join BG-GAMER: $inviteUrl"
            bg = U "0KLRitGA0YHQuNGIINC80Y/RgdGC0L4g0LfQsCDRg9C40LrQtdC90LTQsD8g0JXQu9CwINCyIEJHLUdBTUVSOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "streams"
        Name = @{
            en = "Streams and clips"
            bg = U "0KHRgtGA0LjQudC80L7QstC1INC4INC60LvQuNC/0L7QstC1"
        }
        Text = @{
            en = "We share streams, clips and funny moments in BG-GAMER: $inviteUrl"
            bg = U "0KHQv9C+0LTQtdC70Y/QvNC1INGB0YLRgNC40LnQvNC+0LLQtSwg0LrQu9C40L/QvtCy0LUg0Lgg0LfQsNCx0LDQstC90Lgg0LzQvtC80LXQvdGC0Lgg0LIgQkctR0FNRVI6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "active-chat"
        Name = @{
            en = "Active chat"
            bg = U "0JDQutGC0LjQstC10L0g0YfQsNGC"
        }
        Text = @{
            en = "BG-GAMER has an active chat and friendly people. Join here: $inviteUrl"
            bg = U "0JIgQkctR0FNRVIg0LjQvNCwINCw0LrRgtC40LLQtdC9INGH0LDRgiDQuCDQv9GA0LjRj9GC0L3QuCDRhdC+0YDQsC4g0JLQu9C10Lcg0L7RgtGC0YPQujogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "no-pressure"
        Name = @{
            en = "No pressure"
            bg = U "0JHQtdC3INC90LDQv9GA0LXQttC10L3QuNC1"
        }
        Text = @{
            en = "No pressure, just drop by BG-GAMER whenever you want: $inviteUrl"
            bg = U "0JHQtdC3INC90LDQv9GA0LXQttC10L3QuNC1LCDQv9GA0L7RgdGC0L4g0LzQuNC90Lgg0L/RgNC10LcgQkctR0FNRVIg0LrQvtCz0LDRgtC+INC40YHQutCw0Yg6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "cozy"
        Name = @{
            en = "Cozy community"
            bg = U "0KPRjtGC0L3QsCDQvtCx0YnQvdC+0YHRgg=="
        }
        Text = @{
            en = "If you like smaller cozy communities, BG-GAMER might be for you: $inviteUrl"
            bg = U "0JDQutC+INGF0LDRgNC10YHQstCw0Ygg0L/Qvi3Rg9GO0YLQvdC4INC+0LHRidC90L7RgdGC0LgsIEJHLUdBTUVSINC80L7QttC1INC00LAg0YLQuCDQtNC+0L/QsNC00L3QtTogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "memes"
        Name = @{
            en = "Memes and fun"
            bg = U "0JzQtdC80LXRgtCwINC4INC30LDQsdCw0LLQu9C10L3QuNC1"
        }
        Text = @{
            en = "For memes, laughs and games, join BG-GAMER here: $inviteUrl"
            bg = U "0JfQsCDQvNC10LzQtdGC0LAsINGB0LzRj9GFINC4INC40LPRgNC4LCDQtdC70LAg0LIgQkctR0FNRVIg0L7RgtGC0YPQujogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "late-night"
        Name = @{
            en = "Late night chat"
            bg = U "0JrRitGB0LXQvSDRh9Cw0YI="
        }
        Text = @{
            en = "If you are awake late, there is always someone around in BG-GAMER: $inviteUrl"
            bg = U "0JDQutC+INGB0YLQvtC40Ygg0LTQviDQutGK0YHQvdC+LCDQsiBCRy1HQU1FUiDQv9C+0YfRgtC4INCy0LjQvdCw0LPQuCDQuNC80LAg0L3Rj9C60L7QuTogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "support"
        Name = @{
            en = "Helpful community"
            bg = U "0J7RgtC30LjQstGH0LjQstCwINC+0LHRidC90L7RgdGC"
        }
        Text = @{
            en = "Join BG-GAMER if you want a helpful community and fun conversations: $inviteUrl"
            bg = U "0JXQu9CwINCyIEJHLUdBTUVSLCDQsNC60L4g0LjRgdC60LDRiCDQvtGC0LfQuNCy0YfQuNCy0LAg0L7QsdGJ0L3QvtGB0YIg0Lgg0LfQsNCx0LDQstC90Lgg0YDQsNC30LPQvtCy0L7RgNC4OiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "duo"
        Name = @{
            en = "Looking for duo"
            bg = U "0KLRitGA0YHRjyDQtNGD0L4="
        }
        Text = @{
            en = "I am gathering people for games in BG-GAMER. Join in: $inviteUrl"
            bg = U "0KHRitCx0LjRgNCw0Lwg0YXQvtGA0LAg0LfQsCDQuNCz0YDQuCDQsiBCRy1HQU1FUi4g0JLQutC70Y7Rh9C4INGB0LU6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "friends-hub"
        Name = @{
            en = "Friends hub"
            bg = U "0JzRj9GB0YLQviDQt9CwINC/0YDQuNGP0YLQtdC70Lg="
        }
        Text = @{
            en = "BG-GAMER is a nice place to keep up with friends and play together: $inviteUrl"
            bg = U "QkctR0FNRVIg0LUg0L/RgNC40Y/RgtC90L4g0LzRj9GB0YLQviDQtNCwINC/0L7QtNC00YrRgNC20LDRiCDQstGA0YrQt9C60LAg0YEg0L/RgNC40Y/RgtC10LvQuCDQuCDQtNCwINC40LPRgNCw0LXRgtC1INC30LDQtdC00L3QvjogaHR0cHM6Ly9kaXNjb3JkLmdnL1BGa2plS0J1eEg="
        }
    },
    @{
        Id = "start-here"
        Name = @{
            en = "Start here"
            bg = U "0JfQsNC/0L7Rh9C90Lgg0L7RgtGC0YPQug=="
        }
        Text = @{
            en = "If you want to check it out, start with this BG-GAMER invite: $inviteUrl"
            bg = U "0JDQutC+INC40YHQutCw0Ygg0LTQsCDQs9C+INGA0LDQt9Cz0LvQtdC00LDRiCwg0LfQsNC/0L7Rh9C90Lgg0YEg0YLQsNC30LggQkctR0FNRVIg0L/QvtC60LDQvdCwOiBodHRwczovL2Rpc2NvcmQuZ2cvUEZramVLQnV4SA=="
        }
    },
    @{
        Id = "quick-join"
        Name = @{
            en = "Jump in"
            bg = U "0JLQu9C10Lcg0YHQtdCz0LA="
        }
        Text = @{
            en = "Jump into BG-GAMER and see if the vibe fits you: $inviteUrl"
            bg = U "0JLQu9C10Lcg0LIgQkctR0FNRVIg0Lgg0LLQuNC2INC00LDQu9C4INCw0YLQvNC+0YHRhNC10YDQsNGC0LAg0YLQuCDQtNC+0L/QsNC00LA6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    },
    @{
        Id = "game-talk"
        Name = @{
            en = "Game talk"
            bg = U "0JPQtdC50Lwg0YfQsNGC"
        }
        Text = @{
            en = "For game talk, chill moments and community events, join BG-GAMER: $inviteUrl"
            bg = U "0JfQsCDQs9C10LnQvCDRgNCw0LfQs9C+0LLQvtGA0LgsINGA0LDQt9C/0YPRgdC60LDQvdC1INC4INGB0YrQsdC40YLQuNGPINC90LAg0L7QsdGJ0L3QvtGB0YLRgtCwLCDQtdC70LAg0LIgQkctR0FNRVI6IGh0dHBzOi8vZGlzY29yZC5nZy9QRmtqZUtCdXhI"
        }
    }
)

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(920, 640)
$form.MinimumSize = New-Object System.Drawing.Size(920, 640)
$form.MaximizeBox = $false
$form.FormBorderStyle = "FixedDialog"
$form.Font = New-Object System.Drawing.Font("Segoe UI", 9)

$cardPanel = New-Object System.Windows.Forms.Panel
$cardPanel.Location = New-Object System.Drawing.Point(24, 24)
$cardPanel.Size = New-Object System.Drawing.Size(856, 574)
$form.Controls.Add($cardPanel)

$accentStrip = New-Object System.Windows.Forms.Panel
$accentStrip.Location = New-Object System.Drawing.Point(0, 0)
$accentStrip.Size = New-Object System.Drawing.Size(856, 4)
$cardPanel.Controls.Add($accentStrip)

$logoPanel = New-Object System.Windows.Forms.Panel
$logoPanel.Location = New-Object System.Drawing.Point(32, 28)
$logoPanel.Size = New-Object System.Drawing.Size(792, 108)
$cardPanel.Controls.Add($logoPanel)

$logoPictureBox = New-Object System.Windows.Forms.PictureBox
$logoPictureBox.Location = New-Object System.Drawing.Point(18, 16)
$logoPictureBox.Size = New-Object System.Drawing.Size(756, 76)
$logoPictureBox.SizeMode = "Zoom"
$logoPanel.Controls.Add($logoPictureBox)

$logoFallbackLabel = New-Object System.Windows.Forms.Label
$logoFallbackLabel.Location = New-Object System.Drawing.Point(18, 16)
$logoFallbackLabel.Size = New-Object System.Drawing.Size(756, 76)
$logoFallbackLabel.TextAlign = "MiddleCenter"
$logoFallbackLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 10.5)
$logoFallbackLabel.Visible = $false
$logoPanel.Controls.Add($logoFallbackLabel)

$headerLabel = New-Object System.Windows.Forms.Label
$headerLabel.Location = New-Object System.Drawing.Point(32, 156)
$headerLabel.Size = New-Object System.Drawing.Size(792, 30)
$headerLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 15)
$cardPanel.Controls.Add($headerLabel)

$subtitleLabel = New-Object System.Windows.Forms.Label
$subtitleLabel.Location = New-Object System.Drawing.Point(32, 190)
$subtitleLabel.Size = New-Object System.Drawing.Size(792, 36)
$subtitleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$cardPanel.Controls.Add($subtitleLabel)

$languageLabel = New-Object System.Windows.Forms.Label
$languageLabel.Location = New-Object System.Drawing.Point(32, 236)
$languageLabel.Size = New-Object System.Drawing.Size(150, 18)
$languageLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$cardPanel.Controls.Add($languageLabel)

$languageComboBox = New-Object System.Windows.Forms.ComboBox
$languageComboBox.Location = New-Object System.Drawing.Point(32, 258)
$languageComboBox.Size = New-Object System.Drawing.Size(150, 28)
$languageComboBox.DropDownStyle = "DropDownList"
$languageComboBox.DisplayMember = "Display"
$languageComboBox.FlatStyle = "Flat"
$cardPanel.Controls.Add($languageComboBox)

$themeLabel = New-Object System.Windows.Forms.Label
$themeLabel.Location = New-Object System.Drawing.Point(200, 236)
$themeLabel.Size = New-Object System.Drawing.Size(150, 18)
$themeLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$cardPanel.Controls.Add($themeLabel)

$themeComboBox = New-Object System.Windows.Forms.ComboBox
$themeComboBox.Location = New-Object System.Drawing.Point(200, 258)
$themeComboBox.Size = New-Object System.Drawing.Size(150, 28)
$themeComboBox.DropDownStyle = "DropDownList"
$themeComboBox.DisplayMember = "Display"
$themeComboBox.FlatStyle = "Flat"
$cardPanel.Controls.Add($themeComboBox)

$templateLabel = New-Object System.Windows.Forms.Label
$templateLabel.Location = New-Object System.Drawing.Point(368, 236)
$templateLabel.Size = New-Object System.Drawing.Size(320, 18)
$templateLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$cardPanel.Controls.Add($templateLabel)

$templateComboBox = New-Object System.Windows.Forms.ComboBox
$templateComboBox.Location = New-Object System.Drawing.Point(368, 258)
$templateComboBox.Size = New-Object System.Drawing.Size(320, 28)
$templateComboBox.DropDownStyle = "DropDownList"
$templateComboBox.DisplayMember = "Display"
$templateComboBox.FlatStyle = "Flat"
$cardPanel.Controls.Add($templateComboBox)

$randomButton = New-Object System.Windows.Forms.Button
$randomButton.Location = New-Object System.Drawing.Point(706, 257)
$randomButton.Size = New-Object System.Drawing.Size(118, 30)
$randomButton.FlatStyle = "Flat"
$randomButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$cardPanel.Controls.Add($randomButton)

$inviteLabel = New-Object System.Windows.Forms.Label
$inviteLabel.Location = New-Object System.Drawing.Point(32, 304)
$inviteLabel.Size = New-Object System.Drawing.Size(792, 18)
$inviteLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$cardPanel.Controls.Add($inviteLabel)

$invitePanel = New-Object System.Windows.Forms.Panel
$invitePanel.Location = New-Object System.Drawing.Point(32, 326)
$invitePanel.Size = New-Object System.Drawing.Size(792, 38)
$cardPanel.Controls.Add($invitePanel)

$inviteLinkLabel = New-Object System.Windows.Forms.LinkLabel
$inviteLinkLabel.Location = New-Object System.Drawing.Point(14, 10)
$inviteLinkLabel.Size = New-Object System.Drawing.Size(764, 18)
$inviteLinkLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$inviteLinkLabel.Text = $inviteUrl
$inviteLinkLabel.LinkBehavior = "HoverUnderline"
$inviteLinkLabel.Cursor = [System.Windows.Forms.Cursors]::Hand
$inviteLinkLabel.Add_Click({
    Start-Process $inviteUrl
})
$invitePanel.Controls.Add($inviteLinkLabel)

$messageLabel = New-Object System.Windows.Forms.Label
$messageLabel.Location = New-Object System.Drawing.Point(32, 380)
$messageLabel.Size = New-Object System.Drawing.Size(792, 18)
$messageLabel.Font = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$cardPanel.Controls.Add($messageLabel)

$messagePanel = New-Object System.Windows.Forms.Panel
$messagePanel.Location = New-Object System.Drawing.Point(32, 402)
$messagePanel.Size = New-Object System.Drawing.Size(792, 104)
$messagePanel.Padding = New-Object System.Windows.Forms.Padding(1)
$cardPanel.Controls.Add($messagePanel)

$messageBox = New-Object System.Windows.Forms.TextBox
$messageBox.Multiline = $true
$messageBox.ScrollBars = "Vertical"
$messageBox.BorderStyle = "None"
$messageBox.Location = New-Object System.Drawing.Point(14, 14)
$messageBox.Size = New-Object System.Drawing.Size(764, 76)
$messageBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$messagePanel.Controls.Add($messageBox)

$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(32, 520)
$statusLabel.Size = New-Object System.Drawing.Size(792, 20)
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$cardPanel.Controls.Add($statusLabel)

$openButton = New-Object System.Windows.Forms.Button
$openButton.Location = New-Object System.Drawing.Point(32, 540)
$openButton.Size = New-Object System.Drawing.Size(148, 34)
$openButton.FlatStyle = "Flat"
$openButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$cardPanel.Controls.Add($openButton)

$copyButton = New-Object System.Windows.Forms.Button
$copyButton.Location = New-Object System.Drawing.Point(514, 540)
$copyButton.Size = New-Object System.Drawing.Size(148, 34)
$copyButton.FlatStyle = "Flat"
$copyButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$cardPanel.Controls.Add($copyButton)

$copyAndOpenButton = New-Object System.Windows.Forms.Button
$copyAndOpenButton.Location = New-Object System.Drawing.Point(676, 540)
$copyAndOpenButton.Size = New-Object System.Drawing.Size(148, 34)
$copyAndOpenButton.FlatStyle = "Flat"
$copyAndOpenButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$cardPanel.Controls.Add($copyAndOpenButton)

function Get-UiValue {
    param(
        [string]$Key
    )

    return $uiText[$script:currentLanguage][$Key]
}

function Get-TemplateById {
    param(
        [string]$TemplateId
    )

    foreach ($template in $templates) {
        if ($template.Id -eq $TemplateId) {
            return $template
        }
    }

    return $null
}

function Set-ButtonTheme {
    param(
        [System.Windows.Forms.Button]$Button,
        [System.Drawing.Color]$BackColor,
        [System.Drawing.Color]$ForeColor,
        [System.Drawing.Color]$BorderColor,
        [System.Drawing.Color]$HoverColor
    )

    $Button.BackColor = $BackColor
    $Button.ForeColor = $ForeColor
    $Button.FlatAppearance.BorderColor = $BorderColor
    $Button.FlatAppearance.BorderSize = 1
    $Button.FlatAppearance.MouseOverBackColor = $HoverColor
    $Button.FlatAppearance.MouseDownBackColor = $HoverColor
}

function Set-ThemeItems {
    param(
        [string]$PreferredThemeId
    )

    $themeComboBox.BeginUpdate()
    $themeComboBox.Items.Clear()

    [void]$themeComboBox.Items.Add([PSCustomObject]@{
        Id = "light"
        Display = Get-UiValue -Key "ThemeLight"
    })
    [void]$themeComboBox.Items.Add([PSCustomObject]@{
        Id = "dark"
        Display = Get-UiValue -Key "ThemeDark"
    })

    $themeComboBox.EndUpdate()

    if (-not $PreferredThemeId) {
        $PreferredThemeId = "light"
    }

    for ($index = 0; $index -lt $themeComboBox.Items.Count; $index++) {
        if ($themeComboBox.Items[$index].Id -eq $PreferredThemeId) {
            $themeComboBox.SelectedIndex = $index
            return
        }
    }

    $themeComboBox.SelectedIndex = 0
}

function Set-TemplateItems {
    param(
        [string]$PreferredTemplateId
    )

    $templateComboBox.BeginUpdate()
    $templateComboBox.Items.Clear()

    foreach ($template in $templates) {
        [void]$templateComboBox.Items.Add([PSCustomObject]@{
            Id = $template.Id
            Display = $template.Name[$script:currentLanguage]
        })
    }

    $templateComboBox.EndUpdate()

    if (-not $PreferredTemplateId) {
        $PreferredTemplateId = $templates[0].Id
    }

    for ($index = 0; $index -lt $templateComboBox.Items.Count; $index++) {
        if ($templateComboBox.Items[$index].Id -eq $PreferredTemplateId) {
            $templateComboBox.SelectedIndex = $index
            return
        }
    }

    $templateComboBox.SelectedIndex = 0
}

function Set-MessageFromSelectedTemplate {
    if ($null -eq $templateComboBox.SelectedItem) {
        return
    }

    $template = Get-TemplateById -TemplateId $templateComboBox.SelectedItem.Id
    if ($null -eq $template) {
        return
    }

    $script:lastTemplateId = $template.Id
    $messageBox.Text = $template.Text[$script:currentLanguage]
}

function Select-RandomTemplate {
    if ($templateComboBox.Items.Count -lt 1) {
        return
    }

    $currentIndex = $templateComboBox.SelectedIndex
    $newIndex = Get-Random -Minimum 0 -Maximum $templateComboBox.Items.Count

    if ($templateComboBox.Items.Count -gt 1) {
        while ($newIndex -eq $currentIndex) {
            $newIndex = Get-Random -Minimum 0 -Maximum $templateComboBox.Items.Count
        }
    }

    $templateComboBox.SelectedIndex = $newIndex
}

function Apply-Theme {
    param(
        [string]$ThemeId
    )

    if (-not $themes.ContainsKey($ThemeId)) {
        return
    }

    $script:currentTheme = $ThemeId
    $palette = $themes[$ThemeId]

    $form.BackColor = $palette.FormBack
    $cardPanel.BackColor = $palette.CardBack
    $accentStrip.BackColor = $palette.Accent
    $logoPanel.BackColor = $palette.LogoBack
    $logoPictureBox.BackColor = $palette.LogoBack
    $logoFallbackLabel.BackColor = $palette.LogoBack
    $logoFallbackLabel.ForeColor = $palette.PrimaryText

    $headerLabel.ForeColor = $palette.PrimaryText
    $subtitleLabel.ForeColor = $palette.SecondaryText

    foreach ($label in @($languageLabel, $themeLabel, $templateLabel, $inviteLabel, $statusLabel)) {
        $label.ForeColor = $palette.SecondaryText
    }

    $messageLabel.ForeColor = $palette.PrimaryText

    foreach ($comboBox in @($languageComboBox, $themeComboBox, $templateComboBox)) {
        $comboBox.BackColor = $palette.InputBack
        $comboBox.ForeColor = $palette.PrimaryText
    }

    $invitePanel.BackColor = $palette.SurfaceAlt
    $inviteLinkLabel.BackColor = $palette.SurfaceAlt
    $inviteLinkLabel.LinkColor = $palette.Link
    $inviteLinkLabel.ActiveLinkColor = $palette.Accent
    $inviteLinkLabel.VisitedLinkColor = $palette.Link
    $inviteLinkLabel.ForeColor = $palette.Link

    $messagePanel.BackColor = $palette.InputBorder
    $messageBox.BackColor = $palette.InputBack
    $messageBox.ForeColor = $palette.PrimaryText

    Set-ButtonTheme -Button $openButton -BackColor $palette.ButtonBack -ForeColor $palette.ButtonText -BorderColor $palette.InputBorder -HoverColor $palette.ButtonHover
    Set-ButtonTheme -Button $copyButton -BackColor $palette.ButtonBack -ForeColor $palette.ButtonText -BorderColor $palette.InputBorder -HoverColor $palette.ButtonHover
    Set-ButtonTheme -Button $randomButton -BackColor $palette.ButtonBack -ForeColor $palette.ButtonText -BorderColor $palette.InputBorder -HoverColor $palette.ButtonHover
    Set-ButtonTheme -Button $copyAndOpenButton -BackColor $palette.Accent -ForeColor $palette.AccentText -BorderColor $palette.Accent -HoverColor $palette.AccentHover
}

function Apply-Language {
    param(
        [string]$LanguageCode
    )

    $script:currentLanguage = $LanguageCode

    $form.Text = Get-UiValue -Key "FormTitle"
    $headerLabel.Text = Get-UiValue -Key "Header"
    $subtitleLabel.Text = Get-UiValue -Key "Subtitle"
    $languageLabel.Text = Get-UiValue -Key "LanguageLabel"
    $themeLabel.Text = Get-UiValue -Key "ThemeLabel"
    $templateLabel.Text = Get-UiValue -Key "TemplateLabel"
    $inviteLabel.Text = Get-UiValue -Key "InviteLabel"
    $messageLabel.Text = Get-UiValue -Key "MessageLabel"
    $randomButton.Text = Get-UiValue -Key "RandomButton"
    $copyButton.Text = Get-UiValue -Key "CopyButton"
    $openButton.Text = Get-UiValue -Key "OpenButton"
    $copyAndOpenButton.Text = Get-UiValue -Key "CopyAndOpenButton"

    if ($logoFallbackLabel.Visible) {
        $logoFallbackLabel.Text = Get-UiValue -Key "LogoMissing"
    }

    $preferredThemeId = $script:currentTheme
    if ($themeComboBox.SelectedItem) {
        $preferredThemeId = $themeComboBox.SelectedItem.Id
    }

    $preferredTemplateId = $script:lastTemplateId
    if ($templateComboBox.SelectedItem) {
        $preferredTemplateId = $templateComboBox.SelectedItem.Id
    }

    Set-ThemeItems -PreferredThemeId $preferredThemeId
    Set-TemplateItems -PreferredTemplateId $preferredTemplateId
    $statusLabel.Text = Get-UiValue -Key "DefaultStatus"
}

try {
    if (Test-Path -LiteralPath $logoPath) {
        $script:logoImage = [System.Drawing.Image]::FromFile($logoPath)
        $logoPictureBox.Image = $script:logoImage
    } else {
        $logoPictureBox.Visible = $false
        $logoFallbackLabel.Visible = $true
    }
} catch {
    $logoPictureBox.Visible = $false
    $logoFallbackLabel.Visible = $true
}

[void]$languageComboBox.Items.Add([PSCustomObject]@{
    Code = "en"
    Display = "English"
})
[void]$languageComboBox.Items.Add([PSCustomObject]@{
    Code = "bg"
    Display = U "0JHRitC70LPQsNGA0YHQutC4"
})

$languageComboBox.Add_SelectedIndexChanged({
    if ($null -ne $languageComboBox.SelectedItem) {
        Apply-Language -LanguageCode $languageComboBox.SelectedItem.Code
    }
})

$themeComboBox.Add_SelectedIndexChanged({
    if ($null -ne $themeComboBox.SelectedItem) {
        Apply-Theme -ThemeId $themeComboBox.SelectedItem.Id
    }
})

$templateComboBox.Add_SelectedIndexChanged({
    if ($null -ne $templateComboBox.SelectedItem) {
        Set-MessageFromSelectedTemplate
        $statusLabel.Text = Get-UiValue -Key "DefaultStatus"
    }
})

$randomButton.Add_Click({
    Select-RandomTemplate
})

$copyButton.Add_Click({
    try {
        Set-Clipboard -Value $messageBox.Text
        $statusLabel.Text = Get-UiValue -Key "CopiedStatus"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            (Get-UiValue -Key "CopyFailedMessage"),
            (Get-UiValue -Key "CopyFailedTitle"),
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        ) | Out-Null
    }
})

$openButton.Add_Click({
    try {
        Start-Process $discordDmUrl
        $statusLabel.Text = Get-UiValue -Key "OpenedStatus"
    } catch {
        [System.Windows.Forms.MessageBox]::Show(
            (Get-UiValue -Key "OpenFailedMessage"),
            (Get-UiValue -Key "OpenFailedTitle"),
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        ) | Out-Null
    }
})

$copyAndOpenButton.Add_Click({
    try {
        Set-Clipboard -Value $messageBox.Text
    } catch {
    }

    try {
        Start-Process $discordDmUrl
        $statusLabel.Text = Get-UiValue -Key "CopyAndOpenStatus"
    } catch {
        $statusLabel.Text = Get-UiValue -Key "CopyOpenFallbackStatus"
    }
})

$form.Add_Shown({
    $languageComboBox.SelectedIndex = if ($script:currentLanguage -eq "bg") { 1 } else { 0 }
    $messageBox.Select()
    $messageBox.SelectionStart = $messageBox.TextLength
})

$form.Add_FormClosed({
    if ($null -ne $script:logoImage) {
        $script:logoImage.Dispose()
    }
})

[void]$form.ShowDialog()
