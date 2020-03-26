version = "3.0"
--[[
        Custom commands:

        Becasue /sch can be a thing... I've opted to keep this part 

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode auto / on / off and locking of weapons
        gs c toggle idlemode            Toggles between Refresh and DT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)

        -- NEW
        gs c toggle bow
        gs c toggle dualwield
        
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
		gs c nuke enspell				Cast enspell of saved enspell element		

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

        Alternatively you can also add the color after those command like: //gs c hud setcolor options blue

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
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
lockWeaponTP = 400
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
-- Optional. Swap to your RDM macro sheet / book
set_macros(1,13) -- Sheet, Book

-- Set Stylelock
set_style(92)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
meleeModes = M('normal', 'acc', 'dt', 'mdt', 'zeroTP')

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
mainWeapon = M('Crocea Mors', 'Naegling', 'Tauret', 'Maxentius', 'Daybreak')
subWeapon = M('Tauret', 'Ammurapi shield', 'Machaera +2', 'Naegling', 'Daybreak')

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

-- Setup your Key Bindings here:
    -- windower.send_command('bind insert gs c nuke cycle')            -- Insert Cycles Nuke element
    -- windower.send_command('bind !insert gs c nuke cycledown')       -- ALT+Insert Cycles Nuke element in reverse order 

    windower.send_command('bind f9 gs c toggle idlemode')           -- F9 to change Idle Mode    
    windower.send_command('bind f8 gs c toggle meleemode')          -- F8 to change Melee Mode  
    windower.send_command('bind !f9 gs c toggle melee')             -- Alt-F9 Toggle Melee mode on / off, locking of weapons
    windower.send_command('bind home gs c toggle mainweapon')       -- Home Toggle Main Weapon
    windower.send_command('bind !home gs c toggle subweapon')       -- ALT-Home Toggle sub Weapon.
    windower.send_command('bind !` input /ma Stun <t>')             -- Alt-` Quick Stun Shortcut.
    windower.send_command('bind delete gs c nuke enspellup')        -- delete Cycle Enspell Up
    windower.send_command('bind !delete gs c nuke enspelldown')     -- Alt-delete Cycle Enspell Down
    windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
    windower.send_command('bind f10 gs c toggle matchsc')           -- F10 to change Match SC Mode         
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
include('RDM_Lib.lua')      -- leave this as is 
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
    AF.Head		=	"Atro.Chapeau +1"
    AF.Body		=	"Atrophy Tabard +1"
    -- AF.Hands	=	"Atrophy Gloves +3"
    AF.Hands	=	"Atrophy Gloves +1"
    AF.Legs		=	"Atrophy Tights +1"
    AF.Feet		=	"Atrophy Boots +1"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +1"
    -- RELIC.Head		=	"Viti. Chapeau +3"
    -- RELIC.Body		=	"Viti. Tabard +3"
    RELIC.Body		=	"Viti. Tabard +1"
    RELIC.Hands 	=	"Viti. Gloves +1"
    RELIC.Legs		=	"Viti. Tights +3"
    RELIC.Feet		=	"Vitiation Boots +1"
    -- RELIC.Feet		=	"Vitiation Boots +3"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel +1"
    EMPY.Body		=	"Lethargy Sayon +1"
    EMPY.Hands		=	"Leth. Gantherots +1"
    EMPY.Legs		=	"Leth. Fuseau +1"
    EMPY.Feet		=	"Leth. Houseaux +1"

    -- Capes:
    --Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.TPDW	=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}
    RDMCape.MACC	=	{ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
    RDMCape.STR 	=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    RDMCape.CRIT 	=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
    RDMCape.MATT 	=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10',}}

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
        ammo="Homiliary",
        head=RELIC.Head,
        body="Jhakri Robe +2",
        hands={ name="Chironic Gloves", augments={'Rng.Atk.+8','"Drain" and "Aspir" potency +2','"Refresh"+1','Accuracy+16 Attack+16','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
        legs="Malignance Tights",
        feet={ name="Merlinic Crackows", augments={'Blood Pact Dmg.+3','Accuracy+9','"Refresh"+1','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        neck="Sanctity Necklace",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring +1",
        back=RDMCape.TPDW,
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring +1",
        back=RDMCape.TPDW,
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
            ammo="Ginsen",
            head="Malignance Chapeau",
            body="Malignance Tabard",
            hands="Malignance Gloves",
            legs="Malignance Tights",
            feet={ name="Taeon Boots", augments={'Attack+24','"Dual Wield"+3','STR+6 AGI+6',}},         --9
            neck="Anu Torque",
            waist="Windbuffet Belt +1",
            -- waist="Reiki Yotai",                                                                     --7
            left_ear="Suppanomimi",                                                                     --5
            right_ear="Eabani Earring",                                                                  --4
            left_ring="Petrov Ring",
            right_ring="Rajas Ring",
            back=RDMCape.TPDW,                                                                       --10
    })

    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
        neck="Lissome Necklace",
        ear2="Cessance Earring",
        -- ear2="Telos Earring",
    })

    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Eabani Earring",
        left_ring="Defending Ring",
        right_ring="Rajas Ring",
        back=RDMCape.TPDW,
    })

    sets.me.melee.mdtdw = set_combine(sets.me.melee.dtdw,{

    })

    sets.me.melee.zeroTPdw = set_combine(sets.me.melee.normaldw,{

    })

    ------------------------------------------------------------------------------------------------------
    -- +31 and +11 Dual Wield sets for toggle
    -- NEW
 	------------------------------------------------------------------------------------------------------ 

    sets.me.melee.normaldw11 = set_combine(sets.me.melee.normaldw,{   
        -- back="Nexus Cape",
    })

    sets.me.melee.accdw11 = set_combine(sets.me.melee.accdw,{   
    })

    sets.me.melee.dtdw11 = set_combine(sets.me.melee.dtdw,{   
         
    })

    sets.me.melee.mdtdw11 = set_combine(sets.me.melee.mdtdw,{   
         
    })

    sets.me.melee.zeroTPdw11 = set_combine(sets.me.melee.normaldw,{

    })

    ------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
    ------------------------------------------------------------------------------------------------------   
    
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{   
        -- legs		=	RELIC.Legs,
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{

    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw,{

    })
    sets.me.melee.zeroTPsw = set_combine(sets.me.melee.normalsw,{

    })
	
    ------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
    ------------------------------------------------------------------------------------------------------
    
    sets.me["Savage Blade"] = {
        ammo="Amar Cluster",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Apate Ring",
        right_ring="Karieyh Ring",
        back=RDMCape.STR,
    }
    sets.me["Death Blossom"] = {
        ammo="Amar Cluster",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Apate Ring",
        right_ring="Karieyh Ring",
        back=RDMCape.CRIT,
	}
    sets.me["Black Halo"] = {
        ammo="Amar Cluster",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        left_ring="Apate Ring",
        right_ring="Karieyh Ring",
        back=RDMCape.MACC,
    }
    sets.me["Requiescat"] = {
        ammo="Ginsen",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Bladeborn Earring",
        right_ear="Steelflash Earring",
        left_ring="Apate Ring",
        right_ring="Begrudging Ring",
        back=RDMCape.MACC,
    }
    sets.me["Chant du Cygne"] = {
        ammo="Ginsen",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs="Jhakri Slops +2",
        feet="Thereoid Greaves",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Bladeborn Earring",
        right_ear="Steelflash Earring",
        left_ring="Apate Ring",
        right_ring="Begrudging Ring",
        back=RDMCape.CRIT,
    }
    sets.me["Sanguine Blade"] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +4','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        neck="Mizu. Kubikazari",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Karieyh Ring",
        back=RDMCape.MACC,
    }
    sets.me["Red Lotus Blade"] = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +4','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Malignance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Karieyh Ring",
        back=RDMCape.MACC,
    }
    sets.me["Seraph Blade"] = {
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +4','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Malignance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Karieyh Ring",
        back=RDMCape.MACC,
    }
    sets.me["Aeolian Edge"] = {
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +4','Mag. Acc.+12','"Mag.Atk.Bns."+12',}},
        neck="Mizu. Kubikazari",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        left_ring="Shiva Ring +1",
        right_ring="Karieyh Ring",
        back=RDMCape.MACC,
    }
    sets.me["Evisceration"] = {
        ammo="Ginsen",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Malignance Gloves",
        legs="Jhakri Slops +2",
        feet="Thereoid Greaves",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Bladeborn Earring",
        right_ear="Infused Earring",
        left_ring="Apate Ring",
        right_ring="Begrudging Ring",
        back=RDMCape.CRIT,
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
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
        main="Crocea Mors",
        ammo="Impatiens",
        head="Atro. Chapeau +1",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Witful Belt",
        left_ear="Etiolation Earring",
        right_ear="Malignance Earring",
        left_ring="Defending Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    }
    
    -- Test Crocea Mors set
    -- sets.precast.FC['Crocea Mors'] = { 
    --     main="Crocea Mors",
    --     ammo="Impatiens",
    --     head="Atro. Chapeau +1",
    --     body="Malignance Tabard",
    --     hands="Malignance Gloves",
    --     legs="Malignance Tights",
    --     feet="Malignance Boots",
    --     neck="Loricate Torque +1",
    --     waist="Witful Belt",
    --     left_ear="Etiolation Earring",
    --     right_ear="Eabani Earring",
    --     left_ring="Defending Ring",
    --     right_ring="Lebeche Ring",
    --     back="Solemnity Cape",
    -- }										--Total: 54 -- overcapped by 12 TODO: Adjust more DT / HP into this set.

    -- Special -Recast sets
    sets.me["Utsusemi: Ichi"] = {
        main="Crocea Mors",
        ammo="Impatiens",
        head="Atro. Chapeau +1",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Witful Belt",
        left_ear="Etiolation Earring",
        right_ear="Malignance Earring",
        left_ring="Defending Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    }
    sets.me["Utsusemi: Ni"] = {
        main="Crocea Mors",
        ammo="Impatiens",
        head="Atro. Chapeau +1",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Witful Belt",
        left_ear="Etiolation Earring",
        right_ear="Malignance Earring",
        left_ring="Defending Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    }

	sets.precast["Stun"] = set_combine(sets.precast.casting,{
		-- TODO: Actually make this.
    })

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

    sets.precast['Dispelga'] = set_combine(sets.precast.casting,{ 
        main = "Daybreak",
        sub="Ammurapi Shield"
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Chainspell"] = {body = RELIC.Body}
	 

	
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
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
		head		=	"Pixie Hairpin +1",
		waist		=	"Refoccilation Stone",
        left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
		waist		=	"Refoccilation Stone",
    }	
        
    -- Utsu SIRD and DT here
    sets.midcast.utsu = set_combine(sets.me.idle.dt, {

    })

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet="Jhakri Pigaches +2",
        neck="Dls. Torque +1",
        waist="Eschan Stone",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Jhakri Ring",
        right_ring="Shiva Ring +1",
        back=RDMCape.MACC,
    }

    sets.midcast.nuking.normal = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        left_ring="Jhakri Ring",
        right_ring="Shiva Ring +1",
        back=RDMCape.MACC,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        left_ring	=	"Mujin Band",    
        head={ name="Merlinic Hood", augments={'Mag. Acc.+29','Magic burst dmg.+11%','MND+9','"Mag.Atk.Bns."+14',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+10%','MND+7','"Mag.Atk.Bns."+11',}},
        neck		=	"Mizu. Kubikazari",
        right_ring	=	"Locus Ring",
    })

    sets.midcast.nuking.acc = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Malignance Earring",
        left_ring="Jhakri Ring",
        right_ring="Shiva Ring +1",
        back=RDMCape.MACC,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
        left_ring	=	"Mujin Band",    
        --head		=	Merl.Head.MB,
        --body		=	Merl.Body.MB,
        neck		=	"Mizu. Kubikazari",
        right_ring	=	"Locus Ring",
    })	

    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod
    sets.midcast.Enfeebling.macc = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Chironic Hose", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','INT+1','Mag. Acc.+9','"Mag.Atk.Bns."+11',}},
        feet="Jhakri Pigaches +2",
        neck="Dls. Torque +1",
        waist="Eschan Stone",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back=RDMCape.MACC,
    }
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
    --Type B-potency from: Mnd & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.mndpot = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Chironic Hose", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','INT+1','Mag. Acc.+9','"Mag.Atk.Bns."+11',}},
        feet="Jhakri Pigaches +2",
        neck="Dls. Torque +1",
        waist="Luminary Sash",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back=RDMCape.MACC,
    }
	-- Type C-potency from: Int & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.intpot = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Cath Palug Crown",
        body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        hands="Jhakri Cuffs +2",
        legs={ name="Chironic Hose", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','INT+1','Mag. Acc.+9','"Mag.Atk.Bns."+11',}},
        feet="Jhakri Pigaches +2",
        neck="Dls. Torque +1",
        waist="Luminary Sash",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back=RDMCape.MACC,
    }
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillpot = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Impatiens",
        head="Befouled Crown",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands={ name="Viti. Gloves +1", augments={'Enhancing Magic duration',}},
        legs="Atrophy Tights +1",
        feet="Leth. Houseaux +1",
        neck="Melic Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Rahab Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +9','Mag. Acc.+7','Enh. Mag. eff. dur. +19',}},
    }
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillmndpot = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Impatiens",
        head="Befouled Crown",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands={ name="Viti. Gloves +1", augments={'Enhancing Magic duration',}},
        legs="Atrophy Tights +1",
        feet="Leth. Houseaux +1",
        neck="Melic Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Rahab Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +9','Mag. Acc.+7','Enh. Mag. eff. dur. +19',}},
    }
	-- Type F-potency from "Enfeebling potency" gear only
    sets.midcast.Enfeebling.potency = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Impatiens",
        head="Befouled Crown",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands={ name="Viti. Gloves +1", augments={'Enhancing Magic duration',}},
        legs="Atrophy Tights +1",
        feet="Leth. Houseaux +1",
        neck="Melic Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Rahab Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +9','Mag. Acc.+7','Enh. Mag. eff. dur. +19',}},
    }

	-- 5/5 Empy for Stymie + Silence
    sets.midcast.Enfeebling.composure = set_combine(sets.midcast.Enfeebling.macc, {
        head		=	EMPY.Head,
        body		=	EMPY.Body,
        hands		=	EMPY.Hands,
        legs		=	EMPY.Legs,
        feet		=	EMPY.Feet,
    })
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Impatiens",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
        hands="Atrophy Gloves +1",
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}},
        feet="Leth. Houseaux +1",
        neck="Dls. Torque +1",
        waist="Witful Belt",
        left_ear="Etiolation Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Rahab Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +9','Mag. Acc.+7','Enh. Mag. eff. dur. +19',}},
    }
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Impatiens",
        head="Befouled Crown",
        body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
        hands={ name="Viti. Gloves +1", augments={'Enhancing Magic duration',}},
        legs="Atrophy Tights +1",
        feet="Leth. Houseaux +1",
        neck="Melic Torque",
        waist="Olympus Sash",
        left_ear="Andoaa Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring",
        right_ring="Rahab Ring",
        back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +9','Mag. Acc.+7','Enh. Mag. eff. dur. +19',}},
    }) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
        head		=	EMPY.Head,
        hands		=	AF.Hands,
        legs		=	EMPY.Legs,
        back		=	RDMCape.MACC,
    })  


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
        -- head		=	Taeon.Head.Phalanx,
        -- body		=	Taeon.Body.Phalanx,
        -- hands	=	Taeon.Hands.Phalanx,
        -- legs		=	Taeon.Legs.Phalanx,
        -- feet		=	Taeon.Feet.Phalanx,
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration,{
		waist		=	"Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration,{
		-- head		=	Amal.Head.A,
    })

    sets.midcast.aquaveil = sets.midcast.refresh
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        main		=	"Rubicundity",
        sub         =   "Ammurapi shield",
		head		=	"Pixie Hairpin +1",
		neck		=	"Erra Pendant",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands={ name="Vanya Cuffs", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        neck="Henic Torque",
        waist="Luminary Sash",
        left_ear="Novia Earring",
        right_ear="Mendi. Earring",
        left_ring="Kunaji Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    })
    
     -- Add to RDM_Lib.lua
     sets.midcast.cure.self = set_combine(sets.midcast.casting,{
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands={ name="Vanya Cuffs", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
        feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        neck="Nodens Gorget",
        waist="Luminary Sash",
        left_ear="Novia Earring",
        right_ear="Mendi. Earring",
        left_ring="Kunaji Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
        main		=	"Chatoyant Staff",
        sub="Enki Strap",
    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {

    })

	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
