version = "3.0"
--[[
        Custom commands:
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode auto / on / off and locking of weapons
        gs c toggle idlemode            Toggles between Refresh and DT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)

        -- NEW
        gs c toggle bow
        gs c toggle dualwield	

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob				Toggles the Job section of the HUD on or off
        gs c hud lite					Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END
        gs c hud setcolor sections      Cycles colors for sections
        gs c hud setcolor options       Cycles colors for options
        gs c hud setcolor keybinds      Cycles colors for keybinds
        gs c hud setcolor selection     Cycles colors for selection
--]]
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--              ______                   _                  
--             / _____)        _     _  (_)                 
--            ( (____  _____ _| |_ _| |_ _ ____   ____  ___ 
--             \____ \| ___ (_   _|_   _) |  _ \ / _  |/___)
--             _____) ) ____| | |_  | |_| | | | ( (_| |___ |
--            (______/|_____)  \__)  \__)_|_| |_|\___ (___/ 
--                                              (_____|    
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Set this to true and as soon as you move you swap into movespeed set, and revert when stationary
-- Set it to false and the movespeed toggle is manual. 
autorunspeed = true
auto_CP_Cape = false
-- TP treshold where weapons gets locked. 
-- lockWeaponTP = 300
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
hud_x_pos = 1750    --important to update these if you have a smaller screen
hud_y_pos = 650     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 150 -- a value of 0 (invisible) to 255 (no transparency at all)
-- hud_font = 'Impact'
hud_font = 'Calibri'
hud_padding = 10
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('Liz-Includes.lua')
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Customize HUD looks and content
-- Colors: ('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

sectionsColors:set('orange')
keybindsColors:set('yellow')
optionsColors:set('white')
selectionColors:set('blue')
textHideMode:set(false)
textHideOptions:set(false)
textHideJob:set(false)
textHideBattle:set(false)
textHideHUD:set(false)
useLightMode:set(false)
keybinds:set(false)

--------------------------------------------------------------------------------------------------------------
-- NEW
--------------------------------------------------------------------------------------------------------------
-- Optional. Swap to your BLU macro sheet / book
set_macros(1,3) -- Sheet, Book

-- Set Stylelock
set_style(92)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt')
meleeModes = M('normal', 'acc', 'dt')

-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Important to read!
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add your weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list
-- mainWeapon = M('Crocea Mors', 'Naegling', 'Tauret', 'Maxentius', 'Daybreak','Aern Dagger')
-- subWeapon = M('Tauret', 'Ammurapi shield', 'Machaera +2', 'Naegling', 'Daybreak','Qutrub Knife')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Setup your Key Bindings here:
-- windower.send_command('bind insert gs c nuke cycle')            -- Insert Cycles Nuke element
-- windower.send_command('bind !insert gs c nuke cycledown')       -- ALT+Insert Cycles Nuke element in reverse order 

windower.send_command('bind f9 gs c toggle idlemode')           -- F9 to change Idle Mode    
windower.send_command('bind f8 gs c toggle meleemode')          -- F8 to change Melee Mode  
-- windower.send_command('bind !f9 gs c toggle melee')             -- Alt-F9 Toggle Melee mode on / off, locking of weapons
-- windower.send_command('bind home gs c toggle mainweapon')       -- Home Toggle Main Weapon
-- windower.send_command('bind !home gs c toggle subweapon')       -- ALT-Home Toggle sub Weapon.
windower.send_command('bind !` input /ma Stun <t>')             -- Alt-` Quick Stun Shortcut.
-- windower.send_command('bind delete gs c nuke enspellup')        -- delete Cycle Enspell Up
-- windower.send_command('bind !delete gs c nuke enspelldown')     -- Alt-delete Cycle Enspell Down
windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
-- windower.send_command('bind f10 gs c toggle matchsc')           -- F10 to change Match SC Mode         
windower.send_command('bind !end gs c hud lite')                -- Alt-End to toggle light hud version       
windower.send_command('bind ^end gs c hud keybinds')            -- CTRL-End to toggle Keybinds  

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F8)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(HOME)'
keybinds_on['key_bind_subweapon'] = '(Alt-HOME)'
keybinds_on['key_bind_element_cycle'] = '(INS)'
keybinds_on['key_bind_enspell_cycle'] = '(DEL)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    -- windower.send_command('unbind insert')            -- Insert Cycles Nuke element
    -- windower.send_command('unbind !insert')       -- ALT+Insert Cycles Nuke element in reverse order 

    windower.send_command('unbind f9')           -- F9 to change Idle Mode    
    windower.send_command('unbind f8')          -- F8 to change Melee Mode  
    windower.send_command('unbind !f9')             -- Alt-F9 Toggle Melee mode on / off, locking of weapons
    windower.send_command('unbind home')          -- Home Toggle Main Weapon
    windower.send_command('unbind !home')       -- ALT-Home Toggle sub Weapon.
    windower.send_command('unbind !`')             -- Alt-` Quick Stun Shortcut.
    windower.send_command('unbind delete')        -- delete Cycle Enspell Up
    windower.send_command('unbind !delete')     -- Alt-delete Cycle Enspell Down
    windower.send_command('unbind !f10')         -- Alt-F10 to change Nuking Mode
    windower.send_command('unbind f10')           -- F10 to change Match SC Mode         
    windower.send_command('unbind !end')                -- Alt-End to toggle light hud version       
    windower.send_command('unbind ^end')            -- CTRL-End to toggle Keybinds    
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('BLU_Lib.lua')      -- leave this as is 
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
                --  _____                  __      __        _       _     _
                -- / ____|                 \ \    / /       (_)     | |   | |
                --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
                --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
                --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
                -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Setup your Gear Sets below:
function get_sets()
    ----------------------------------------------------------
    -- Auto CP Cape: Will put on CP cape automatically when
    -- fighting Apex mobs and job is not mastered
	-- It will equip the cape and lock it when the apex mob is under 15% hp.
    ----------------------------------------------------------
    CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
    ----------------------------------------------------------

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	""
    AF.Body		=	"Assim. Jubbah +3"
    AF.Hands	=	""
    AF.Legs		=	""
    AF.Feet		=	""

    --Vitiation
    RELIC.Head		=	""
    RELIC.Body		=	""
    RELIC.Hands 	=	""
    RELIC.Legs		=	"Luhlaza Shalwar +3"
    RELIC.Feet		=	"Luhlaza Charuqs"

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	""

    -- Capes:
	Rosmerta = {}
    Rosmerta.DA = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Damage Taken -5%' } }
    Rosmerta.Nuke = { name = "Rosmerta's Cape", augments = { 'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10', } }
    Rosmerta.Crit = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10', } }
    Rosmerta.WSD = { name = "Rosmerta's Cape", augments = { 'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%', } }
    Rosmerta.STP = { name = "Rosmerta's Cape", augments = { 'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%' } }
    Rosmerta.FC = { name="Rosmerta's Cape", augments={'"Fast Cast"+10',} }
    
    --TEMPORARY
    HerculeanHelm = {}
    HerculeanHelm.TP = { name="Herculean Helm", augments={'"Triple Atk."+3','Accuracy+6','Attack+11',} }
    HerculeanHelm.FC = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+3','"Fast Cast"+5','STR+5',} }
  
    TaeonBody = {}
    TaeonBody.FC = { name="Taeon Tabard", augments = {'"Fast Cast"+2',} }
  
    HerculeanGloves = {}
    HerculeanGloves.WSD = { name="Herculean Gloves", augments={'Mag. Acc.+1','Crit. hit damage +2%','Weapon skill damage +7%','Accuracy+6 Attack+6','Mag. Acc.+12 "Mag.Atk.Bns."+12',} }
    HerculeanGloves.TP = { name="Herculean Gloves", augments={'Accuracy+2','"Triple Atk."+3','Attack+14',} }
    HerculeanGloves.TH = { name="Herculean Gloves", augments={'"Mag.Atk.Bns."+27','Enmity+7','"Treasure Hunter"+1','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
    HerculeanGloves.Idle = { name="Herculean Gloves", augments={'Pet: DEX+15','DEX+10','"Refresh"+2','Accuracy+1 Attack+1','Mag. Acc.+5 "Mag.Atk.Bns."+5',} }
  
    HerculeanLegs = {}
    HerculeanLegs.DT = { name = "Herculean Trousers", augments = { 'Accuracy+22', 'Damage taken-2%', 'VIT+6', } }
    HerculeanLegs.WSD = { name = "Herculean Trousers", augments = { 'Attack+28', 'Weapon skill damage +3%', 'STR+10', 'Accuracy+9', } }
  
    HerculeanFeet = {}
    HerculeanFeet.Idle = { name="Herculean Boots", augments={'MND+3','"Rapid Shot"+4','"Refresh"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',} }
    HerculeanFeet.TP = { name="Herculean Boots", augments={'"Triple Atk."+3','Accuracy+11','Attack+14',} }


    -- SETS
     
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          -- leave this empty
    sets.weapons = {}			-- leave this empty
    sets.me.dualwield = {}
	
    -- Optional 
	-- include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

	-- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    -- Movespeedset
    sets.me.movespeed = { 
        Legs        =   "Carmine Cuisses +1",
    }

    sets.me.idle.refresh = {
        ammo = "Staunch Tathlum",
        head = "Rawhide Mask",
        neck = "Sanctity Necklace",
        left_ear = "Etiolation Earring",
        right_ear = "Infused Earring",
        body = "Jhakri Robe +2",
        hands = HerculeanGloves.Idle,
        ring1 = "Defending Ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.DA,
        waist = "Flume Belt +1",
        legs = "Malignance Tights",
        feet = HerculeanFeet.Idle
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        ammo = "Staunch Tathlum",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear2 = "Eabani Earring",
        ear1= "Etiolation Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending ring",
        ring2 = "Gelatinous Ring +1",
        back = Rosmerta.DA,
        waist = "Flume belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.dt,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
    -- Combat Related Sets

	------------------------------------------------------------------------------------------------------
    -- Dual Wield sets
    -- !!!! Clean these up !!!!
	------------------------------------------------------------------------------------------------------

    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh,{   
        ammo = "Ginsen",
        head = "Dampening Tam",
        neck = "Mirage Stole +1",
        left_ear = "Suppanomimi",
        right_ear = "Eabani Earring",
        body = "Adhemar jacket +1",
        hands = "Adhemar wristbands +1",
        ring1 = "Epona's ring",
        ring2 = "Ilabrat Ring",
        back = Rosmerta.DA,
        waist = "Reiki Yotai",
        legs = "Samnuha Tights",
        feet = HerculeanFeet.TP,
    })

    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        -- ear2="Telos Earring",
        right_ring="Chirich Ring +1",
    })

    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Reiki Yotai",
        ear2="Eabani Earring",
        ear1="Suppanomimi",
        left_ring="Defending Ring",
        ring2 = "Epona's ring",
        back = Rosmerta.DA,
    })

    sets.me.melee.mdtdw = set_combine(sets.me.melee.dtdw,{

    })

    ------------------------------------------------------------------------------------------------------
    -- +31 and +11 Dual Wield sets for toggle
    -- NEW
 	------------------------------------------------------------------------------------------------------ 

    sets.me.melee.normaldw11 = set_combine(sets.me.melee.normaldw,{   
        ear1="Suppanomimi",
        ear2="Brutal Earring",
        -- ear2="Telos Earring",
        waist="Windbuffet belt +1",
    })

    sets.me.melee.accdw11 = set_combine(sets.me.melee.accdw,{  
        ear1="Suppanomimi",
        ear2="Cessance Earring",
        waist="Kentarch Belt",
    })

    sets.me.melee.dtdw11 = set_combine(sets.me.melee.dtdw,{   
        ear2="Brutal Earring",
    })

    sets.me.melee.mdtdw11 = set_combine(sets.me.melee.mdtdw,{   
        ear2="Brutal Earring",
    })


    ------------------------------------------------------------------------------------------------------
    -- AM3 31 Set
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw.TizAM3 = set_combine(sets.me.melee.normaldw,{   
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        back = Rosmerta.STP,
    })
    sets.me.melee.accdw.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{
        -- ear2="Telos Earring",
        ring1="Ilabart Ring",
        right_ring="Chirich Ring +1",
        waist="Reiki Yotai",
    })
    sets.me.melee.dtdw.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{
        ammo="Staunch Tathlum",
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
        right_ring="Chirich Ring +1",
    })
    sets.me.melee.mdtdw.TizAM3 = set_combine(sets.me.melee.dtdw.TizAM3,{

    })
    ------------------------------------------------------------------------------------------------------
        -- AM3 11 Set
    ------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw11.TizAM3 = set_combine(sets.me.melee.normaldw.TizAM3,{   
        ear1="Suppanomimi",
        ear2="Brutal Earring",
        -- ear2="Telos Earring",
        waist="Reiki Yotai",
    })
    sets.me.melee.accdw11.TizAM3 = set_combine(sets.me.melee.normaldw11.TizAM3,{  
        right_ring="Chirich Ring +1",
    })
    sets.me.melee.dtdw11.TizAM3 = set_combine(sets.me.melee.dtdw.TizAM3,{   
        ear1="Suppanomimi",
        ear2="Brutal Earring",
    })
    sets.me.melee.mdtdw11.TizAM3 = set_combine(sets.me.melee.dtdw11.TizAM3,{   
         
    })

    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    
    sets.me["Savage Blade"] = {
        ammo = "Amar cluster",
        head = "Lilitu headpiece",
        neck = 'Fotia Gorget',
        left_ear = "Moonshade Earring",
        right_ear = "Ishvara earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epona's ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.WSD,
        waist = "Fotia Belt",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Expiacion"] = {
        ammo = "Amar cluster",
        head = "Lilitu headpiece",
        neck = 'Fotia Gorget',
        left_ear = "Moonshade Earring",
        right_ear = "Ishvara earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epona's ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.WSD,
        waist = "Fotia Belt",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Chant du Cygne"] = {
        ammo = "Jukukik Feather",
        head = "Adhemar Bonnet +1",
        -- neck = 'Fotia Gorget',
        neck = "Mirage Stole +1",
        left_ear = "Steelflash earring",
        right_ear = "Bladeborn earring",
        body = "Adhemar jacket +1",
        -- body = "Abnoba Kaftan",
        hands = HerculeanGloves.WSD,
        ring1 = "Epona's ring",
        ring2 = "Begrudging Ring",
        back = Rosmerta.Crit,
        waist = "Fotia belt",
        legs = "Samnuha Tights",
        feet = "Thereoid greaves",
    }
    sets.me["Requiescat"] = {
        ammo = "Falcon Eye",
        head = "Jhakri Coronal +2",
        neck = "Fotia gorget",
        left_ear = "Moonshade Earring",
        right_ear = {name="Brutal earring", bag="wardrobe2"},
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epona's ring",
        ring2 = "Rajas ring",
        back = Rosmerta.WSD,
        waist = "Fotia Belt",
        legs = "Jhakri Slops +2",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Sanguine Blade"] = {
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Sanctity Necklace",
        left_ear = "Regal Earring",
        right_ear = "Friomisi Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Archon Ring",
        ring2 = "Shiva Ring +1",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Red Lotus Blade"] = {
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Sanctity Necklace",
        left_ear = "Regal Earring",
        right_ear = "Friomisi Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Archon Ring",
        ring2 = "Shiva Ring +1",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Seraph Blade"] = {
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        neck = "Sanctity Necklace",
        left_ear = "Regal Earring",
        right_ear = "Friomisi Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Archon Ring",
        ring2 = "Shiva Ring +1",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }
    sets.me["Black Halo"] = {
        ammo = "Amar cluster",
        head = "Lilitu headpiece",
        neck = 'Fotia Gorget',
        left_ear = "Moonshade Earring",
        right_ear = "Ishvara earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
        ring1 = "Epona's ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.WSD,
        waist = "Fotia Belt",
        legs = "Luhlaza Shalwar +3",
        feet = "Jhakri Pigaches +2",
    }

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} -- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast BLU
    sets.precast.casting = {
        ammo = "Sapience Orb",
        head = HerculeanHelm.FC,
        neck = "Voltsurge Torque",
        left_ear = "Etiolation Earring",
        right_ear = "Loquac. Earring",
        body = TaeonBody.FC,
        hands = "Leyline Gloves",
        -- ring1 = "Kishar Ring",
        ring1 = "Lebeche Ring",
        ring2 = "Rahab Ring",
        back = Rosmerta.FC,
        waist = "Witful Belt",
        legs = "Psycloth lappas",
        feet = "Carmine Greaves +1"
    }
    

    -- Special -Recast sets
    -- sets.me["Utsusemi: Ichi"] = {
    --     ammo = "Sapience Orb",
    --     head = HerculeanHelm.FC,
    --     neck = "Voltsurge Torque",
    --     left_ear = "Etiolation Earring",
    --     right_ear = "Loquac. Earring",
    --     body = TaeonBody.FC,
    --     hands = "Leyline Gloves",
    --     -- ring1 = "Kishar Ring",
    --     ring1 = "Lebeche Ring",
    --     ring2 = "Rahab Ring",
    --     back = Rosmerta.FC,
    --     waist = "Witful Belt",
    --     legs = "Psycloth lappas",
    --     feet = "Carmine Greaves +1"
    -- }
    -- sets.me["Utsusemi: Ni"] = {
    --     ammo = "Sapience Orb",
    --     head = HerculeanHelm.FC,
    --     neck = "Voltsurge Torque",
    --     left_ear = "Etiolation Earring",
    --     right_ear = "Loquac. Earring",
    --     body = TaeonBody.FC,
    --     hands = "Leyline Gloves",
    --     -- ring1 = "Kishar Ring",
    --     ring1 = "Lebeche Ring",
    --     ring2 = "Rahab Ring",
    --     back = Rosmerta.FC,
    --     waist = "Witful Belt",
    --     legs = "Psycloth lappas",
    --     feet = "Carmine Greaves +1"
    -- }


    sets.precast.enhancing = set_combine(sets.precast.casting,{
		-- don't really need this anymore with capped FC.
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		--Legacy. 
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		back		=	"Pahtli Cape",
        feet		=	"Telchine Pigaches",
		left_ring	=	"Lebeche Ring",		
    })

      
    ---------------------
    -- Ability Precasting
    ---------------------

    -- sets.precast["Chainspell"] = {body = RELIC.Body}
	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        --waist="Orpheus's Sash", -- Commented cause I dont have one yet
    }

        
    -- Utsu SIRD and DT here
    sets.midcast.utsu = set_combine(sets.me.idle.dt, {

    })

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        ammo = "Pemphredo Tathlum",
        head = "Jhakri Coronal +2",
        neck = "Sanctity Necklace",
        left_ear = "Friomisi earring",
        right_ear = "Regal Earring",
        body = "Amalric doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Shiva ring +1",
        ring2 = "Jhakri ring",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Amalric Slops +1",
        feet = "Jhakri Pigaches +2"
    }

    sets.midcast.nuking.normal = {
        ammo = "Pemphredo Tathlum",
        head = "Jhakri Coronal +2",
        neck = "Sanctity Necklace",
        left_ear = "Friomisi earring",
        right_ear = "Regal Earring",
        body = "Amalric doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Shiva ring +1",
        ring2 = "Jhakri ring",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Amalric Slops +1",
        feet = "Jhakri Pigaches +2"
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        left_ring	=	"Mujin Band",
        right_ring	=	"Locus Ring",
    })

    sets.midcast.nuking.acc = {
        ammo = "Pemphredo Tathlum",
        head = "Jhakri Coronal +2",
        neck = "Sanctity Necklace",
        left_ear = "Friomisi earring",
        right_ear = "Regal Earring",
        body = "Amalric doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Shiva ring +1",
        ring2 = "Jhakri ring",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Amalric Slops +1",
        feet = "Jhakri Pigaches +2"
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
        left_ring	=	"Mujin Band",
        right_ring	=	"Locus Ring",
    })	

    -- Blue Magic

    sets.midcast.BluDark = set_combine(sets.midcast.nuking.normal,{
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
    })
    sets.midcast.BluLight = set_combine(sets.midcast.nuking.normal,{

    })


    sets.midcast.BluSTR = {
        ammo = "Amar cluster",
        head = "Jhakri Coronal +2",
        neck = "Asperity Necklace",
        left_ear = "Steelflash earring",
        right_ear = "Bladeborn earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
        ring1 = "Apate Ring",
        ring2 = "Rajas ring",
        back = Rosmerta.WSD,
        waist = "Kentarch belt",
        legs = "Jhakri Slops +2",
        feet = "Jhakri Pigaches +2"
    }

    sets.midcast.BluDEX = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluVIT = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluMND = set_combine(sets.midcast.BluSTR, {})

    sets.midcast.BluAGI = set_combine(sets.midcast.BluSTR, {})

    --Conserve MP Gear, 55%, FC, 17%--
    sets.midcast.BluBuff = {
        ammo = "Pemphredo Tathlum",
        head = "Telchine Cap",
        neck = "Deceiver's Torque",
        left_ear = "Mendicant's Earring",
        -- right_ear = "Magnetic Earring",
        -- body = "Vedic Coat",
        -- hands = "Shrieker's Cuffs",
        -- ring1 = "Kishar Ring",
        ring2 = "Rahab Ring",
        back = "Solemnity Cape",
        waist = "Hachirin-no-Obi",
        legs = "Lengo Pants",
        feet = "Carmine Greaves +1"
    }

    --Just for landing things like sleep--
    sets.midcast.BluMACC = {
        ammo = "Pemphredo tathlum",
        head = "Malignance chapeau",
        neck = "Mirage Stole +1",
        left_ear = "Dignitary's earring",
        right_ear = "Regal Earring",
        body = "Malignance tabard",
        hands = "Malignance gloves",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back = Rosmerta.Nuke,
        waist = "Eschan Stone",
        legs = "Malignance tights",
        feet = "Malignance boots"
    }

    sets.midcast.BluStun = {
        ammo = "Pemphredo Tathlum",
        head = "Malignance chapeau",
        neck = "Mirage Stole +1",
        left_ear = "Dignitary's earring",
        right_ear = "Regal Earring",
        body = "Malignance tabard",
        hands = "Malignance gloves",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back = "Cornflower cape",
        waist = "Eschan Stone",
        legs = "Malignance tights",
        feet = "Malignance boots"
    }

    --Occultation is every 50 skill, magic barrier equals skill, anything that isn't /50 doesn't matter.
    ---For example diamondhide caps at 500
	---Mastered Skill w/ merits is 472
	
    sets.midcast.BluSkill = {
        ammo = "Pemphredo Tathlum", 
        head = "Luhlaza Keffiyeh +3", --17
        neck = "Mirage Stole +1", --20
        left_ear = "Etiolation Earring",
        right_ear = "Loquac. Earring",
        body = "Assim. Jubbah +3", --24
        hands = "Rawhide Gloves", --10
        ring1 = "Stikini Ring",
        ring2 = "Stikini Ring", --8
        back = "Cornflower cape", --15
        waist = "Witful Belt",
        legs = "Hashishin Tayt +1", --23
        feet = "Luhlaza Charuqs +3" --12
    }
    
    --Aim for empy hands and FC+ with skill /50
	---Capped magic haste 1200JPs with flutter FC, only 23% FC is needed to cap.
	sets.midcast.Occultation = {
        ammo = "Pemphredo Tathlum",
        -- head = "Luhlaza Keffiyeh +1",
        neck = "Mirage Stole +1",
        left_ear = "Etiolation Earring",
        right_ear = "Loquac. Earring",
        body = "Assim. Jubbah +3",
        hands = "Rawhide Gloves",
        -- ring1 = "Kishar Ring",
        ring2 = "Stikini Ring",
        back = "Cornflower cape",
        waist = "Witful Belt",
        -- legs = "Hashishin Tayt +1",
        feet = "Luhlaza Charuqs"
    }

	--Reaving Wind, Feather Tickle, Osmosis, etc
	sets.midcast.BluFastRecast = {
        ammo = "Sapience Orb",
        -- head = CarmineMask.FC,
        -- neck = "Orunmila's Torque",
        left_ear = "Etiolation Earring",
        right_ear = "Loquac. Earring",
        -- body = AdhemarJacket.FC,
        -- hands = "Hashishin Bazubands +1",
        -- ring1 = "Kishar Ring",
        ring2 = "Rahab Ring",
        back = Rosmerta.Nuke,
        waist = "Witful Belt",
        legs = "Ayanmo Cosciales +2",
        feet = "Carmine Greaves +1"
	}

    sets.midcast.Enmity = {
        ammo = "Sapience Orb",
        head = "Rabid Visor",
        neck = "Unmoving Collar +1",
        left_ear = "Friomisi Earring",
        right_ear = "Cryptic Earring",
        body = "Emet Harness +1",
        hands = "Leyline Gloves",
        ring1 = "Supershear Ring",
        ring2 = "Eihwaz Ring",
        back = "Reiki Cloak",
        waist = "Kasiri Belt",
        legs = "Obatala Subligar",
        Feet = "Ahosi Leggings"
    }

	
    -- Enhancing yourself 
    sets.midcast.enhancing = {
        head = "Telchine Cap",
        neck = "Melic Torque",
        left_ear = "Andoaa Earring",
        body = "Telchine Chasuble",
        ring2 = "Stikini Ring",
        ring1 = "Stikini Ring",
        -- back = "Perimede Cape",
        legs = "Carmine Cuisses +1",
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
    }


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing, {
        head = "Telchine Cap",
        neck = "Melic Torque",
        left_ear = "Andoaa Earring",
        body = "Telchine Chasuble",
        ring2 = "Stikini Ring",
        ring1 = "Stikini Ring",
        -- back = "Perimede Cape",
        legs = "Carmine Cuisses +1",
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
        waist		=	"Siegel Sash",
        ear1        =   "Earthcry Earring",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
        -- head		=	Amal.Head.A,
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh,{
        waist   =   "Emphatikos Rope",
    })
	
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
      -- ammo = "Hydrocera",
      -- head = CarmineMask.MND,
      -- neck = "Phalaina Locket",
      left_ear = "Mendicant's Earring",
      right_ear = "Regal Earring",
      -- body = "Pinga Tunic",
      hands = "Telchine Gloves",
      ring1 = "Stikini Ring",
      ring2 = "Kunaji ring",
      back = "Solemnity cape",
      waist = "Luminary Sash",
      legs = "Telchine Braconi",
      feet = "Medium's Sabots"
    })
    
     -- Add to RDM_Lib.lua
    sets.midcast.cure.self = set_combine(sets.midcast.casting,{
      -- ammo = "Hydrocera",
      -- head = CarmineMask.MND,
      -- neck = "Phalaina Locket",
      left_ear = "Mendicant's Earring",
      right_ear = "Regal Earring",
      -- body = "Pinga Tunic",
      hands = "Telchine Gloves",
      ring1 = "Stikini Ring",
      ring2 = "Kunaji ring",
      back = "Solemnity cape",
      waist = "Luminary Sash",
      legs = "Telchine Braconi",
      feet = "Medium's Sabots"
    })
    sets.midcast.cure.wind = set_combine(sets.midcast.cure.normal,{
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Sanctity Necklace",
        ear2 = "Mendicant's Earring",
        ear1 = "Etiolation Earring",
        body = "Assimilator's Jubbah +3",
        hands = "Telchine Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Kunaji ring",
        back = "Solemnity cape",
        waist = "Luminary Sash",
        legs = "Luhlaza Shalwar +3",
        feet = "Medium's Sabots"
    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing, {

    })


    ----------------
    --Utility Sets--
    ----------------
    sets.Utility = {}
    
    sets.Utility.TH = {
        waist = "Chaac Belt",
        hands = HerculeanGloves.TH,
        head = "White rarab cap +1"
    }
	--Comes on when slept, terrored, stunned, and petrified--
    --Capped DT and -42% MDT, assumes shell etc may be gone after being unable to act--
    sets.Utility.AutoDT = {
        ammo = "Staunch Tathlum",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        left_ear = "Etiolation Earring",
        right_ear = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending ring",
        ring2 = "Gelatinous Ring +1",
        back = Rosmerta.DA,
        waist = "Flume belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }
    
    sets.Utility.Doom = {
		ring2 = "Saida Ring",
        ring1 = "Purity Ring",
        waist = "Gishdubar Sash"
    }

	--Meditate, TP Wings, Volte Harness all increase TP rewarded based on your STP--
	sets.Utility.Volte = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		neck="Mirage Stole +2",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		body="Volte Harness",
        hands="Malignance Gloves",
        ring2="Petrov Ring",
		-- ring2="Petrov Ring",
		back=Rosmerta.STP,
		waist="Kentarch Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
    }
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
