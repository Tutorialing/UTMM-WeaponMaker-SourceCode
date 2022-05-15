local toolbar = plugin:CreateToolbar("Bloods easy weapon maker.")

local Button = toolbar:CreateButton("UTMM Weapon Creator", "Create an Weapon that is clickable(UTMM Kit)", "rbxassetid://5514664147")
Button.ClickableWhenViewportHidden = true
local ChangeHistoryService = game:GetService("ChangeHistoryService")
Button.Click:Connect(function()
	ChangeHistoryService:SetWaypoint("Did the funny(Packed Selected Items into a tool and gave it animation + script for it to work.)")
	local selection = game:GetService("Selection")
	local current = selection:Get()[1]
	print(current.Name)
	local newtool = Instance.new("Tool")
	newtool.Name = "ToolByBloodPlugin"
	newtool.Parent = game.Workspace
	local l = selection:Get()
	local hashandle = false
	local justincasenohandle = nil
	local damage = Instance.new("NumberValue",newtool)
	local damage2 = Instance.new("NumberValue",newtool)
	local damage3 = Instance.new("IntValue",newtool)
	damage.Name = "Damage"
	damage2.Name = "DamageIncrease"
	damage3.Name = "DamageModify"
	for i=1,#l do
		local Selected = game.Selection:Get()[i]
		local cloned = Selected:Clone()
		if justincasenohandle == nil then justincasenohandle = cloned end
		if cloned.Name == "Handle" then hashandle = true end
		cloned.Parent = newtool
		print(Selected.Name)
	end
	if hashandle == true then
		local sound = Instance.new("Sound",newtool.Handle)
		local sound2 = Instance.new("Sound",newtool.Handle)
		sound.Name = "Hit"
		sound2.Name = "Slash"
		sound.SoundId = "rbxassetid://406913243"
		sound2.SoundId = "rbxassetid://437475935"
		for i=1,2 do
			local attachment = Instance.new("Attachment",newtool.Handle)
			attachment.Name = "Attach"..i
		end
		local anim = Instance.new("Animation",newtool.Handle)
		local anim2 = Instance.new("Animation",newtool.Handle)
		anim.Name = "SlashR15"
		anim2.Name = "SlashR6"
		local trail = Instance.new("Trail",newtool)
		trail.Attachment0 = newtool.Handle.Attach1
		trail.Attachment1 = newtool.Handle.Attach2
	else
		justincasenohandle.Name = "Handle"
		local sound = Instance.new("Sound",newtool.Handle)
		local sound2 = Instance.new("Sound",newtool.Handle)
		sound.Name = "Hit"
		sound2.Name = "Slash"
		sound.SoundId = "rbxassetid://406913243"
		sound2.SoundId = "rbxassetid://437475935"
		for i=1,2 do
			local attachment = Instance.new("Attachment",newtool.Handle)
			attachment.Name = "Attach"..i
		end
		local anim = Instance.new("Animation",newtool.Handle)
		local anim2 = Instance.new("Animation",newtool.Handle)
		anim.Name = "SlashR15"
		anim2.Name = "SlashR6"
		local trail = Instance.new("Trail",newtool)
		trail.Attachment0 = newtool.Handle.Attach1
		trail.Attachment1 = newtool.Handle.Attach2
	end
	local scripter =Instance.new("Script",newtool)
	scripter.Source = [[debounce = false
				plr = nil
				attackdebounce = false
				script.Parent.Activated:Connect(function()
					if debounce == false then
						if plr == nil then
							plr = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
						end
								local anim = nil
						if script.Parent.Parent:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
							anim = script.Parent.Parent:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(script.Parent.Handle.SlashR6)
						else
							anim = script.Parent.Parent:FindFirstChildOfClass("Humanoid").Animator:LoadAnimation(script.Parent.Handle.SlashR15)
						end
						script.Parent.Handle.Slash:Play()
						anim:Play()
						debounce = true
						script.Parent.Trail.Enabled = true
						wait(anim.Length)
						script.Parent.Trail.Enabled = false
						wait(0.5)
						debounce = false
					end
				end)
				script.Parent.Handle.Touched:connect(function(h)
					if h.Parent then
					local hum = h.Parent:FindFirstChildOfClass("Humanoid")
					if hum and hum.Health > 0 then
						if attackdebounce == false and h.Parent:FindFirstChild("_enemytag") then
							if script.Parent.Trail.Enabled then
								script.Parent.Handle.Hit:Play()
								attackdebounce = true
								local damage = script.Parent.Damage.Value + (script.Parent.DamageModify.Value * (plr.LOVE.Value - 1))
								local damageboost = math.floor(damage*script.Parent.DamageIncrease.Value)
								hum:TakeDamage(damage+damageboost)
								wait(0.5)
								attackdebounce = false
							end
						end
					end
					end
					
				end)]]
	local handlebi = newtool:GetChildren()
	for i=1,#handlebi do
		if handlebi[i].Name ~= "Handle" and handlebi[i]:IsA("MeshPart") or handlebi[i]:IsA("Part") or handlebi[i]:IsA("WedgePart") or handlebi[i]:IsA("UnionOperation") then
			local p0 = newtool.Handle
			local p1 = handlebi[i]
			local w = Instance.new("WeldConstraint")
			w.Part0 = p0
			w.Part1 = p1
			w.Parent = p1
			handlebi[i].Massless = true
			handlebi[i].Anchored = false 
		end
	end
	selection:Set({newtool})
	selection:Set({newtool})
	newtool.Handle.Anchored = false
end)