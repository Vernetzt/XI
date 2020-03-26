version = "3.0"
pName = player.name
-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your RDM.lua, '..pName..' -----')

-- We're RDM so we're using Carm legs.
runspeedslot = 'legs'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF -- TO BE EXTERNALIZED
--------------------------------------------------------------------------------------------------------------
meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0   
time_start = 0

-- NEW
tickdelay = os.clock() + 5
dualwield = M('AUTO', '31', '11')
currentHaste = 30

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

setupTextWindow()

Buff = 
    {
        ['Composure'] = false, 
        ['Stymie'] = false, 
        ['Saboteur'] = false, 
        ['En-Weather'] = false,
        ['En-Day'] = false,
		['En-BadDay'] = false,
        ['Enspell'] = false,
    }
    
-- Reset the state vars tracking strategems.
function update_active_ja(name, gain)
    Buff['Composure'] = buffactive['Composure'] or false
    Buff['Stymie'] = buffactive['Stymie'] or false
    Buff['Saboteur'] = buffactive['Saboteur'] or false
    Buff['En-Weather'] = buffactive[nukes.enspell[world.weather_element]] or false
    Buff['En-Day'] = buffactive[nukes.enspell[world.day_element]] or false
	Buff['En-BadDay'] = buffactive[nukes.enspell[element.strong_to[world.day_element]]] or false
    Buff['Enspell'] =   buffactive[nukes.enspell['Earth']] or 
                        buffactive[nukes.enspell['Water']] or 
                        buffactive[nukes.enspell['Air']] or 
                        buffactive[nukes.enspell['Fire']] or 
                        buffactive[nukes.enspell['Ice']] or 
                        buffactive[nukes.enspell['Lightning']] or 
                        buffactive[nukes.enspell['Light']] or 
                        buffactive[nukes.enspell['Dark']] or false
end

function buff_refresh(name,buff_details)
    -- Update JA and statagems when a buff refreshes.
    update_active_ja()
    validateTextInformation()
    --NEW
    updateDualWield()
end

function buff_change(name,gain,buff_details)
    -- Update JA and statagems when a buff is gained or lost.
    update_active_ja()
    validateTextInformation()
    --NEW
    updateDualWield()

end

function RDM_lockMainHand( value )   
    -- We want to force lock weapons
	if value == 'ON' then
		-- We force lock only main and sub if in zeroTP mode (since we care abot lock, but not TP so Ullr and Ammo still swapping)
		if meleeModes.current == 'zeroTP' then
			disable('main','sub')
		-- If not in zeroTP mode, lock everything
		else
			disable('main','sub','ranged')
		end
	-- If we are in auto or off mode, but not in zeroTP, we unlock everything
    elseif value == 'OFF' or 'AUTO' then
		enable('main','sub','ranged')
	end
	validateTextInformation()
end

function precast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)
	local spell_recasts = windower.ffxi.get_spell_recasts()

    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')     
		add_to_chat(322, '****** !! '..spell.name..' CANCELED - Using Echo Drops !! ******')
    end       

	-- auto Nuke downgrade (T5 to T4 to T3 etc..) if the one you were trying is on recast timer. 
	-- It's a *bit* wonky when you spam the macro, so don't spam macros, or remove that part.
	if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(322, '['..spell.name..' CANCELED - Spell on Cooldown, Downgrading]')
        -- NEW
        send_command('input /recast "'..spell.name..'"')
    end    
	
	-- Checks for the TP threshold to lock weapons if over TP treshold -or- if we are in zeroTP mode 
    if meleeing.value == "AUTO" then
        if player.tp >= lockWeaponTP or meleeModes.current == 'zeroTP' then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        RDM_lockMainHand(lock.value)
    end

    -- Auto downgrade Phalanx II to Pahalanx I when casting on self, saves macro space so you can set your phalanx macro to cast phalanx2 on <stpt>
    if spell.target.type == 'SELF' and spell.name == "Phalanx II" then
        cancel_spell()
        send_command('input /ma "Phalanx" <me>') 
		add_to_chat(322, '****** ['..spell.name..' detected on self. Downgraded to Phalanx] ******')
	end

	if spellMap == 'Utsusemi' then
        if buffactive[445] or buffactive[446] then
            cancel_spell()
            add_to_chat(322, '****** !! '..spell.english..' Canceled: [3+ IMAGES] !! ******')
        elseif (buffactive['Copy Image'] or buffactive['Copy Image (2)']) and spell.name == 'Utsusemi: Ichi' then
			windower.ffxi.cancel_buff(66)
			windower.ffxi.cancel_buff(444)
        end
	end

    -- Moving on to other types of magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)         
        -- Enhancing Magic
        elseif spell.skill == 'Enhancing Magic' then
         
            equip(sets.precast.enhancing)            
            if spell.name == 'Sneak' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end
    -- Job Abilities
    -- We use a cat
    -- catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])        
    end
end
 
function midcast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)

    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    -- Curing
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.midcast.cure.weather)
        else
            equip(sets.midcast.cure.normal)
        end
    elseif spell.name:match('Utsusemi') then       
        equip(sets.midcast.utsu)

    -- Enhancing
    elseif spell.skill == 'Enhancing Magic' then

        if spell.name:match('Protect') or spell.name:match('Shell') then
            equip({rring="Sheltered Ring"})
        elseif spell.name:match('Refresh') then
            equip(sets.midcast.refresh)
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen)
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        elseif spell.name:match('Phalanx') then
            equip(sets.midcast.phalanx)
        elseif spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
        elseif spell.name:match('Temper') or spellMap == "Enspell" or spellMap == "Gain" then
            equip(sets.midcast.enhancing.potency)
        else
            equip(sets.midcast.enhancing.duration) -- fall back to duration if not specified above 
        end

        -- Casting on others, then we use composure bonus set
        if Buff['Composure'] then 
            if  spell.target.type ~= 'SELF' and spell.target.type == 'PLAYER' then
                equip(sets.midcast.enhancing.composure)
            end
        end

    -- Enfeebling
    elseif spell.skill == 'Enfeebling Magic' then
        equip(sets.midcast.Enfeebling[enfeebMap])
        if Buff['Saboteur'] then
            equip({hands=EMPY.Hands})
        end 

		-- If Stymie is up AND we're casting silence, we swap to 5/5 EMPY
		if Buff['Stymie'] and spell.name =='Silence' then
			equip(sets.midcast.Enfeebling.composure)
		end

    -- Nuking
    elseif spell.type == 'BlackMagic' then
        if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end
        -- Obi up for matching weather / day
        if spell.element == world.weather_element and spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
            equip(sets.midcast.Obi)
        end
        if spell.element == world.day_element and spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
            equip(sets.midcast.Obi)
        end
    
    -- Fail safe
    elseif spell.type ~= "WeaponSkill" then
        equip(sets.midcast.casting)
    end
    -- And our catch all, if a set exists for this spell name, use it
    if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    -- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
    elseif sets.midcast[spellMap] then
        equip(sets.midcast[spellMap])
    end
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    if sets.me[spell.name] then
        equip(sets.me[spell.name])

        -- Sanguine BBlade belt optim
        if spell.name == 'Sanguine Blade' then
            -- Dark day and dark weather
            if spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.midcast.Obi)
            -- Double dark weather aka Dynamis
            elseif spell.element == world.weather_element and get_weather_intensity() == 2 then
                equip(sets.midcast.Obi)
            else
                equip(sets.midcast.Orpheus)                
            end
        end
    end
    
    -- Prevent Obi by swapping helix stuff last
    -- Dark based Helix gets "pixie hairpin +1"
    if spellMap == 'DarkHelix'then
        equip(sets.midcast.DarkHelix)
    end
    if spellMap == 'Helix' then
        equip(sets.midcast.Helix)
    end

end

function aftercast(spell)

    -- Then initiate idle function to check which set should be equipped
    if meleeing.value == "AUTO" then
        if player.tp >= lockWeaponTP or meleeModes.value == 'zeroTP' then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        RDM_lockMainHand(lock.value)
    end
    update_active_ja()
    updateDualWield()
    idle()

    -- NEW
    -- Probably wrong for RDM
    -- if not spell.interrupted then
    --     if spell.english == "Sleep II" then
    --       send_command('wait 35;gs c -cd '..spell.name..': [Off In 10~55 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~45 Seconds!]')
    --       send_command('timers create "Sleep II" 90 down')
    --     elseif spell.english == "Sleep" then
    --       send_command('wait 20;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
    --       send_command('timers create "Sleep" 60 down')
    --     elseif spell.english == "Break" then
    --       send_command('wait 20;gs c -cd '..spell.name..': [Off In 10 Seconds!]')
    --       send_command('timers create "Break" 30 down')
    --     elseif spell.english == "Bind" then
    --     send_command('wait 20;gs c -cd '..spell.name..': [Off In 10~40 Seconds!];wait 10;gs c -cd '..spell.name..': [Off In 0~30 Seconds!]')
    --       send_command('timers create "Bind" 60 down')
    --     end
    --   end

end

-- NEW
-- Remove chat confirms at a later date
function idle()
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if player.status=='Engaged' then
        if subWeapon.current:match('Shield') or subWeapon.current:match('Bulwark') or subWeapon.current:match('Buckler') or subWeapon.current:match('Grip') or subWeapon.current:match('Strap') then
            equip(sets.me.melee[meleeModes.value..'sw'])
        else
          if dualwield.value == 'AUTO' then
            if currentHaste == 30 then
              equip(sets.me.melee[meleeModes.value..'dw'])
            --   add_to_chat(322, 'AUTO ~ 31% DW')
            elseif currentHaste == 47 then
              equip(sets.me.melee[meleeModes.value..'dw11'])
            --   add_to_chat(322, 'AUTO ~ 11% DW')
            end
          else
            if dualwield.value == "11" then
                equip(sets.me.melee[meleeModes.value..'dw11'])
                -- add_to_chat(322, 'MANUAL ~ 11% DW')
            else
                equip(sets.me.melee[meleeModes.value..'dw'])
                -- add_to_chat(322, 'MANUAL ~ 31% DW')
            end
          end
        end
		-- Optimizes Belt for when we want enspell to matter
        if mainWeapon.value == "Crocea Mors" or "Vitiation Sword" then
            EnspellCheck()
        end
    else
        equip(sets.me.idle[idleModes.value])
        -- Checks MP for Fucho-no-Obi
        if player.mpp < 51 then
            equip(sets.me.latent_refresh)          
        end       
    end
    equip({main = mainWeapon.current, sub = subWeapon.current})
end
 
function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle()
         
    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
        idle()
    end
end

function self_command(command)
    hud_command(command)
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'melee' then
                meleeing:cycle()
                RDM_lockMainHand(meleeing.value)

            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot) 

            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
                idle()

            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()
                idle()

            -- NEW
            elseif commandArgs[2] == 'dualwield' then
                dualwield:cycle()
                idle()

            elseif commandArgs[2] == 'mainweapon' then
                mainWeapon:cycle()
                idle()

            elseif commandArgs[2] == 'subweapon' then
                subWeapon:cycle()
                idle()

            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()      

            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()               
            end
            validateTextInformation()
        end
        
        if commandArgs[1]:lower() == 'scholar' then
            handle_strategems(commandArgs)

        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')indower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    elements:cycle()
                    oldElement = elements.current
                elseif nuke == 'cycledown' then 
                    elements:cycleback() 
                    oldElement = elements.current
                end               
                validateTextInformation()

            elseif (nuke == 'enspellup' or nuke == 'enspelldown') then
                if nuke == 'enspellup' then
                    enspellElements:cycle()
                elseif nuke == 'enspelldown' then 
                    enspellElements:cycleback()
                end     
                validateTextInformation()

            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)                  
                validateTextInformation()

            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            elseif nuke == 'enspell' then
                send_command('@input /ma "'..nukes[nuke][enspellElements.current]..'"')     
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                --recast = windower.ffxi.get_spell_recasts(nukes[nuke][elements.current])
                --if recast > 0 
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
        end
    end
end


--NEW
-- Checks if auto and then sets var for engage logic.
function updateDualWield()
    if dualwield.value == 'AUTO' then
        if ( (buffactive[33] and not (buffactive.march or buffactive[580] or buffactive[604] or buffactive[228])) or --30% Haste and nothing else pretty much.
            (buffactive[13] and (buffactive.march or buffactive[604]) and (buffactive[580] or buffactive[604] or buffactive[228])) or --Honor March/MG alone very roughly negates slow, leaving you just needing a second.
            (buffactive[565] and buffactive.march == 2 and buffactive[580] and (buffactive[604] or buffactive[228])) ) then
            -- 30% haste
            currentHaste = 30
        elseif ( (buffactive[33] and (buffactive[580] or buffactive.march or buffactive[604] or buffactive[228])) or -- Flutter and Geo or march or MG or embrava
                (buffactive[580] and (buffactive.march or buffactive[604] or buffactive[228])) or -- Geo and march or MG or embrava
                (buffactive.march == 2 and (buffactive[604] or buffactive[228])) or -- March x2 and MG or Embrava
                (buffactive[13] and (buffactive.march == 2 or buffactive[580]) and (buffactive[604] or buffactive[228])) ) then -- Slow, but likez the mad buffs 'n shiz, yo.
            -- Capped Haste?
            currentHaste = 47
        end
    else
        -- Defaulting for next use.
        currentHaste = 30
    end
end