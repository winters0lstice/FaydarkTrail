$intro="
faydark trail v1.0

proof of concept - turn based, oregon trail style, eq themed

click JOB BOARD to get a quest

click CHOOSE ZONE to travel to a connecting zone

click END TURN to perform next step in your active quest

Click WAIT HERE to stay in the current zone and end your turn

"

Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms    
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Web

$Here = Get-Location
$PlayDing = New-Object System.Media.SoundPlayer
$PlayDing.SoundLocation = "$Here"+"\ding.wav"
$script:MapActive = $false
$script:AutoTurns = 1
[string]$MapMobName = " "
[string]$MapZoneName = " "
$MapNextZone = " "

#region main Objects

$Player = New-object PSObject -Property ([ordered]@{
        Name = "Player1"
        Lvl = 1
        HP = 40
        MaxHP = 40
        Mana = 20
        MaxMana = 20
        Dmg = 8
        Plat = 1
        Class = "warrior"
        Race = "wood elf"
        Primary = "sword"
        Secondary = "shield"
        Armor = "plain"
        Spells = " "
        Inv = @()
        Quest = " "
        QCount = 0
        Zone = 6
        NZone = 6
        QZone = 0
})

$Mob = New-object PSObject -Property ([ordered]@{
        IsActive = "false"
        Name = "mob"
        Lvl = 1
        HP = 1
        Dmg = 2
        Plat = 1
        Source = "$Here\objects\bat.png"
        Loot = " "
})

$Quest = New-object PSObject -Property ([ordered]@{
        Name = "kelethin"
        Source = '"$Here\objects\kelethin.png"'
        Count = 0
        Loot = @()
        Quests = @("Deliver shipment to Felwithe","Thin out the orcs")
        QZone = 1
})

$Potion = New-object PSObject -Property ([ordered]@{
        Name = "healing potion"
        Source = '"$Here\objects\potionRed.png"'
        Charges = 5
        Message = "5 dose healing potion"
})

$Zone = New-object PSObject -Property ([ordered]@{
        Name = " "
        Source = " "
        Lvl = 1
        ZEM = 0
        Lable1 = " "
        Lable2 = " "
        Lable3 = " "
        MessageColor = "White"
        Events = @()
        Mobs = @()
        Primary = @()
        Secondary = @()
        Armor = @()
        Spells = @()
        Items = @()
        Quests = @()
        Connect = @()
})

$Bot1 = New-object PSObject -Property ([ordered]@{
        Name = "Bot 1"
        Lvl = 1
        HP = 20
        Dmg = 5
        Plat = 20
        Class = "warrior"
        Race = "wood elf"
        Primary = "sword"
        Secondary = "shield"
        Armor = "plain"
        Spells = " "
})

$Bot2 = New-object PSObject -Property ([ordered]@{
        Name = "Bot 2"
        Lvl = 1
        HP = 20
        Dmg = 5
        Plat = 20
        Class = "warrior"
        Race = "wood elf"
        Primary = "sword"
        Secondary = "shield"
        Armor = "plain"
        Spells = " "
})

Function Bot1{
    Log "feature coming soon"
    $WPFlabelBot1Name.content = $Bot1.Name

    $WPFlabelBot2Name.content = $Bot2.Name

}

#endregion main Objects

#region Zones

Function ZoneKelethin{        
    $ZoneName = "kelethin"
    $ZoneSource = "$Here\objects\kelethin.png"
    $ZoneLvl = 1
    $ZoneZEM = 0
    $ZoneLable1 = "Kelethin"
    $ZoneLable2 = "The wood elf tree city is thriving with healthy job board. Other services include merchants and bank access."
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @()
    $ZoneMobs = @()
    $ZonePrimary = @()
    $ZoneSecondary = @()
    $ZoneArmor = @()
    $ZoneSpells = @()
    $ZoneItems = @("orc belt","rusty short sword")
    $ZoneQuests = @("Deliver shipment to Felwithe","Thin out the orcs")
    $ZoneConnect = @("Orc Hill","Greater Faydark")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneFelwithe{        
    $ZoneName = "felwithe"
    $ZoneSource = "$Here\objects\Felwithe.png"
    $ZoneLvl = 1
    $ZoneZEM = 0
    $ZoneLable1 = "Felwithe"
    $ZoneLable2 = "The high elf tree city is thriving with healthy job board. Other services include merchants and bank access."
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @()
    $ZoneMobs = @()
    $ZonePrimary = @()
    $ZoneSecondary = @()
    $ZoneArmor = @()
    $ZoneSpells = @()
    $ZoneItems = @()
    $ZoneQuests = @("Deliver shipment to Kelethin","Thin out the orcs")
    $ZoneConnect = @("Greater Faydark trail","Greater Faydark Spires")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneOrcHill{        
    $ZoneName = "orc hill"
    $ZoneSource = "$Here\objects\OrcHill.png"
    $ZoneLvl = 5
    $ZoneZEM = 20
    $ZoneLable1 = "Orc Hill"
    $ZoneLable2 = "Orcs from Crushbone have made camp and are gathering in number. You have a low chance of traveling through this area un noticed"
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @("orc aggro","orc legionnaire")
    $ZoneMobs = @("orc pawn","orc centurion")
    $ZonePrimary = @("sharpened sword","cracked staff")
    $ZoneSecondary = @("wooden shield","wooden shield")
    $ZoneArmor = @("patchwork armor","patchwork armor")
    $ZoneSpells = @()
    $ZoneItems = @("orc belt","rusty short sword")
    $ZoneQuests = @()
    $ZoneConnect = @("Kelethin","Crushbone Tunnel")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneGFay1{        
    $ZoneName = "greater faydark"
    $ZoneSource = "$Here\objects\GFay1.png"
    $ZoneLvl = 2
    $ZoneZEM = 10
    $ZoneLable1 = "Greater Faydark"
    $ZoneLable2 = "Wide variety of newbie mobs to level up on."
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @()
    $ZoneMobs = @("a snake","a bat", "a wolf", "a decaying skeleton")
    $ZonePrimary = @()
    $ZoneSecondary = @()
    $ZoneArmor = @()
    $ZoneSpells = @()
    $ZoneItems = @()
    $ZoneQuests = @()
    $ZoneConnect = @("Kelethin","Greater Faydark trail")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneCrushboneTunnel{        
    $ZoneName = "Crushbone Tunnel"
    $ZoneSource = "$Here\objects\crushbonetunnel.png"
    $ZoneLvl = 10
    $ZoneZEM = 30
    $ZoneLable1 = "Crushbone Tunnel"
    $ZoneLable2 = "Entrance to the orc stronghold of Crushbone. You have a low chance of traveling through this area un noticed"
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @("orc aggro","orc legionnaire")
    $ZoneMobs = @("orc centurion","orc legionnaire")
    $ZonePrimary = @("sharpened sword","cracked staff")
    $ZoneSecondary = @("wooden shield","wooden shield")
    $ZoneArmor = @("patchwork armor","patchwork armor")
    $ZoneSpells = @()
    $ZoneItems = @("orc belt","rusty short sword")
    $ZoneQuests = @()
    $ZoneConnect = @("Orc Hill","Crushbone")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneGFayTrail{        
    $ZoneName = "greater faydark trail"
    $ZoneSource = "$Here\objects\GFay2.png"
    $ZoneLvl = 5
    $ZoneZEM = 20
    $ZoneLable1 = "Greater Faydark trail"
    $ZoneLable2 = "Travel quickly or a bandit may notice you"
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @()
    $ZoneMobs = @("orc pawn", "a wolf", "a decaying skeleton")
    $ZonePrimary = @()
    $ZoneSecondary = @()
    $ZoneArmor = @()
    $ZoneSpells = @()
    $ZoneItems = @()
    $ZoneQuests = @()
    $ZoneConnect = @("Greater Faydark","Felwithe")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

Function ZoneGFaySpires{        
    $ZoneName = "GFaySpires"
    $ZoneSource = "$Here\objects\gfaySpires.png"
    $ZoneLvl = 5
    $ZoneZEM = 20
    $ZoneLable1 = "Greater Faydark Spires"
    $ZoneLable2 = "Ancient spires . You have a chance of traveling through this area un noticed"
    $ZoneLable3 = " "
    $ZoneMessageColor = "White"
    $ZoneEvents = @()
    $ZoneMobs = @("a bandit","orc pawn", "a decaying skeleton")
    $ZonePrimary = @("sharpened sword","cracked staff")
    $ZoneSecondary = @("wooden shield","wooden shield")
    $ZoneArmor = @("patchwork armor","patchwork armor")
    $ZoneSpells = @()
    $ZoneItems = @("orc belt","rusty short sword")
    $ZoneQuests = @()
    $ZoneConnect = @("Felwithe","GFay2")

    $Zone.Name = $ZoneName
    $Zone.Source = $ZoneSource
    $Zone.Lvl = $ZoneLvl
    $Zone.ZEM = $ZoneZEM
    $Zone.Lable1 = $ZoneLable1
    $Zone.Lable2 = $ZoneLable2
    $Zone.Lable3 = $ZoneLable3
    $Zone.MessageColor = $ZoneMessageColor
    $Zone.Events = $ZoneEvents
    $Zone.Mobs = $ZoneMobs
    $Zone.Primary = $ZonePrimary
    $Zone.Secondary = $ZoneSecondary
    $Zone.Armor = $ZoneArmor
    $Zone.Spells = $ZoneSpells
    $Zone.Items = $ZoneItems
    $Zone.Quests = $ZoneQuests
    $Zone.Connect = $ZoneConnect
}

#endregion Zones

#region Combat

Function MobAttack{
    $Mob.IsActive = "true"
    $MobName = $Mob.Name 
    $MobLvl = $Mob.Lvl
    $MobHP = $Mob.HP
    $CurrentMob = $Mob.Name
    $WPFlabelMLvl.Content = "Level  " + "$MobLvl"
    $WPFlabelMHP.Content = "HP  " + "$MobHP"
    $WPFlabelMName.Content = $MobName
    Log "$CurrentMob attacks you!"
    $HitChance = (Get-Random -Minimum 1 -Maximum 100)
    If($HitChance -gt 40){
        $AtkDmg = (Get-Random -Minimum 1 -Maximum ($Mob.Dmg * 2))
        RedLog "$CurrentMob hits you for $AtkDmg damage!"
        $Player.HP = ($Player.HP - $AtkDmg)
    }
    Else{Log "You dodge the attack."}  
      
    Log "$CurrentMob makes a second attack!"
    $HitChance = (Get-Random -Minimum 1 -Maximum 100)
    If($HitChance -gt 40){
        $AtkDmg = (Get-Random -Minimum 1 -Maximum ($Mob.Dmg * 2))
        RedLog "$CurrentMob hits you for $AtkDmg damage!"
        $Player.HP = ($Player.HP - $AtkDmg)
    }
    Else{Log "You dodge the attack."}
    $MobHP = $Mob.HP
    Log "$CurrentMob has $MobHP hit points" 

    UpdateHealthBars

    If($Player.HP -lt 1){
        $WPFtextBoxLable1.Text = "You have died to $MobName !"
        $WPFtextBoxLable2.Text = "You will now respawn at your bind point"
        $WPFlabelMessage.Content = "zoning please wait..."
        RedLog "You have died to $MobName!"
        RedLog "You have lost xp"
        Log "zoning please wait..."
        Start-Sleep -Seconds 5
        ZeroHP
    }
}

Function PlayerAttack{
    $Mob.IsActive = "true"
    $MobName = $Mob.Name 
    $MobLvl = $Mob.Lvl
    $MobHP = $Mob.HP
    $CurrentMob = $Mob.Name
    $WPFlabelMLvl.Content = "Level  " + "$MobLvl"
    $WPFlabelMHP.Content = "HP  " + "$MobHP"
    $WPFlabelMName.Content = $MobName
    Log "You attack $CurrentMob!"
    $HitChance = (Get-Random -Minimum 1 -Maximum 100)
    If($HitChance -gt 40){
        $AtkDmg = (Get-Random -Minimum 1 -Maximum ($Player.Dmg * 2))
        Log "You hit $CurrentMob for $AtkDmg damage!"
        $Mob.HP = ($Mob.HP - $AtkDmg)
    }
    Else{Log "You miss your attack."}  
      
    Log "You make a second attack..."
    $HitChance = (Get-Random -Minimum 1 -Maximum 100)
    If($HitChance -gt 40){
        $AtkDmg = (Get-Random -Minimum 1 -Maximum ($Player.Dmg * 2))
        Log "You hit $CurrentMob for $AtkDmg damage!"
        $Mob.HP = ($Mob.HP - $AtkDmg)
    }
    Else{Log "You miss your attack."}

    $UpdatedMobHP = $Mob.HP
    $WPFlabelMHP.Content = "HP  " + "$UpdatedMobHP"

    If($Mob.HP -lt 1){LootMob}
    Else{MobAttack}
}

Function Attack{
    $CurrentMob = $Mob.Name  
    If($CurrentMob -eq "mob"){Log "You dont see any thing to Attack"}
    Else{PlayerAttack}   
}

Function PlayerRunAway{
    $CurrentMob = $Mob.Name
    Log "You try to out run $CurrentMob..."
    $GetAwayChance = (Get-Random -Minimum 1 -Maximum 100)
    If($GetAwayChance -gt 40){
        $Mob.IsActive = "false"
        Log "$CurrentMob has lost sight of you."
        Log "You feel lucky to get way, its probably best to leave this zone"
    }
    Else{Log "You have stayed out of range of $CurrentMob, but still have aggro"}  
}

Function RunAway{
    $HaveAggro = $Mob.IsActive 
    If($HaveAggro -eq "false"){Log "You dont see any thing to run away from"}
    Else{PlayerRunAway}
}

Function ZeroHP{
    RedLog "You have run out of hit points"
    $Player.Quest = " "
    $Player.Zone = 6
    $Player.NZone = 6
    $Player.QZone = 0
    $Player.HP = 20
    $Player.Mana = 10
    EndTurn
}

Function GainXP{
    $CurrentLvl = $Player.Lvl
    $CurrentHP = $Player.MaxHP
    $CurrentHP2 = $Player.HP
    $CurrentMana = $Player.MaxMana
    $CurrentMana2 = $Player.Mana
    $CurrentDmg = $Player.Dmg

    $PlayDing.playsync()

    If($CurrentLvl -lt 6){
        $NewLvl = ($CurrentLvl + 1)
        $NewHP = ($CurrentHP + 20)
        $NewHP2 = ($CurrentHP2 + 20)
        $NewMana = ($CurrentMana + 20)
        $NewMana2 = ($CurrentMana2 + 20)
        
        $NewDmg = ($CurrentDmg + 3)       
        GreenLog "DING!"
        $Player.Lvl = $NewLvl
        $Player.MaxHP = $NewHP
        $Player.HP = $NewHP2
        $Player.MaxMana = $NewMana
        $Player.Mana = $NewMana2
        $Player.Dmg = $NewDmg
        If($Player.HP -gt $Player.MaxHP){$Player.HP = $Player.MaxHP}
        If($Player.Mana -gt $Player.MaxMana){$Player.Mana = $Player.MaxMana}
    }
    UpdateHealthBars
}

Function MobDies{
    #function no longer used
    $LootedMobName = $Mob.Name
    $LootedMobName2 = "$LootedMobName" + "2";
    #$WPFimageMob.Visibility = "Hidden"
    #$Mob.Source = "$Here\objects\"+ $LootedMobName.replace(' ','') + "2" + ".png"
    #$NewMobSource = "$Here\objects\"+ $LootedMobName.replace(' ','') + "2" + ".png"
    $NewMobSource = "$Here\objects\"+ $LootedMobName2.replace(' ','') + ".png"
    $Mob.Source = $NewMobSource
    $WPFimageMob.Source = $NewMobSource
    $WPFimageMob.Visibility = "Visible" 
    Log "$NewMobSource"
    LootMob
}

Function LootMob{
    #$WPFimageMob.Visibility = "Hidden"
    #$WPFimageMob.Visibility = "hidden"
    #$WPFlabelMobName.Content = " "
    #MobDies

    $LootedMobName = $Mob.Name
    $LootedMobName2 = "$LootedMobName" + "2";
    #$WPFimageMob.Visibility = "Hidden"
    #$Mob.Source = "$Here\objects\"+ $LootedMobName.replace(' ','') + "2" + ".png"
    #$NewMobSource = "$Here\objects\"+ $LootedMobName.replace(' ','') + "2" + ".png"
    $NewMobSource = "$Here\objects\"+ $LootedMobName2.replace(' ','') + ".png"
    $Mob.Source = $NewMobSource
    $WPFimageMob.Source = $NewMobSource
    $WPFimageMob.Visibility = "Visible" 
    #Log "$NewMobSource"
    $LootedMobName = $Mob.Name
    $MobCount = $Player.QCount  
    
    Log "$LootedMobName dies"
    $ButtonType = [System.Windows.MessageBoxButton]::YesNo
    $MessageboxTitle = “$LootedMobName has died!”
    $Messageboxbody = “Do you want to loot items from $LootedMobName ?”
    $MessageIcon = [System.Windows.MessageBoxImage]::Question
    $ChooseToLoot = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
    If($ChooseToLoot -eq "Yes"){
        $NewItem = $Mob.Loot
        If(!($NewItem -eq $Null)){
            Log "You looted $NewItem"
            $Player.Inv += $NewItem
        }
        Else{Log "$LootedMobName didn't have any items to loot."}
    }
    GainXP
    
    If($CurrentZone -eq $QuestZone -and $MobCount -gt 0){
        $QuestName = $Player.Quest
        $QuestMob = $QuestName.Split(" ")[-1]
        If($LootedMobName -clike "orc*"){$LootedMobName = "orcs"}
        If($LootedMobName -clike $QuestMob){
            $MobCount--
            $Player.QCount = $MobCount
            $WPFlabelMessage.Content = "You killed a quest mob!"
            $NewCount = $Player.QCount  
            $WPFlabelMessage.Content = "Quest: You need to kill $NewCount more $QuestMob" 
        }
        $WPFlabelMessage.Content = "Quest: You need to kill $MobCount more $QuestMob"  
    }  


    $CashDrop = (Get-Random -Minimum 1 -Maximum $Mob.Plat)
    Log "You looted $CashDrop pp"
    $Player.Plat = ($Player.Plat + $CashDrop)
    $NewTotal = $Player.Plat
    Log "You now have a total of $NewTotal pp"

    $Mob.IsActive = "false"
    $Mob.Name = "mob"
    $WPFimageMob.Visibility = "hidden"
    $WPFlabelMobName.Content = " "
    $WPFlabelMobName.Visibility = "hidden"
    CheckQuest
}

Function Encounter{
    #function no longer used
    $WPFimageMob.Source = $Mob.Source  
    $WPFbuttonAttack.visibility = "visible"
    $WPFbuttonRun.visibility = "visible"
    $WPFimageMob.visibility = "visible"
    $PLoc = 307
    $PMove="$PLoc,147,0,0"
    $WPFImageTux.Margin=$PMove

    $WPFlabelMName.content = $Mob.Name
    $WPFlabelMLvl.content = "Level: "+$Mob.Lvl
    $WPFlabelMHP.content = "HP: "+$Mob.HP
    
}

#endregion Combat

#region Spells

Function SpellBook{
    $SpellBookOpen = $WPFimageSpellBook.Visibility
    If($SpellBookOpen -eq "Visible"){
        $WPFimageSpellBook.Visibility = "Hidden"
        $WPFimageSPellBookSpell1.Visibility = "Hidden"    
    }
    Else{
        $WPFimageSpellBook.Visibility = "Visible"
        $WPFimageSPellBookSpell1.Visibility = "Visible"
    } 
}

Function Spell1{
    $SpellManaNeeded = 10
    $CurrentMana = $Player.Mana
    If($CurrentMana -gt $SpellManaNeeded){
        Log "You begin casting a spell..."
        Log "You are healed for 30 hit points"
        $CurrentHP = $Player.HP
        $NewHP = ($CurrentHP + 30)
        $NewMana = ($CurrentMana - 10)
        $Player.HP = $NewHP
        $Player.Mana = $NewMana
        If($Player.HP -gt $Player.MaxHP){$Player.HP = $Player.MaxHP}
        UpdateHealthBars
    }
    Else{Log "You do not have enough mana to cast this spell"}
}

Function Spell2{Log "feature coming soon"}

Function Spell3{Log "feature coming soon"}

Function Spell4{Log "feature coming soon"}

Function Spell5{Log "feature coming soon"}

Function Spell6{Log "feature coming soon"}

Function Spell7{Log "feature coming soon"}

Function Spell8{Log "feature coming soon"}

#endregion Spells

#region Quests

Function JobBoardUpdated{
    $QuestOpen = $WPFimageQuestJournal.Visibility
    If($QuestOpen -eq "Visible"){
        $WPFbuttonQuest1.content = " "
        $WPFbuttonQuest2.content = " "
        $WPFimageQuestJournal.Visibility = "Hidden"
        $WPFbuttonChooseQuest.Visibility = "Hidden"
        $WPFbuttonCloseQuestJournal.Visibility = "Hidden"
        $WPFbuttonQuest1.Visibility = "Hidden"
        $WPFbuttonQuest2.Visibility = "Hidden"
        $WPFtextblockQuestDetails.Visibility = "Hidden"
        #hide lables and images for inventory    
    }
    Else{
        $WPFimageQuestJournal.Visibility = "Visible"
        $WPFbuttonChooseQuest.Visibility = "Visible"
        $WPFbuttonCloseQuestJournal.Visibility = "Visible"
        $WPFbuttonQuest1.Visibility = "Visible"
        $WPFbuttonQuest2.Visibility = "Visible"
        $WPFtextblockQuestDetails.Visibility = "Visible"

        If(!($Player.Quest -eq " ")){Log "You already have a quest. Are you sure you want to abandon it?"}
        If($Zone.Quests.Count -eq 0){Log "You dont see any job boards around here."}   
        Else{
            Log "Welcome to the Job Board. Popular areas may have available quest to choose from."
            Log "You can have one quest at a time"
            Log "Choose a quest and click OK"
            $FirstQuest = $Zone.Quests[0]
            $SecondQuest = $Zone.Quests[1]
            $WPFbuttonQuest1.content = $FirstQuest
            $WPFbuttonQuest2.content = $SecondQuest
        }

    } 
}

Function JobBoard{
    #no longer used function
    If(!($Player.Quest -eq " ")){Log "You already have a quest. Are you sure you want to abandon it?"}
    If($Zone.Quests.Count -eq 0){Log "You dont see any job boards around here."}   
    Else{
        Log "Welcome to the Job Board. Popular areas may have available quest to choose from."
        Log "You can have one quest at a time"
        Log "Choose a quest and click OK"
        $ChooseQuest = $Zone.Quests | Out-GridView -PassThru
        Log "You have choosen $ChooseQuest"
        Switch ($ChooseQuest)
        {
            "Deliver shipment to Felwithe" {$Player.Quest = $ChooseQuest;NewQuest;}
            "Deliver shipment to Kelethin" {$Player.Quest = $ChooseQuest;NewQuest;}
            "Thin out the orcs" {$Player.Quest = $ChooseQuest;$Player.QCount = 2;NewQuest;}
            "Greater Faydark" {$Player.NZone = 3}
            "Greater Faydark trail" {$Player.NZone = 4}
            "Crushbone Tunnel" {$Player.NZone = 5}
        }
    }    

}

Function Tavern{Log "You dont see a tavern around here"}

Function ChooseQuest{
    #$ChooseQuest = $Zone.Quests | Out-GridView -PassThru
    $ChooseQuest = $WPFtextblockQuestDetails.text   
    Log "You have choosen $ChooseQuest"
    Switch ($ChooseQuest)
    {
        "Deliver shipment to Felwithe" {$Player.Quest = $ChooseQuest;NewQuest;}
        "Deliver shipment to Kelethin" {$Player.Quest = $ChooseQuest;NewQuest;}
        "Thin out the orcs" {$Player.Quest = $ChooseQuest;$Player.QCount = 2;NewQuest;}
        "Greater Faydark" {$Player.NZone = 3}
        "Greater Faydark trail" {$Player.NZone = 4}
        "Crushbone Tunnel" {$Player.NZone = 5}
    }
    JobBoardUpdated
}

Function CheckQuest{
    $CurrentZone = $Player.Zone
    $QuestZone = $Player.QZone 
    $NextZone = $Player.NZone
    $MobCount = $Player.QCount    
    If($QuestZone -eq "0"){
        $Player.NZone = $CurrentZone
        Log "you find yourself without a quest"
        Log "check the out Job Board or Tavern while you're here"
        Log "to explore without a quest click Choose Zone"
        $WPFlabelMessage.Content = "check the out Job Board for a quest" 
    }

    Else{
        If($CurrentZone -eq $QuestZone -and $MobCount -eq 0){CompleteQuest}
        If($CurrentZone -eq $QuestZone -and $MobCount -gt 0){
            $QuestName = $Player.Quest
            $QuestMob = $QuestName.Split(" ")[-1]
            $WPFlabelMessage.Content = "Quest: You need to kill $MobCount more $QuestMob"  
        }
        Else{
            If($CurrentZone -lt $QuestZone){$Player.Zone = ($Player.Zone + 1);$Distance = ($QuestZone - $CurrentZone);$NextZone++}
            If($CurrentZone -gt $QuestZone){$Player.Zone = ($Player.Zone - 1);$Distance = ($CurrentZone - $QuestZone);$NextZone--}
            Log "You need to follow the trail for $Distance zones"
            $Player.NZone = $NextZone
        
            Switch($NextZone)
            {
                1 {ZoneCrushboneTR;Log "the next zone on the trail is "}
                2 {ZoneCrushboneTrainer;Log "the next zone on the trail is "}
                3 {ZoneCrushboneENT;Log "the next zone on the trail is "}
                4 {Log "the next zone on the trail is the Crushbone Tunnel";$WPFlabelMessage.Content = "the next zone on the trail is the Crushbone Tunnel"}
                5 {Log "the next zone on the trail is Orc Hill";$WPFlabelMessage.Content = "the next zone on the trail is Orc Hill"}
                6 {Log "the next zone on the trail is the wood elf city of Kelethin";$WPFlabelMessage.Content = "the next zone on the trail is the wood elf city of Kelethin"}
                7 {Log "the next zone on the trail is the Greater Faydark";$WPFlabelMessage.Content = "the next zone on the trail is the Greater Faydark"} 
                8 {ZoneGFayTrail;Log "the next zone on the trail is the Greater Faydark Trail";$WPFlabelMessage.Content = "the next zone on the trail is the Greater Faydark Trail"}
                9 {Log "the next zone on the trail is high elf city Felwithe";$WPFlabelMessage.Content = "the next zone on the trail is high elf city Felwithe"}
                10 {ZoneGFaySpires;Log "the next zone on the trail is "} #add LFay with zones 20-25 ish
                11 {ZoneGFay2;Log "the next zone on the trail is "}
                12 {ZoneBB1;Log "the next zone on the trail is "}
                13 {ZoneBBCrossRoads;Log "the next zone on the trail is "} #add trail to unrest zones 25-30ish
                14 {ZoneBB2;Log "the next zone on the trail is "}
                15 {ZoneKaladin;Log "the next zone on the trail is "}
                16 {ZoneBB3;Log "the next zone on the trail is "}
                17 {ZoneBBDocks;Log "the next zone on the trail is "}
                #ship to freeport 31-35ish
                default {Log "ERROR: unknown zone number"}
            }
            Log "Click END TURN to follow the trail" 
        }      
    }
}

Function CompleteQuest{
    GainXP
    $CompletedQuest = $Player.Quest
    $Player.QZone = 0
    $Player.Quest = " "
    GreenLog "You have completed the quest $CompletedQuest!"
    $WPFlabelMessage.Content = "You have completed the quest $CompletedQuest!" 
    Log "You gained exp!"
    Log "You no longer have an active quest."
    Log "visit a job board or a tavern to find another quest" 
    Log "You can also choose to travel to a connecting zone"
}

Function NewQuest{
    $QuestName = $Player.Quest
    $NextZone = $Player.Zone
    $Player.NZone = $NextZone
    $QuestType = $QuestName.Split(" ")[0]
    $QuestLoc = $QuestName.Split(" ")[-1]
    If($QuestType -eq "Deliver"){
        Switch ($QuestLoc)
        {
            "Felwithe" {$Player.QZone = 9}
            "Kelethin" {$Player.QZone = 6}
            "Kaladin" {$Player.Zone = 15}
            "Docks" {$Player.Zone = 17}
            Default {Log "ERROR - Unable to set player quest zone"}
        }
        $WPFlabelMessage.Content = "When you End Turn, You'll follow the trail to $QuestLoc"    
    }
    If($QuestType -eq "Thin"){
        Switch ($QuestLoc)
        {
            "orcs" {$Player.QZone = 5;$QuestLoc = "Orc Hill"}
            Default {Log "ERROR - Unable to set player quest zone"}
        }
        $WPFlabelMessage.Content = "When you End Turn, You'll follow the trail to $QuestLoc"    
    }
    
    CheckQuest
}

Function DeliverQuest{
    $QuestName = $Player.Quest
    $QuestType = $QuestName.Split(" ")[0]
    #add logic for quests
    #add way to keep track of trail to quest loc 
    #say how far away quest loc is - 3 zones away
    $QuestLoc = $QuestName.Split(" ")[-1]
    Log "Deliver the quest item to $QuestLoc"
    #add quest item to inventory
        
}

Function Quest1{
    $ChooseQuest = $WPFbuttonQuest1.content
    $WPFtextblockQuestDetails.text = $ChooseQuest
}

Function Quest2{
    $ChooseQuest = $WPFbuttonQuest2.content
    $WPFtextblockQuestDetails.text = $ChooseQuest
}

#endregion Quests

#region World Turn

Function WorldTurn{
    YellowLog "Starting World Turn..."
    If($MapActive -eq $true){MapSpawnMobs}
    ProgressBar
    $MobActive = $Mob.IsActive
    If($MobActive -eq "true"){MobAttack}
    Else{
        $SpawnChance = (Get-Random -Minimum 1 -Maximum 100)
        If($SpawnChance -gt 1){MobSpawn}
        Else{YellowLog "spawn chance $SpawnChance"}   
    }
    YellowLog "World Turn Ended"
}

Function MobSpawn{
    $Mobs = $Zone.Mobs
    $RandomMob = Get-Random $Mobs
    If(!($RandomMob  -eq $null)){
        $PossibleItems = $Zone.Items
        $Loot = (Get-Random $PossibleItems)
        $Mob.Name = $RandomMob
        $Mob.Lvl = $Zone.Lvl
        $Mob.Hp = ($Zone.Lvl * 3)
        $Mob.Dmg = ($Zone.Lvl * 2)
        $Mob.Plat = $Zone.Lvl
        $Mob.Source = "$Here\objects\"+ $RandomMob.replace(' ','') + ".png"
        $Mob.Loot = $Loot
        
        $WPFimageMob.Source = $Mob.Source
        $WPFimageMob.Visibility = "Visible"
        $WPFlabelMobName.Content = $Mob.Name
        $WPFlabelMobName.Visibility = "Visible"
        $MobName = $Mob.Name 
        $MobLvl = $Mob.Lvl
        $MobHP = $Mob.HP
        Log "You encounter $MobName"
        $WPFlabelMLvl.Content = "Level  " + "$MobLvl"
        $WPFlabelMHP.Content = "HP  " + "$MobHP"
        $WPFlabelMName.Content = $MobName
        $AggroChance = (Get-Random -Minimum 1 -Maximum 10)
        If($AggroChance -gt 4){MobAttack}
        Else{Log "$MobName hasn't seen you. You could travel to your next zone without attacking."}
    }
    Else{#Log "You dont see mobs around"
    }
}

Function MobTurn{
    #if mob name is mob 
        #load a new mob
        #if zone doesn't have mobs then leave mob name mob    
    #else 
        #there is a current mob
    #mob attack

    #function mob attack
        #if mob name is mob skip
        #else do attack logic


    
    $CurrentMob = $Mob.Name
    Log "Current Mob is $CurrentMob"
    If($CurrentMob -eq "mob"){
        $Mobs = $Zone.Mobs
        $RandomMob = Get-Random $Mobs
        Log "mob is $RandomMob"

        If(!$RandomMob  -eq $null){
            $PossibleItems = $Zone.Items
            $Loot = (Get-Random $PossibleItems)
            $Mob.Name = $RandomMob
            $Mob.Lvl = $Zone.Lvl
            $Mob.Hp = ($Zone.Lvl * 3)
            $Mob.Dmg = ($Zone.Lvl * 1.5)
            $Mob.Plat = $Zone.Lvl
            $Mob.Source = "$Here\objects\"+ $RandomMob.replace(' ','') + ".png"
            $Mob.Loot = $Loot
        
            $WPFimageMob.Source = $Mob.Source
            $WPFimageMob.Visibility = "Visible"
            $WPFlabelMobName.Content = $Mob.Name
            $WPFlabelMobName.Visibility = "Visible"
            Log "You encounter $Mob.Name."
        If((Get-Random -Minimum 1 -Maximum 10) -gt 5){
            Log "$CurrentMob attacks you!"
            If((Get-Random -Minimum 1 -Maximum 10) -gt 5){
                $AtkDmg = (Get-Random $Mob.Dmg)
                Log "$CurrentMob hits you for $AtkDmg damage!"
                $Player.HP = ($Player.HP - $AtkDmg)
            }
            Else{Log "You dodge the attack."}    
            Log "$CurrentMob makes a second attack!"
            If((Get-Random -Minimum 1 -Maximum 10) -gt 6){
                $AtkDmg = (Get-Random $Mob.Dmg)
                Log "$CurrentMob hits you for $AtkDmg damage!"
                $Player.HP = ($Player.HP - $AtkDmg)
            }
            Else{Log "You dodge the attack."}
            If($Player.HP -lt 1){ZeroHP}
        }
        Else{Log "$CurrentMob hasnt seen you."}
        }          
    }
    Else{
        Log "You have aggro of $CurrentMob"
        Log "$CurrentMob attacks you!"
        If((Get-Random -Minimum 1 -Maximum 10) -gt 5){
            $AtkDmg = (Get-Random $Mob.Dmg)
            Log "$CurrentMob hits you for $AtkDmg damage!"
            $Player.HP = ($Player.HP - $AtkDmg)
        }
        Else{Log "You dodge the attack."}    
        Log "$CurrentMob makes a second attack!"
        If((Get-Random -Minimum 1 -Maximum 10) -gt 5){
            $AtkDmg = (Get-Random $Mob.Dmg)
            Log "$CurrentMob hits you for $AtkDmg damage!"
            $Player.HP = ($Player.HP - $AtkDmg)
        }
        Else{Log "You dodge the attack."}
        If($Player.HP -lt 1){ZeroHP}     
    }
}

#endregion World Turn

#region Player Navigation

Function EnterZone{
    $Mob.IsActive = "false"
    $Mob.Name = "mob"
    $WPFlabelMLvl.Content = " "
    $WPFlabelMHP.Content = " "
    $WPFlabelMName.Content = " "
    $WPFimageMob.Visibility = "hidden"
    $WPFlabelMobName.Content = " "
    $WPFlabelMobName.Visibility = "hidden"    

    $PlayerZone = $Player.NZone 
    Log "Zoning please wait..."
    Switch($PlayerZone)
    {
        1 {ZoneCrushboneTR}
        2 {ZoneCrushboneTrainer}
        3 {ZoneCrushboneENT}
        4 {ZoneCrushboneTunnel}
        5 {ZoneOrcHill}
        6 {ZoneKelethin}
        7 {ZoneGFay1}
        8 {ZoneGFayTrail}
        9 {ZoneFelwithe}
        10 {ZoneGFaySpires} #add LFay with zones 20-25 ish
        11 {ZoneGFay2}
        12 {ZoneBB1}
        13 {ZoneBBCrossRoads} #add trail to unrest zones 25-30ish
        14 {ZoneBB2}
        15 {ZoneKaladin}
        16 {ZoneBB3}
        17 {ZoneBBDocks}
        #ship to freeport 31-35ish
        default {Log "ERROR: Unknown zone number"}
    }
    $Zonesource = $Zone.source
    $WPFimageWindow.source = $Zonesource
    $WPFtextBoxLable1.Text = $Zone.Lable1
    $WPFtextBoxLable2.Text = $Zone.Lable2
    $WPFlabelMessage.Content = $Zone.Lable3
    $WPFlabelMessage.Foreground = $Zone.MessageColor
    $ZoneName = $Zone.Name
    $ZoneLvl = $Zone.Lvl
    $ZoneZEM = $Zone.ZEM

    Log "Entering $ZoneName"
    Log "Mob lvl> $ZoneLvl"
    Log "Exp mod> $ZoneZEM"
    
    UpdateHealthBars
    WorldTurn
    CheckQuest
    
    Log "Your Turn"
}

Function ChooseZone{
    Log "Choose which zone you want to travel to and click OK"
    $NextZone = $Zone.Connect | Out-GridView -PassThru
    Log "Your next zone will be $NextZone"
    Log "Click END TURN to follow the trail to $NextZone"
    Switch ($NextZone)
    {
        "Kelethin" {$Player.NZone = 6;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Orc Hill" {$Player.NZone = 5;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Greater Faydark" {$Player.NZone = 7;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Greater Faydark trail" {$Player.NZone = 8;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Felwithe" {$Player.NZone = 9;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Greater Faydark Spires" {$Player.NZone = 10;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
        "Crushbone Tunnel" {$Player.NZone = 4;$WPFlabelMessage.Content = "When you End Turn, You'll travel to $NextZone"}
    }
}

Function WaitHere{
    $CurrentZone = $Zone.Name
    Log "Choosing to stay in current zone, $CurrentZone"
    Log "Ended Turn"
    $CurrentHP = $Player.HP
    $MaxHP = $Player.MaxHP
    If($CurrentHP -lt $MaxHP){
        $CurrentHP = $CurrentHP + 8
        $Player.HP = $CurrentHP

        Log "You have rested for 4 hit points"
        UpdateHealthBars
    }
    $CurrentHP = $Player.HP
    $MaxHP = $Player.MaxHP
    If($CurrentHP -gt $MaxHP){$Player.HP = $MaxHP}
    $CurrentHP = $Player.HP
    $MaxHP = $Player.MaxHP
    Log "You have $CurrentHp out of $MaxHP hit points"
    $CurrentMana = $Player.Mana
    $MaxMana = $Player.MaxMana
    If($CurrentMana -lt $MaxMana){
        $CurrentMana = $CurrentMana + 8
        $Player.Mana = $CurrentMana

        Log "You have rested for 4 mana points"
        UpdateHealthBars
    }
    $CurrentMana = $Player.Mana
    $MaxMana = $Player.MaxMana
    If($CurrentMana -gt $MaxMana){$Player.Mana = $MaxMana}
    $CurrentMana = $Player.Mana
    $MaxMana = $Player.MaxMana
    Log "You have $CurrentMana out of $MaxMana mana"
    WorldTurn
}

Function EndTurn{
    Log "Ended Turn"
    #check if current zone is also next zone
    #say something implying cpu turn
    EnterZone
}

Function ZoneList{
    #this function is not used
    $PlayerZone = $Player.Zone 
    Switch($PlayerZone)
    {
        1 {ZoneCrushboneTR}
        2 {ZoneCrushboneTrainer}
        3 {ZoneCrushboneENT}
        4 {ZoneCrushboneTunnel}
        5 {ZoneOrcHill}
        6 {ZoneKelethin}
        7 {ZoneGFay1}
        8 {ZoneGFayTrail}
        9 {ZoneFelwithe}
        10 {ZoneGFaySpires} #add LFay with zones 20-25 ish
        11 {ZoneGFay2}
        12 {ZoneBB1}
        13 {ZoneBBCrossRoads} #add trail to unrest zones 25-30ish
        14 {ZoneBB2}
        15 {ZoneKaladin}
        16 {ZoneBB3}
        17 {ZoneBBDocks}
        #ship to freeport 31-35ish
        default {Log "ERROR: Unknown zone number"}
    }
}

Function Bank{Log "You dont see a bank around here"}

Function Shop{Log "You dont see a merchant around here"}

Function Guild{Log "You dont see a relavant guild master around here"}

Function Camp{Log "Help feature coming soon"}

#endregion Player Navigation

#region UI and start World

Function Splash{
    #function not used 
    $inputXML = @"
<Window x:Class="FaydarkTrail.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:FaydarkTrail"
        mc:Ignorable="d"
        Title="FaydarkTrail" Height="636" Width="810" ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
    <Grid>
        <Image x:Name="image" HorizontalAlignment="Left" Height="605" VerticalAlignment="Top" Width="802" Source="$Here\splash.png"/>
    </Grid>
</Window>
        
"@  

    $inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML
    #Read XAML
    
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
    try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
    catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."} 
 
    $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
    
    $Form.ShowDialog() | out-null
    }

Function Log{
    param([string]$text)
    Write-Host $text
    Try
    {        
        $WPFtextBoxOutput.text += "`n$text"
        $WPFtextBoxOutput.ScrolltoCaret
        $WPFtextBoxOutput.ScrollToEnd()
    }
    Catch
    {

    }
}

Function RedLog{
    param([string]$text)
    Write-Host $text -ForegroundColor Red
    Try
    {        
        $WPFtextBoxOutput.text += "`n$text"
        $WPFtextBoxOutput.ScrolltoCaret
        $WPFtextBoxOutput.ScrollToEnd()
    }
    Catch
    {

    }
}

Function GreenLog{
    param([string]$text)
    Write-Host $text -ForegroundColor Green
    Try
    {        
        $WPFtextBoxOutput.text += "`n$text"
        $WPFtextBoxOutput.ScrolltoCaret
        $WPFtextBoxOutput.ScrollToEnd()
    }
    Catch
    {

    }
}

Function YellowLog{
    param([string]$text)
    Write-Host "     $text" -ForegroundColor Yellow
    Try
    {        
        $WPFtextBoxOutput.text += "`n$text"
        $WPFtextBoxOutput.ScrolltoCaret
        $WPFtextBoxOutput.ScrollToEnd()
    }
    Catch
    {

    }    
}

Function UpdateHealthBars{
    $CurrentHP = $Player.HP
    $MaxHP = $Player.MaxHP
    #Log "You have $CurrentHp out of $MaxHP hit points"
    $HPPercent = ($CurrentHP/$MaxHP)
    Switch($HPPercent)
    {
        {($HPPercent -ge .96)}  {$WPFimageHP.Source="$Here\objects\HPFull.png"}
        {($HPPercent -ge .81 -and $HPPercent -le .95)}  {$WPFimageHP.Source = "$Here\objects\HP80.png";}
        {($HPPercent -ge .61 -and $HPPercent -le .80)}  {$WPFimageHP.Source = "$Here\objects\HP60.png";}
        {($HPPercent -ge .41 -and $HPPercent -le .60)}  {$WPFimageHP.Source = "$Here\objects\HP40.png";}
        {($HPPercent -ge .21 -and $HPPercent -le .40)}  {$WPFimageHP.Source = "$Here\objects\HP20.png";}
        {($HPPercent -ge 0 -and $HPPercent -le .20)} {$WPFimageHP.Source="$Here\objects\HP0.png"}
        default {Log "ERROR could not update health bar"}
    }

    $Mana = $Player.Mana
    $MaxMana = $Player.MaxMana
    #Log "You have $Mana out of $MaxMana mana"
    $ManaPercent = ($Mana/$MaxMana)
    Switch($ManaPercent)
    {
        {($ManaPercent -ge .96)} {$WPFimageMana.Source="$Here\objects\ManaFull.png"}
        {($ManaPercent -ge .81 -and $ManaPercent -le .95)} {$WPFimageMana.Source="$Here\objects\Mana80.png"}
        {($ManaPercent -ge .61 -and $ManaPercent -le .80)} {$WPFimageMana.Source="$Here\objects\Mana60.png"}
        {($ManaPercent -ge .41 -and $ManaPercent -le .60)} {$WPFimageMana.Source="$Here\objects\Mana40.png"}
        {($ManaPercent -ge .21 -and $ManaPercent -le .40)} {$WPFimageMana.Source="$Here\objects\Mana20.png"}
        {($ManaPercent -ge 0 -and $ManaPercent -le .20)} {$WPFimageMana.Source="$Here\objects\Mana0.png"}
        default {Log "ERROR could not update mana bar"}
    }

    $WPFimageHP.ToolTip="$CurrentHP / " + "$MaxHP" 
    $WPFimageMana.ToolTip="$Mana / " + "$MaxMana" 
}

Function ProgressBar{
    $Messages="please wait...","You have gotten better at fizzling! (5)...","Have you tried Batwing Crunchies Cereal...","Dusting off Spellbooks...","almost done..."
    $Messages1="¯\_(?)_/¯","Ensuring Gnomes are still short...","ensuring everything works perfektly","DING!"    
    $ProgressBar = New-Object System.Windows.Forms.Form
	$ProgressBar.Text ="World Turn - making malicious plans..."
	$ProgressBar.Height = 100
	$ProgressBar.Width = 500
	$ProgressBar.BackColor = "LightGray"
	$ProgressBar.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
	$ProgressBar.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
	$ProgressBarLabel = New-Object System.Windows.Forms.Label
	$ProgressBarLabel.Text =$Messages | Get-Random
	$ProgressBarLabel.Left = 5
	$ProgressBarLabel.Top = 10
	$ProgressBarLabel.Width = 500 - 20
	$ProgressBarLabel.Height = 15
	$ProgressBarLabel.Font = "Tahoma"
	$ProgressBar.Controls.Add($ProgressBarLabel)
    $PB = New-Object System.Windows.Forms.ProgressBar
	$PB.Name = "PowerShellProgressBar"
	$PB.Value=50
	$PB.Style="Marquee"
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Width = 500 - 40
	$System_Drawing_Size.Height = 20
	$PB.Size = $System_Drawing_Size
	$PB.Left = 5
	$PB.Top = 40
	$ProgressBar.Controls.Add($PB)
	$ProgressBar.Show() | Out-Null
	$ProgressBar.Focus() | Out-NUll
	$ProgressBar.Refresh()
    
    For ($i=1;$i -lt 4;$i++)
        {
        If($i -eq 1)
            {$ProgressBarLabel.Text =$Messages1 | Get-Random;$PB.Value=20;$ProgressBar.Refresh();Start-Sleep -Seconds 1}
        If($i -eq 2)
            {$ProgressBarLabel.Text =$Messages | Get-Random;$PB.Value=70;$ProgressBar.Refresh();Start-Sleep -Seconds 1}
        If($i -eq 3)
            {$ProgressBarLabel.Text =$Messages1 | Get-Random;$PB.Value=90;$ProgressBar.Refresh();Start-Sleep -Seconds 1;$ProgressBar.Close()}
        }   
     }

Function Inventory{
    #$Here\objects\Persona2.png
    $InvOpen = $WPFimagePersona.Visibility
    If($InvOpen -eq "Visible"){
        $WPFimagePersona.Visibility = "Hidden"
        $WPFlabelPersonaLvl.Visibility = "Hidden"
        $WPFlabelPersonaHP.Visibility = "Hidden"
        $WPFlabelPersonaQuest.Visibility = "Hidden"
        $WPFimageMapIcon.Visibility = "Hidden"
        $WPFbuttonMap.Visibility = "Hidden"
        $WPFbuttonInvDone.Visibility = "Hidden"
        #hide lables and images for inventory    
    }
    Else{
        $CurrentHP = $Player.HP
        $MaxHP = $Player.MaxHP
        $WPFimagePersona.Visibility = "Visible"
        #show lables and images for inventory
        $WPFlabelPersonaLvl.content = $Player.Lvl
        $WPFlabelPersonaHP.content = "$CurrentHP / " + "$MaxHP"
        $WPFlabelPersonaQuest.content = "Active Quest: "+$Player.Quest
        $WPFimagePersona.Visibility = "Visible"
        $WPFlabelPersonaLvl.Visibility = "Visible"
        $WPFlabelPersonaHP.Visibility = "Visible"
        $WPFlabelPersonaQuest.Visibility = "Visible"
        $WPFimageMapIcon.Visibility = "Visible"
        $WPFbuttonMap.Visibility = "Visible"
        $WPFbuttonInvDone.Visibility = "Visible"
    } 
}

Function Potion{
    $DoseLeft = $Potion.Charges
    If($DoseLeft -gt 0){
        $NewDoseAmt = ($DoseLeft - 1)
        $NewMessage = "$NewDoseAmt dose healing potion"
        $Potion.Charges = $NewDoseAmt
        $Potion.Message = $NewMessage
        Log "You drink one dose of a healing potion"
        Log "You are healed for 30 hit points"
        Log "You now have a $NewMessage"
        $WPFimagePotion.ToolTip = "$NewMessage"
        $CurrentHP = $Player.HP
        $NewHP = ($CurrentHP + 30)
        $Player.HP = $NewHP
        If($Player.HP -gt $Player.MaxHP){$Player.HP = $Player.MaxHP}
        UpdateHealthBars
    }
    
    If($Potion.Charges -eq 0){
        #update potion image to empty bottle
        $EmptyBottle = "$Here\objects\potionEmpty.png"
        $WPFimagePotion.source = "$EmptyBottle"
        Log "Your potion bottle is empty"
    }
}

Function Help{Log "feature coming soon"}

Function EnterWorld{
    $inputXML = @"
<Window x:Class="FaydarkTrail.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:FaydarkTrail"
        mc:Ignorable="d"
        Title="FaydarkTrail" Height="636" Width="810" ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
    <Grid>
        <Image x:Name="image" HorizontalAlignment="Left" Height="605" VerticalAlignment="Top" Width="802" Source="$Here\mainui.png"/>
        <Button x:Name="buttonHelp" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="21,23,0,0" Opacity="0"/>
        <Button x:Name="buttonOptions" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="21,49,0,0" Height="23" Opacity="0"/>
        <Button x:Name="buttonInv" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="21,85,0,0" Opacity="0" ToolTip="Open and Close your inventory. Check your map."/>
        <Button x:Name="buttonSpellBook" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="75" Margin="21,326,0,0" Height="18" Opacity="0" ToolTip="Open and Close your Spell Book."/>
        <Label x:Name="labelName" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="686,23,0,0" Width="79" FontSize="16" Foreground="White" Height="29" HorizontalContentAlignment="Center" FontFamily="Times New Roman" FontWeight="Bold"/>
        <Label x:Name="labelMName" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="677,300,0,0" Width="97" FontSize="16" Foreground="White" Height="29" FontFamily="Times New Roman" FontWeight="Bold"/>
        <Label x:Name="labelMLvl" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="677,344,0,0" Width="97" Foreground="White" Height="26" FontFamily="Times New Roman" FontWeight="Bold"/>
        <Label x:Name="labelMHP" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="677,370,0,0" Width="97" Foreground="White" Height="26" FontFamily="Times New Roman" FontWeight="Bold"/>
        <Button x:Name="buttonAttack" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="117" Margin="668,416,0,0" Opacity="0" ToolTip="Attack the current mob. The mob will have a chance to attack you back."/>
        <Button x:Name="buttonRun" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="117" Margin="668,447,0,0" Opacity="0" ToolTip="Attempt to out run an aggro'd mob. If you out run the mob then you can travel to the next zone. "/>
        <Button x:Name="buttonChooseZone" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="117" Margin="668,503,0,0" Opacity="0" ToolTip="Choose a connecting zone to travel to. Use this to explore a connecting zone."/>
        <Button x:Name="buttonWaitHere" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="117" Margin="668,532,0,0" Opacity="0" ToolTip="Wait here and rest for 1 Turn. You will not travel to the next zone and instead regenerate your health and mana. You can be attacked while waiting here."/>
        <Button x:Name="buttonEndTurn" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="117" Margin="668,563,0,0" Opacity="0" ToolTip="End your Turn. If you have an active quest, you will travel to your next zone. If you are in combat, your enemy will have a turn to attack you. "/>
        <Image x:Name="imageWindow" HorizontalAlignment="Left" Height="402" VerticalAlignment="Top" Width="496" Margin="153,0,0,0" Source="$Here\objects\kelethin.png" Stretch="Fill"/>
        <Button x:Name="buttonJobBoard" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="21,410,0,0" Height="51" Opacity="0" ToolTip="Look around for a job board or quest giver."/>
        <Button x:Name="buttonBank" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="84,410,0,0" Height="51" Opacity="0" ToolTip="Look around for a bank. "/>
        <Button x:Name="buttonTavern" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="21,472,0,0" Height="51" Opacity="0" ToolTip="Look for a drink and a chance for a quest."/>
        <Button x:Name="buttonShop" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="84,472,0,0" Height="51" Opacity="0" ToolTip="Look for a merchant. Sell your loot and buy upgrades."/>
        <Button x:Name="buttonGuild" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="21,532,0,0" Height="51" Opacity="0" ToolTip="Look for your class guild master. Buy new spells."/>
        <Image x:Name="imagePotion" HorizontalAlignment="Left" Height="51" VerticalAlignment="Top" Width="47" Margin="84,532,0,0" Source="$Here\objects\potionRed.png" Stretch="Fill"/>
        <Button x:Name="buttonPotion" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="53" Margin="84,532,0,0" Height="51" Opacity="0" ToolTip="5 dose healing potion"/>
        <Image x:Name="imageSpell1" HorizontalAlignment="Left" Height="29" Margin="113,23,0,0" VerticalAlignment="Top" Width="35" Source="$Here\objects\healing.png"/>
        <Button x:Name="buttonSpell1" Content=" " HorizontalAlignment="Left" Height="29" Margin="113,23,0,0" VerticalAlignment="Top" Width="35" Opacity="0" ToolTip="Healing. Heal for 30 hit points and use 10 mana."/>
        <Button x:Name="buttonSpell2" Content=" " HorizontalAlignment="Left" Height="29" Margin="113,71,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell3" Content=" " HorizontalAlignment="Left" Height="29" Margin="113,118,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell4" Content=" " HorizontalAlignment="Left" Height="30" Margin="113,164,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell5" Content=" " HorizontalAlignment="Left" Height="30" Margin="113,212,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell6" Content=" " HorizontalAlignment="Left" Height="30" Margin="113,260,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell7" Content=" " HorizontalAlignment="Left" Height="30" Margin="113,305,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <Button x:Name="buttonSpell8" Content=" " HorizontalAlignment="Left" Height="30" Margin="113,356,0,0" VerticalAlignment="Top" Width="35" Opacity="0"/>
        <TextBox x:Name="textBoxOutput" HorizontalAlignment="Left" Height="172" TextWrapping="Wrap" Text="Entered World" VerticalAlignment="Top" Width="405" Margin="185,417,0,0" VerticalScrollBarVisibility="Visible" ScrollViewer.CanContentScroll="True" IsReadOnly="True">
            <TextBox.Background>
                <ImageBrush/>
            </TextBox.Background>
        </TextBox>

        <TextBox x:Name="textBoxLable1" HorizontalAlignment="Left" Height="42" TextWrapping="Wrap" Text=" " VerticalAlignment="Top" Width="476" Margin="162,10,0,0" IsReadOnly="True" FontSize="22" FontFamily="Segoe Print" FontWeight="Bold" Foreground="White" BorderThickness="0">
            <TextBox.Background>
                <ImageBrush/>
            </TextBox.Background>
        </TextBox>
        <TextBox x:Name="textBoxLable2" HorizontalAlignment="Left" Height="227" TextWrapping="Wrap" Text=" " VerticalAlignment="Top" Width="356" Margin="162,63,0,0" IsReadOnly="True" FontSize="16" FontFamily="Segoe Print" FontWeight="Bold" Foreground="White" BorderThickness="0">
            <TextBox.Background>
                <ImageBrush/>
            </TextBox.Background>
        </TextBox>
        <Label x:Name="labelBot1Name" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="686,155,0,0" Width="69" Foreground="White"/>
        <Label x:Name="labelBot2Name" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="686,195,0,0" Width="69" Foreground="White"/>
        <Image x:Name="imagePersona" HorizontalAlignment="Left" Height="402" VerticalAlignment="Top" Width="496" Margin="153,0,0,0" Source="$Here\objects\Persona.png" Stretch="Fill" Visibility="Hidden" />
        <Label x:Name="labelPersonaLvl" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="203,10,0,0" Width="31" FontSize="16" Foreground="#FF83808B" Height="29" FontFamily="Times New Roman" FontWeight="Bold" Visibility="Hidden"/>
        <Label x:Name="labelPersonaHP" Content="40/40" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="203,63,0,0" Width="70" FontSize="16" Foreground="#FF83808B" Height="25" FontFamily="Times New Roman" FontWeight="Bold" Visibility="Hidden"/>
        <Label x:Name="labelPersonaQuest" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="162,321,0,0" Width="326" FontSize="16" Foreground="White" Height="31" FontFamily="Times New Roman" FontWeight="Bold" Visibility="Hidden"/>
        <Image x:Name="imageMob" HorizontalAlignment="Left" Height="213" Margin="278,142,0,0" VerticalAlignment="Top" Width="271" Source="$Here\objects\asnake.png" Stretch="Fill" Visibility="Hidden"/>
        <Label x:Name="labelMobName" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="278,105,0,0" Height="32" Width="271" Foreground="#FF14BAAC" HorizontalContentAlignment="Center" FontWeight="Bold" FontFamily="Sitka Small" FontSize="18" Visibility="Hidden" />
        <Label x:Name="labelMessage" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Margin="185,360,0,0" Width="405" Foreground="White" HorizontalContentAlignment="Center"/>
        <Image x:Name="imageHP" HorizontalAlignment="Left" Height="14" VerticalAlignment="Top" Width="110" Margin="672,54,0,0" Source="$Here\objects\HPFull.png" Stretch="Fill" ToolTip=" "/>
        <Image x:Name="imageMana" HorizontalAlignment="Left" Height="14" VerticalAlignment="Top" Width="110" Margin="672,68,0,0" Source="$Here\objects\ManaFull.png" Stretch="Fill" ToolTip=" "/>
        <Image x:Name="imageMapIcon" HorizontalAlignment="Left" Height="77" VerticalAlignment="Top" Width="82" Margin="556,5,0,0" Source="$Here\objects\MapIcon.png" Stretch="None" Visibility="Hidden" ToolTip="Open your map."/>
        <Button x:Name="buttonMap" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="70" Margin="568,10,0,0" Height="62" Opacity="0" Visibility="Hidden" ToolTip="Open your Map."/>
        <Button x:Name="buttonInvDone" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="37" Margin="312,290,0,0" RenderTransformOrigin="0.2,0.95" Height="16" Opacity="0" Visibility="Hidden" ToolTip="Done"/>
        <Image x:Name="imageSpellBook" HorizontalAlignment="Left" Height="298" VerticalAlignment="Top" Width="454" Margin="184,71,0,0" Stretch="None" Source="$Here\SB.png" Visibility="Hidden"/>
        <Image x:Name="imageSPellBookSpell1" HorizontalAlignment="Left" Height="34" VerticalAlignment="Top" Width="40" Margin="252,98,0,0" Stretch="None" Source="$Here\objects\healing.png" ToolTip="Spell of Healing. Use 10 mana to gain 30 hit points. This spell does not raise your max hit points." Visibility="Hidden"/>
        <Image x:Name="imageQuestJournal" HorizontalAlignment="Left" Height="254" VerticalAlignment="Top" Width="405" Margin="194,98,0,0" Source="$Here\objects\QuestJournal.png" Stretch="None" Visibility="Hidden"/>
        <Button x:Name="buttonChooseQuest" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="105" Margin="429,226,0,0" RenderTransformOrigin="0.2,0.95" Height="29" Opacity="0" Visibility="Hidden" ToolTip="Choose selected quest"/>
        <Button x:Name="buttonCloseQuestJournal" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="105" Margin="429,271,0,0" RenderTransformOrigin="0.2,0.95" Height="35" Opacity="0" Visibility="Hidden" ToolTip="Cancel quest selection and close quest journal"/>
        <TextBlock x:Name="textblockQuestDetails" Text=" " TextWrapping="Wrap" HorizontalAlignment="Left" VerticalAlignment="Top" Margin="429,142,0,0" Visibility="Hidden" Height="80" Width="105" />
        <Button x:Name="buttonQuest1" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="166" Margin="226,155,0,0" Visibility="Hidden" Background="{x:Null}"/>
        <Button x:Name="buttonQuest2" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="166" Margin="226,195,0,0" Visibility="Hidden" Background="{x:Null}"/>


    </Grid>
</Window>
"@  

    $inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:Na",'Na'  -replace '^<Win.*', '<Window'
 
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML
    #Read XAML
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
    try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
    catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."} 
 
    $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}
    
    $WPFbuttonHelp.Add_Click({Help})
    $WPFbuttonOptions.Add_Click({Options})
    $WPFbuttonInv.Add_Click({Inventory})
    $WPFbuttonSpellBook.Add_Click({SpellBook})
    $WPFbuttonSpell1.Add_Click({Spell1})
    $WPFbuttonSpell2.Add_Click({Spell2})
    $WPFbuttonSpell3.Add_Click({Spell3})
    $WPFbuttonSpell4.Add_Click({Spell4})
    $WPFbuttonSpell5.Add_Click({Spell5})
    $WPFbuttonSpell6.Add_Click({Spell6})
    $WPFbuttonSpell7.Add_Click({Spell7})
    $WPFbuttonSpell8.Add_Click({Spell8})
    $WPFbuttonAttack.Add_Click({Attack})
    $WPFbuttonRun.Add_Click({RunAway})
    $WPFbuttonChooseZone.Add_Click({ChooseZone})
    $WPFbuttonWaitHere.Add_Click({WaitHere})
    $WPFbuttonEndTurn.Add_Click({EndTurn})
    $WPFbuttonJobBoard.Add_Click({JobBoardUpdated})
    $WPFbuttonBank.Add_Click({Bank})
    $WPFbuttonTavern.Add_Click({Tavern})
    $WPFbuttonShop.Add_Click({Shop})
    $WPFbuttonGuild.Add_Click({Guild})
    $WPFbuttonPotion.Add_Click({Potion})
    $WPFbuttonMap.Add_Click({OpenMap})
    $WPFbuttonInvDone.Add_Click({Inventory})
    $WPFlabelName.Content = $Player.Name


    $WPFbuttonChooseQuest.Add_Click({ChooseQuest})
    $WPFbuttonCloseQuestJournal.Add_Click({JobBoardUpdated})
    $WPFbuttonQuest1.Add_Click({Quest1})
    $WPFbuttonQuest2.Add_Click({Quest2})

    Log $intro
    EnterZone

    $Form.ShowDialog() | out-null
    }

#endregion UI and start World

#region Map

Function OpenMap{
    Log "Opening Map"
    
    #$script:MapActive = $true

    $inputXML = @"
<Window x:Class="Map.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:Map"
        mc:Ignorable="d"
        Title="Map" Height="700" Width="850" ResizeMode="NoResize" WindowStartupLocation="CenterScreen">
    <Grid>
        <Grid.Effect>
            <DropShadowEffect/>
        </Grid.Effect>
        <Image x:Name="imageBackground" Source="$Here\objects\Map\map.png" Stretch="Fill"/>
        <Image x:Name="imageFaydark" Source="$Here\objects\Map\FaydarkMap.png" Stretch="Fill" Margin="26,36,137,57"/>
        <Button x:Name="buttonCrushBone" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="93" Margin="400,36,0,0" Height="55" Opacity="0" ToolTip="CrushBone" />
        <Button x:Name="buttonOrcHill" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="80" Margin="447,91,0,0" Height="60" Opacity="0" ToolTip="Orc Hill" />
        <Button x:Name="buttonFelwithe" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="115" Margin="532,111,0,0" Height="81" Opacity="0" ToolTip="Felwithe" />
        <Button x:Name="buttonKelethin" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="70" Margin="423,152,0,0" Height="76" Opacity="0" ToolTip="Kelethin" />
        <Button x:Name="buttonGfay" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="70" Margin="368,111,0,0" Height="60" Opacity="0" ToolTip="Greater Faydark" />
        <Button x:Name="buttonSpires" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="90" Margin="273,132,0,0" Height="61" Opacity="0" ToolTip="Faydark Spires" />
        <Button x:Name="buttonButcherBlock" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="154" Margin="105,131,0,0" Height="62" Opacity="0" ToolTip="Butherblock Mountains" />
        <Button x:Name="buttonKaladim" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="140" Margin="85,243,0,0" Height="60" Opacity="0" ToolTip="Kaladim" />
        <Button x:Name="buttonDocks" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="120" Margin="85,193,0,0" Height="45" Opacity="0" ToolTip="Faydark Docks" />
        <Button x:Name="buttonDC" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="105,308,0,0" Height="92" Opacity="0" ToolTip="Dagnor's Cauldron" />
        <Button x:Name="buttonUnrest" Content=" " HorizontalAlignment="Left" VerticalAlignment="Top" Width="97" Margin="94,405,0,0" Height="92" Opacity="0" ToolTip="Estate of Unrest" />
        <Image x:Name="imageCrushBone" HorizontalAlignment="Left" Height="50" VerticalAlignment="Top" Width="50" Margin="423,36,0,0" Source="$Here\objects\Map\orc1.png" Visibility="Visible" />
        <Image x:Name="imageOrcHill" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="447,91,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageFelwithe" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="532,132,0,0" Height="50" Source="$Here\objects\Map\FelwitheGuard1.png" Visibility="Visible" />
        <Image x:Name="imageKelethin" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="423,152,0,0" Height="50" Source="$Here\objects\Map\KelethinGuard1.png" Visibility="Visible" />
        <Image x:Name="imageGfay" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="368,111,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageSpires" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="302,132,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageButcherBlock" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="189,131,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageKaladim" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="155,243,0,0" Height="50" Source="$Here\objects\Map\DwarfGuard1.png" Visibility="Visible" />
        <Image x:Name="imageDocks" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="105,193,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageDC" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="105,340,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Image x:Name="imageUnrest" HorizontalAlignment="Left" VerticalAlignment="Top" Width="50" Margin="105,421,0,0" Height="50" Source="$Here\objects\Map\none.png" Visibility="Visible" />
        <Button x:Name="buttonTest" Content="End Turn" HorizontalAlignment="Left" VerticalAlignment="Top" Width="78" Margin="740,593,0,0" Height="27" Background="#FF37363E" Foreground="White" ToolTip="End your Turn"/>
        <Button x:Name="buttonTestAuto" Content="Auto Turns" HorizontalAlignment="Left" VerticalAlignment="Top" Width="78" Margin="740,545,0,0" Height="27" Background="#FF37363E" Foreground="White" ToolTip="Let the Turns play out without your interference. Close Map to slow auto turns."/>
        <Button x:Name="buttonTestClose" Content="Close Map" HorizontalAlignment="Left" VerticalAlignment="Top" Width="78" Margin="740,59,0,0" Height="27" Background="#FF37363E" Foreground="White" RenderTransformOrigin="0.494,-3.593" ToolTip="Close this map"/>
        <Button x:Name="buttonTestAC" Content="Watch AC" HorizontalAlignment="Left" VerticalAlignment="Top" Width="78" Margin="740,492,0,0" Height="28" Background="#FF37363E" Foreground="White" ToolTip="Auto Turns but also watch alert console"/>
    </Grid>
</Window>


"@       
 
    $inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N'  -replace '^<Win.*', '<Window'
 
    [void][System.Reflection.Assembly]::LoadWithPartialName('presentationframework')
    [xml]$XAML = $inputXML
    #Read XAML
 
    $reader=(New-Object System.Xml.XmlNodeReader $xaml)
    try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
    catch{Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure .net is installed."}
 
    $xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}

    $WPFbuttonCrushBone.Add_Click({CrushBone})
    $WPFbuttonOrcHill.Add_Click({OrcHill})
    $WPFbuttonFelwithe.Add_Click({Felwithe})
    $WPFbuttonKelethin.Add_Click({Kelethin})
    $WPFbuttonGfay.Add_Click({Gfay})
    $WPFbuttonSpires.Add_Click({Spires})
    $WPFbuttonButcherBlock.Add_Click({ButcherBlock})
    $WPFbuttonKaladim.Add_Click({Kaladim})
    $WPFbuttonDocks.Add_Click({Docks})
    $WPFbuttonDC.Add_Click({Cauldron})
    $WPFbuttonUnrest.Add_Click({Unrest})
    $WPFbuttonTest.Add_Click({MapSpawnMobs})
    $WPFbuttonTestAuto.Add_Click({AutoMapSpawnMobs})
    $WPFbuttonTestClose.Add_Click({CloseMap})
    $WPFbuttonTestAC.Add_Click({WatchAC})

    #update mob images
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZone2 = $MapZone.ZName
        $MapMobName = $MapZone.MName
        If($MapMobName -eq "none"){}
        Else{
            #$WPFimageOrcHill.Visibility="Hidden"
            #$WPFimageCrushBone.Visibility="Visible"
            $MapMobName = $MapZone.MName
            $MapMobCount = $MapZone.MCount
            $NewSource = "$Here\objects\Map\"+ $MapMobName + ""+$MapMobCount+".png"
            Switch($MapZone.ID)
            {
                1 {$WPFimageCrushBone.Source = $NewSource;$WPFimageCrushBone.Visibility="Visible"}
                5 {$WPFimageOrcHill.Source = $NewSource;$WPFimageOrcHill.Visibility="Visible"}
                6 {$WPFimageKelethin.Source = $NewSource;$WPFimageKelethin.Visibility="Visible"}
                7 {$WPFimageGFay.Source = $NewSource;$WPFimageGFay.Visibility="Visible"}
                9 {$WPFimageFelwithe.Source = $NewSource;$WPFimageFelwithe.Visibility="Visible"}
            }                     
        }                
    }
    #update mob images
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZone2 = $MapZone.ZName
        $MapMobName = $MapZone.MName
        If($MapMobName -eq "none"){}
        Else{
            #$WPFimageOrcHill.Visibility="Hidden"
            $MapMobName = $MapZone.MName
            $MapMobCount = $MapZone.MCount
            $NewSource = "$Here\objects\Map\"+ $MapMobName + ""+$MapMobCount+".png"

            Switch($MapZone.ID)
            {
                1 {$WPFimageCrushBone.Source = $NewSource}
                5 {$WPFimageOrcHill.Source = $NewSource}
                6 {$WPFimageKelethin.Source = $NewSource}
                7 {$WPFimageGFay.Source = $NewSource}
                9 {$WPFimageFelwithe.Source = $NewSource}
                10{$WPFimageSpires.Source = $NewSource}
                11{$WPFimageButcherBlock.Source = $NewSource}
                12{$WPFimageDocks.Source = $NewSource}
                13{$WPFimageKaladim.Source = $NewSource}
                14{$WPFimageDC.Source = $NewSource}
                15{$WPFimageUnrest.Source = $NewSource}
            }                
        }                
    }

    $db | Export-Csv -Path $DBPath -Force -Confirm:$false 
    $db = Import-Csv -Path $DBPath 

    $Form.ShowDialog() | out-null
}

Function Options{OpenMap}

Function CloseMap{
    $db = Import-Csv -Path $DBPath  
    $db | Export-Csv -Path $DBPath -Force -Confirm:$false    
    $AutoTurns = "false"
    $Form.Close() | out-null;
}

Function ResetDB{
    #reset zone db
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZoneID = $MapZone.ID
        $MapZoneName = $MapZone.ZName
        $MName = $MapZone.MName
        $MCount = $MapZone.MCount
    
        Switch($MapZoneID)
        {
            1 {$MapZone.MName = 'orc';$MapZone.MCount = 1}
            6 {$MapZone.MName = 'KelethinGuard';$MapZone.MCount = 1}
            9 {$MapZone.MName = 'FelwitheGuard';$MapZone.MCount = 1}
            13 {$MapZone.MName = 'DwarfGuard';$MapZone.MCount = 1}
            default {$MapZone.MName = 'none';$MapZone.MCount = 0}
        }
    }
    $db | Export-Csv -Path $DBPath -Force -Confirm:$false
}

Function MapSpawnMobs{
    #spawn mobs 
    YellowLog "     Zoning Please Wait..."
    YellowLog  "     each zone is taking its turn..."
    ProgressBar
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZoneName = $MapZone.ZName
        $MapMobName = $MapZone.MName
        $MapZoneMCount = $MapZone.MCount
        If($MapMobName -eq "none"){YellowLog "     $MapZoneName is performing spawning and movement"}
        ElseIf($MapMobName -match "DwarfGuard"){
            Switch($MapZoneMCount)
            {
                1 {YellowLog "     1 $MapMobName is ready to advance.";}
                default {YellowLog "     $MapZoneName is taking its turn..."}
            }        
        }
        Else{
            Switch($MapZoneMCount)
            {
                1 {$MapZone.MCount = 2;YellowLog "     $MapZoneName spawned another $MapMobName. There are now 2. Next Turn 1 will be ready to advance.";}
                2 {$MapZone.MCount = 3;YellowLog "     $MapZoneName spawned another $MapMobName. There are now 3.";}
                3 {YellowLog "1 $MapMobName is ready to advance";$MapZone.MCount = 2}
                default {YellowLog "     $MapZoneName is taking its turn..."}
            }
            YellowLog "     finished spawning mobs in $MapZoneName"
            $db | Export-Csv -Path $DBPath -Force -Confirm:$false
        }
    }

    #update mob images
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZone2 = $MapZone.ZName
        $MapMobName = $MapZone.MName
        $MapZoneMCount = $MapZone.MCount
        If($MapMobName -match "none"){YellowLog "          $MapZone2 finish its turn";$MapZone.MCount = 0}
        Else{
            #$WPFimageOrcHill.Visibility="Hidden"
            $MapMobName = $MapZone.MName
            $MapMobCount = $MapZone.MCount
            $NewSource = "$Here\objects\Map\"+ $MapMobName + ""+$MapMobCount+".png"
            If($MapMobCount -eq 0){
                $NewSource = "$Here\objects\Map\none.png"
                $MapZone.MName = "none"
            }

            Switch($MapZone.ID)
            {
                1 {$WPFimageCrushBone.Source = $NewSource}
                5 {$WPFimageOrcHill.Source = $NewSource}
                6 {$WPFimageKelethin.Source = $NewSource}
                7 {$WPFimageGFay.Source = $NewSource}
                9 {$WPFimageFelwithe.Source = $NewSource}
                10{$WPFimageSpires.Source = $NewSource}
                11{$WPFimageButcherBlock.Source = $NewSource}
                12{$WPFimageDocks.Source = $NewSource}
                13{$WPFimageKaladim.Source = $NewSource}
                14{$WPFimageDC.Source = $NewSource}
                15{$WPFimageUnrest.Source = $NewSource}
            }                
        }                
    }
    $db | Export-Csv -Path $DBPath -Force -Confirm:$false
    Start-Sleep -Seconds 1

    
    #if mob count is 3 then move to next zone
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZoneID = $MapZone.ID
        $MapZoneName = $MapZone.ZName
        $MapMobName = $MapZone.MName
        $MapZoneMCount = $MapZone.MCount
        If($MapZoneMCount -eq 3){
            $MapZone.MCount = 2;
            If($MapMobName -eq "orc"){$MapNextZone = $MapZone.NZoneE}
            Else{$MapNextZone = $MapZone.NZoneG} 
            
            Switch($MapNextZone)
            {
                1 {YellowLog "          $MapMobName from $MapZoneName are moving to Crushbone";}#$MapZone.MCount = 2;}
                5 {YellowLog "          $MapMobName from $MapZoneName are moving to Orc Hill";}#$MapZone.MCount = 2;}
                6 {YellowLog "          $MapMobName from $MapZoneName are moving to wood elf city Kelethin";}#$MapZone.MCount = 2;}
                7 {YellowLog "          $MapMobName from $MapZoneName are moving to to Greater Faydark";}#$MapZone.MCount = 2;} 
                8 {YellowLog "          $MapMobName from $MapZoneName are moving to the Greater Faydark Trail";}#$MapZone.MCount = 2;}
                9 {YellowLog "          $MapMobName from $MapZoneName are moving to the high elf city Felwithe";}#$MapZone.MCount = 2;}
                10 {YellowLog "          $MapMobName from $MapZoneName are moving to Greater Faydark Spires";}#$MapZone.MCount = 2;}#add trail to unrest zones 25-30ish
                11 {YellowLog "          $MapMobName from $MapZoneName are moving to Butcherblock";}#$MapZone.MCount = 2;}
                12 {YellowLog "          $MapMobName from $MapZoneName are moving to the Butcherblock Docks";}#$MapZone.MCount = 2;}
                13 {YellowLog "          $MapMobName from $MapZoneName are moving to Kaladim";}#$MapZone.MCount = 2;}
                14 {YellowLog "          $MapMobName from $MapZoneName are moving to Dagnor's Cauldron";}#$MapZone.MCount = 2;}
                15 {YellowLog "          $MapMobName from $MapZoneName are moving to the Estate of Unrest";}#$MapZone.MCount = 2;}
                16 {YellowLog "          $MapMobName from $MapZoneName are moving to Spires";}#$MapZone.MCount = 2;}
                17 {YellowLog "          $MapMobName from $MapZoneName are moving to Spires";}#$MapZone.MCount = 2;}
                default {YellowLog "ERROR: unknown zone number"}
            } 

            #get defender info
            $DefenderInfo = $db.GetValue($MapNextZone - 1)
            $DefenderZone = $DefenderInfo.ZName
            $DefenderMob = $DefenderInfo.MName
            $DefenderCount = $DefenderInfo.MCount

            If($DefenderMob -eq "none"){
                YellowLog "               $MapMobName met little resistance"
                $DefenderInfo.MCount = 1;
                $DefenderInfo.MName = "$MapMobName";
                #$ZID = ($AtkZone - 1)
                #$db[$ZID].MName = $MapMobName
                #$db[$ZID].MCount = 1
                
                
                $db | Export-Csv -Path $DBPath -Force -Confirm:$false;
                $db = Import-Csv -Path $DBPath
                YellowLog "               $MapMobName has moved to $DefenderZone";
                YellowLog "               $DefenderZone is now occupied by a $MapMobName";  
                                
            }                 
            
            ElseIf($MapMobName -match "Guard" -and $DefenderMob -match "Guard"){YellowLog "     An Elf allied force is already occupying $DefenderZone"}

            ElseIf($MapMobName -match "orc" -and $DefenderMob -match "orc"){YellowLog "     An orc allied force is already occupying $DefenderZone"}

            Else{
                YellowLog "               $DefenderCount $DefenderMob available to defend"
                YellowLog "               $DefenderMob is defending"
                YellowLog "               $MapMobName is attacking"
                YellowLog "               a battle has begun in $DefenderZone"

                $DMobHP = 20
                $AMobHP = 20


                $DMobDmg = (Get-Random -Minimum 1 -Maximum 10)
                $AMobDmg = (Get-Random -Minimum 1 -Maximum 10)

                #AtkRound
                $HitChance = (Get-Random -Minimum 1 -Maximum 100)
                If($HitChance -gt 30){
                    $DMobHP = ($DMobHP - $AMobDmg)
                    RedLog "               $MapMobName hit a $DefenderMob for $AMobDmg damage"
                    YellowLog "     $DefenderMob now has $DMobHP left"
                }
                Else{YellowLog "     $MapMobName misses an attack"}
                If($HitChance -gt 50){
                    $DMobHP = ($DMobHP - $AMobDmg)
                    RedLog "               $MapMobName hit a $DefenderMob for $AMobDmg damage"
                    Log "     $DefenderMob now has $DMobHP left"
                }
                Else{YellowLog "     $MapMobName misses an attack"}
                Start-Sleep -Seconds 1

                #DefRound
                $HitChance = (Get-Random -Minimum 1 -Maximum 100)
                If($HitChance -gt 50){
                    $AMobHP = ($AMobHP - $DMobDmg)
                    RedLog "               $DefenderMob hit a $MapMobName for $DMobDmg damage"
                    YellowLog "     $MapMobName now has $AMobHP left"
                }
                Else{YellowLog "$DefenderMob misses an attack"}
                If($HitChance -gt 50){
                    $AMobHP = ($AMobHP - $DMobDmg)
                    RedLog "               $DefenderMob hit a $MapMobName for $DMobDmg damage"
                    YellowLog "     $MapMobName now has $AMobHP left"
                }
                Else{YellowLog "     $DefenderMob misses an attack"}

                #LastRound
                $DMobDmg = (Get-Random -Minimum 5 -Maximum 15)
                $AMobDmg = (Get-Random -Minimum 5 -Maximum 15)
                If($HitChance -gt 50){
                    $DMobHP = ($DMobHP - $AMobDmg)
                    RedLog "               $MapMobName delivers a CRITICAL HIT of $AMobDmg damage!"
                    YellowLog "     $DefenderMob now has $DMobHP left"
                }
                Else{YellowLog "     $MapMobName misses an attack"}
                $HitChance = (Get-Random -Minimum 1 -Maximum 100)
                If($HitChance -gt 50){
                    $AMobHP = ($AMobHP - $DMobDmg)
                    RedLog "               $DefenderMob hit a $MapMobName for $DMobDmg damage"
                    YellowLog "     $MapMobName now has $AMobHP left"
                }
                Else{YellowLog "$DefenderMob misses an attack"}
                Start-Sleep -Seconds 1

                If($AMobHP -lt 1){
                    YellowLog "     $DefenderMob has successfully defended $DefenderZone"
                }
                If($DMobHP -gt 0){Log "     $DefenderMob has successfully defended $DefenderZone"}
                If($DMobHP -lt 1){
                    $DefenderCount = $DefenderInfo.MCount
                    #Log "     defender count is $DefenderCount"
                    RedLog "               $DefenderMob has died"

                    Switch($DefenderCount)
                    {
                        0 {$DefenderInfo.MCount = 0;$DefenderInfo.MName = "none"}
                        1 {YellowLog "     $DefenderZone has been cleared";$DefenderInfo.MCount = 1;$DefenderInfo.MName = "$MapMobName";}
                        2 {YellowLog "     there are 2 $DefenderMob left";$DefenderInfo.MCount = 1}
                        3 {YellowLog "     there are 3 $DefenderMob left";$DefenderInfo.MCount = 2}
                    }
                    $db | Export-Csv -Path $DBPath -Force -Confirm:$false 
                    $db = Import-Csv -Path $DBPath      
                }
            }
            #$MapZone.MCount = 2;
            $db | Export-Csv -Path $DBPath -Force -Confirm:$false 
            $db = Import-Csv -Path $DBPath
        }
    }
 

    #update mob images
    $db = Import-Csv -Path $DBPath
    foreach($MapZone in $db){
        $MapZone2 = $MapZone.ZName
        $MapMobName = $MapZone.MName
        If($MapMobName -eq "none"){YellowLog "          $MapZone2 finish its turn"}
        Else{
            #$WPFimageOrcHill.Visibility="Hidden"
            $MapMobName = $MapZone.MName
            $MapMobCount = $MapZone.MCount
            $NewSource = "$Here\objects\Map\"+ $MapMobName + ""+$MapMobCount+".png"
            If($MapMobCount -eq 0){
                $NewSource = "$Here\objects\Map\none.png"
                $MapZone.MName = "none"
            }

            Switch($MapZone.ID)
            {
                1 {$WPFimageCrushBone.Source = $NewSource}
                5 {$WPFimageOrcHill.Source = $NewSource}
                6 {$WPFimageKelethin.Source = $NewSource}
                7 {$WPFimageGFay.Source = $NewSource}
                9 {$WPFimageFelwithe.Source = $NewSource}
                10{$WPFimageSpires.Source = $NewSource}
                11{$WPFimageButcherBlock.Source = $NewSource}
                12{$WPFimageDocks.Source = $NewSource}
                13{$WPFimageKaladim.Source = $NewSource}
                14{$WPFimageDC.Source = $NewSource}
                15{$WPFimageUnrest.Source = $NewSource}
            }                
        }                
    }

    $db | Export-Csv -Path $DBPath -Force -Confirm:$false 
    $db = Import-Csv -Path $DBPath       
    Log "It is now your turn"
    $script:AutoTurns++
}

Function AutoMapSpawnMobs{
    Log "Starting automatic moves..."
    Log "Close the map to stop auto moves"
    $script:AutoTurns = 1
    do{MapSpawnMobs;Start-Sleep -Seconds (Get-Random -Minimum 5 -Maximum 10);}until($script:AutoTurns -gt 5);
}

Function WatchAC{Log "Feature coming soon"}

Function AdvanceMob($MapZone, $MapMobName){
    #Write-Host "$Zone"
    $MapZoneID = $MapZone.ID
    $MapZoneName = $MapZone.ZName
    $MapMobName = $MapZone.MName
    $MCount = $MapZone.MCount
    
    If($MapMobName -eq "orc"){$MapNextZone = $MapZone.NZoneE}
    Else{$MapNextZone = $MapZone.NZoneG} 

    Switch($MapNextZone)
    {
        1 {Log "$MapMobName is moving to Crushbone";CheckBattle $MapNextZone, $MapMobName}
        5 {Log "$MapMobName is moving to Orc Hill";CheckBattle $MapNextZone, $MapMobName}
        6 {Log "$MapMobName is moving to Kelethin";CheckBattle $MapNextZone, $MapMobName}
        7 {Log "$MapMobName is moving to Greater Faydark";CheckBattle $MapNextZone, $MapMobName} 
        8 {Log "$MapMobName is moving to the Greater Faydark Trail";CheckBattle $MapNextZone, $MapMobName}
        9 {Log "$MapMobName is moving to the high elf city Felwithe";CheckBattle $MapNextZone, $MapMobName}
        10 {Log "$MapMobName is moving to Spires";CheckBattle $MapNextZone, $MapMobName}
        11 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        12 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        13 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName} #add trail to unrest zones 25-30ish
        14 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        15 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        16 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        17 {Log "the next zone on the trail is ";CheckBattle $MapNextZone, $MapMobName}
        default {Log "ERROR: unknown zone number"}
    }    
    
       
}

Function CheckBattle($MapNextZone, $MapMobName){
    #function no longer used
    Log "Check for battle"
    #Log "MapNextZone $MapNextZone"
    $AtkInfo = ($MapNextZone).Split(" ")
    $AtkMob = $AtkInfo[-1]
    $AtkZone = $AtkInfo[0]
    Log "AtkZone is $AtkZone "
    Log "Attacking Mob is a $AtkMob "
    #import db
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #check if $NextZone is occupied
    $DefenderInfo = $db.GetValue($AtkZone - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderCount.MCount
    If($DefenderMob -eq "none"){
        Log "$AtkMob met little resistance"
        $DefenderInfo.MCount = 1;
        $DefenderInfo.MName = "$AtkMob";
        $ZID = ($AtkZone - 1)
        $db[$ZID].MName = $AtkMob
        $db[$ZID].MCount = 1
        $db | Export-Csv -Path $DBPath -Force -Confirm:$false;
        $db = Import-Csv -Path $DBPath
        Log "$DefenderZone is now occupied by a $AtkMob";
    }
    Else{Log "map battle "}
    #$db | Export-Csv -Path $DBPath -Force -Confirm:$false;
}

Function MapBattle{
    #function no longer used
    Log "Map Battle"
    #import db
    #check current NextZone occupaints
        #make var for DefenderCount
    #check current zone occupaints
    #do random for attaks like MobAttack
        #when on auto turn then make pause between attacks
    #battle until last no more are left to defend
    #if attack success then move 1 MobName to NextZone 

}

Function CrushBone{
    Log "CrushBone"
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 1
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}

}

Function OrcHill{
    Log "OrcHill"
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 5
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Felwithe{
    Log "Felwithe"
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 9
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Kelethin{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 6
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Gfay{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 7
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Spires{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 10
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function ButcherBlock{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 11
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Kaladim{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 13
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Docks{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 12
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Cauldron{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 14
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

Function Unrest{
    $DBPath = "$Here\objects\Map\db.csv"
    $db = Import-Csv -Path $DBPath
    #get defender info
    $MapZoneID = 15
    $DefenderInfo = $db.GetValue($MapZoneID - 1)
    $DefenderZone = $DefenderInfo.ZName
    $DefenderMob = $DefenderInfo.MName
    $DefenderCount = $DefenderInfo.MCount

    If($DefenderMob -eq "none"){Log "no known mobs in $DefenderZone"}
    Else{Log "There are $DefenderCount $DefenderMob in $DefenderZone"}
}

#endregion Map

ResetDB
#Splash
EnterWorld