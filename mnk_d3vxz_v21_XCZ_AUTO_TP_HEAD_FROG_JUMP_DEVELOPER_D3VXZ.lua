-- mnk/d3vxz v21 XCZ AUTO TP HEAD | Everything same except XCZ | Developer- d3vxz | Best UI
-- Feature: After XCZ dash ends, automatically TPs 2 studs above enemy head for easy frog jump + magnet pull
-- Magnet sources: Solitude (TP_DELAY) + Combined (magnet pull) - best of both

pcall(function()
    for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name:find("MNK") or v.Name:find("WindUI") or v.Name:find("Combined") or v.Name:find("D3VXZ") then
            pcall(function() v:Destroy() end)
        end
    end
    for _,v in pairs(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if v.Name:find("MNK") or v.Name:find("D3VXZ") or v.Name:find("WindUI") or v.Name:find("Combined") or v.Name:find("Solitude") then
            pcall(function() v:Destroy() end)
        end
    end
end)

local WindUI
local ok = pcall(function()
    WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)
if not ok or not WindUI then
    WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/src/main.lua"))()
end

WindUI:Notify({
    Title = "mnk / d3vxz v21 XCZ TP HEAD",
    Content = "Developer- d3vxz | XCZ Auto TP to Head Added",
    Duration = 3,
})

local Window = WindUI:CreateWindow({
    Title = "mnk / d3vxz v21 XCZ TP HEAD",
    Icon = "zap",
    Author = "Developer- d3vxz",
    Folder = "mnk_d3vxz_v21_xcz_tp",
    Size = UDim2.fromOffset(580, 480),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 180,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = false,
})

-- mnk/d3vxz v11.1 NO KEY SYSTEM | Small GUI + Config Codes | King from file + Instant Twisted
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

pcall(function() for _,v in pairs(CoreGui:GetChildren()) do if v.Name:find("MNK") then v:Destroy() end end end)

local states={KingTech=false,XCZ=false,LethalDash=false,LoopDash=false,Supa=false,InstantTwisted=false,AntiLag=false}
local function Notify(t) pcall(function() game.StarterGui:SetCore("SendNotification",{Title="v11.1 No Key", Text=t, Duration=2}) end) end
local function GetCharacterData() local char=LocalPlayer.Character if not char then return nil,nil,nil end local hum=char:FindFirstChildOfClass("Humanoid") local root=char:FindFirstChild("HumanoidRootPart") return char,hum,root end
local function FireDashQW() local char=LocalPlayer.Character if char and char:FindFirstChild("Communicate") then pcall(function() char.Communicate:FireServer(unpack({{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}})) end) end end

local AntiLag={Enabled=false, Orig={}, Conns={}}
function AntiLag:Apply() if self.Enabled then return end self.Enabled=true self.Orig.GlobalShadows=Lighting.GlobalShadows self.Orig.FogEnd=Lighting.FogEnd pcall(function() self.Orig.Quality=settings().Rendering.QualityLevel settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end) Lighting.GlobalShadows=false Lighting.FogEnd=9e9 Lighting.Brightness=1 Lighting.EnvironmentDiffuseScale=0 Lighting.EnvironmentSpecularScale=0 pcall(function() Lighting.Technology=Enum.Technology.Compatibility end) for _,v in pairs(Lighting:GetChildren()) do if v:IsA("PostEffect") and v.Enabled then self.Orig[v]=v.Enabled v.Enabled=false end end local function opt(obj) if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then if obj.Enabled then self.Orig[obj]=obj.Enabled obj.Enabled=false end elseif obj:IsA("BasePart") then obj.Reflectance=0 obj.CastShadow=false if obj.Material~=Enum.Material.SmoothPlastic then self.Orig[obj]=obj.Material obj.Material=Enum.Material.SmoothPlastic end end end for _,o in pairs(Workspace:GetDescendants()) do pcall(opt,o) end local c1=Workspace.DescendantAdded:Connect(function(o) if self.Enabled then task.wait(0.05) pcall(opt,o) end end) table.insert(self.Conns,c1) pcall(function() setfpscap(999) end) Notify("Anti Lag ON") end
function AntiLag:Restore() if not self.Enabled then return end self.Enabled=false for _,c in pairs(self.Conns) do pcall(function() c:Disconnect() end) end self.Conns={} if self.Orig.GlobalShadows~=nil then Lighting.GlobalShadows=self.Orig.GlobalShadows end if self.Orig.FogEnd~=nil then Lighting.FogEnd=self.Orig.FogEnd end pcall(function() settings().Rendering.QualityLevel=self.Orig.Quality or Enum.QualityLevel.Level08 end) for obj,orig in pairs(self.Orig) do if typeof(obj)=="Instance" and obj.Parent then pcall(function() if obj:IsA("ParticleEmitter") or obj:IsA("PostEffect") then obj.Enabled=orig elseif obj:IsA("BasePart") then obj.Material=orig obj.CastShadow=true end end) end end self.Orig={} Notify("Anti Lag OFF") end
function AntiLag:DeepClean() local n=0 for _,v in pairs(Workspace:GetDescendants()) do if v:IsA("ParticleEmitter") and v.Enabled then v.Enabled=false n+=1 elseif v:IsA("Trail") and v.Enabled then v.Enabled=false n+=1 end end return n end

local O = {DA = "10503381238", AH = false, AT = false}
local KT = {a = false, b = false, d = 2.9, e = 0, f = 0.5, g = 10, h = 150, i = 40, j = 836, k = 46, k1ngJump = 0, CharacterTilt = 60}
local OLF = nil
local function k1ngFT() local rd=KT.h local lv=Workspace:FindFirstChild("Live") local _,_,root=GetCharacterData() if not lv or not root then return nil end local bt=nil for _,v in ipairs(lv:GetChildren()) do if v and v:IsA("Model") and v~=LocalPlayer.Character then local tR=v:FindFirstChild("HumanoidRootPart") local tH=v:FindFirstChild("Head") local tM=v:FindFirstChildOfClass("Humanoid") if tR and tM and tM.Health>0 then local d=(tR.Position-root.Position).Magnitude if d<=rd then if O.AH and tH then bt=tH elseif O.AT and v:FindFirstChild("Torso") then bt=v:FindFirstChild("Torso") or tR else bt=tR end rd=d end end end end return bt end
local function k1ngLT(tg,du,rs) local _,hum,root=GetCharacterData() if not (tg and tg.Parent) or not (root and hum) then return nil end local rc,sT,cn=math.clamp(rs,1,10000),tick(),nil cn=RunService.RenderStepped:Connect(function() if tg and tg.Parent and root and root.Parent then local rP=root.Position local tPs2=Vector3.new(tg.Position.X,rP.Y,tg.Position.Z) if (tPs2-rP).Magnitude>=0.001 then root.CFrame=CFrame.new(rP,tPs2)*CFrame.Angles(math.rad(KT.CharacterTilt),0,0) end if tick()-sT>=du and cn then cn:Disconnect() end else if cn then cn:Disconnect() end end end) return function() if cn then pcall(function() cn:Disconnect() end) end end end
local function k1ngTechExecution() local _,hum,root=GetCharacterData() if KT.b or not KT.a then return end KT.b=true task.wait(KT.d/10) if hum and root then hum.AutoRotate=false if KT.k1ngJump>0 then pcall(function() hum.Jump=true hum:ChangeState(Enum.HumanoidStateType.Jumping) root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,KT.k1ngJump,root.AssemblyLinearVelocity.Z) end) task.wait(0.05) end local tg=k1ngFT() if tg then root.Velocity=Vector3.new(root.Velocity.X,KT.k,root.Velocity.Z) task.wait(KT.e/10) FireDashQW() task.wait(KT.f/10) OLF=k1ngLT(tg,KT.g/10,KT.j) local eT=tick()+(KT.g/10) task.spawn(function() while tick()<eT and KT.a do hum.AutoRotate=false RunService.Heartbeat:Wait() end hum.AutoRotate=true end) else local lookDirection=root.CFrame.LookVector root.AssemblyLinearVelocity=lookDirection*(KT.k*2) task.wait(KT.e/10) FireDashQW() task.wait(KT.f/10) root.AssemblyLinearVelocity=-lookDirection*(KT.k*2) task.wait(KT.g/20) root.AssemblyLinearVelocity=Vector3.zero hum.AutoRotate=true end end task.wait(KT.i/10) KT.b=false end

local VuxId=math.random(1,1000000) _G.VuxLethalId=VuxId local function VuxIsCurrent() return _G.VuxLethalId==VuxId end
local VuxTbl={Enabled=true,LethalAnim="rbxassetid://10503381238",LethalDelay=0.285,LethalJump=55,FlickDelay=0.25,AutoPingComp=true,Smoothness=500,LethalCancelDelay=0.4,CancelEnabled=true,CooldownActive=true,NoClipEnabled=true,DashRange=25,CooldownAnims={["10491993682"]=true,["10479335397"]=true,["13380255751"]=true}}
local VuxFlag=false local VuxFlag2=false local VuxFlag3=false
local function VuxGetPing() local n=0.05 pcall(function() n=Stats:GetTotalPing()/1000 end) return math.clamp(n,0,0.35) end
local function VuxFireQW() local c=LocalPlayer.Character if c then local v5=c:FindFirstChild("Communicate") if v5 then v5:FireServer(unpack({{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}})) end end end
local function VuxClipOff() VuxFlag=false local c=LocalPlayer.Character if c then local v6=c:FindFirstChildOfClass("Humanoid") if v6 then v6.AutoRotate=true end end end
local function VuxForceCancel() VuxClipOff() local c=LocalPlayer.Character local v7=c and c:FindFirstChild("HumanoidRootPart") if v7 then for _,vv in pairs(v7:GetChildren()) do if vv:IsA("BodyVelocity") or vv:IsA("LinearVelocity") or vv:IsA("Attachment") or vv:IsA("BodyAngularVelocity") then vv:Destroy() end end v7.AssemblyLinearVelocity=Vector3.zero end end
local function VuxGetTarget() local c=LocalPlayer.Character if not c or not c:FindFirstChild("HumanoidRootPart") then return nil end local v12=OverlapParams.new() v12.FilterType=Enum.RaycastFilterType.Exclude v12.FilterDescendantsInstances={c} local v13=Workspace:GetPartBoundsInRadius(c.HumanoidRootPart.Position,VuxTbl.DashRange,v12) local v14 local DashRange=VuxTbl.DashRange for _,vv in pairs(v13) do local v15=vv:FindFirstAncestorOfClass("Model") if v15 and v15:FindFirstChildOfClass("Humanoid") and v15~=c then local v16=v15:FindFirstChildOfClass("Humanoid") local v17=v15:FindFirstChild("UpperTorso") or v15:FindFirstChild("Torso") or v15:FindFirstChild("HumanoidRootPart") if v16 and v16.Health>0 and v17 then local mag=(c.HumanoidRootPart.Position-v17.Position).Magnitude if mag<DashRange then DashRange=mag v14=v17 end end end end return v14 end
local function VuxFlickExecute() if not VuxIsCurrent() or VuxFlag3 then return end if VuxFlag2 then return end if not states.XCZ then return end if not VuxTbl.Enabled then return end local c=LocalPlayer.Character local v18=c and c:FindFirstChild("HumanoidRootPart") local v19=c and c:FindFirstChildOfClass("Humanoid") if not v18 or not v19 or v19.Health<=0 then return end local v20=VuxGetTarget() if not v20 then return end VuxFlag3=true local v21,v22,v23,v24 task.wait(math.max(0,VuxTbl.LethalDelay)) if not VuxIsCurrent() or not v20.Parent or not v18.Parent then VuxFlag3=false return end v18.AssemblyLinearVelocity=Vector3.new(v18.AssemblyLinearVelocity.X,VuxTbl.LethalJump,v18.AssemblyLinearVelocity.Z) VuxFlag=true task.wait(0) VuxFireQW() v21=os.clock() v19.AutoRotate=false v22=VuxGetPing() v23=VuxTbl.FlickDelay if VuxTbl.AutoPingComp then v23=math.max(0,VuxTbl.FlickDelay-v22/2) end v24=RunService.Heartbeat:Connect(function(dt) if not VuxIsCurrent() or not v20 or not v20.Parent or not v18 or not v18.Parent then VuxClipOff() VuxFlag3=false if v24 then v24:Disconnect() end return end local st=v19:GetState() if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown or v19.Health<=0 then VuxClipOff() VuxFlag3=false if v24 then v24:Disconnect() end return end v19.AutoRotate=false local v33=os.clock()-v21 local Pos3=v20.Position local Pos4=v18.Position if v23<=v33 then local v34=Vector3.new(Pos3.X,Pos4.Y,Pos3.Z) local v35=CFrame.lookAt(Pos4,v34) local v36=math.clamp((1000-VuxTbl.Smoothness)/1000,0.01,1) local v37=math.pow(1-v36,dt*60) local v38=v18.CFrame:Lerp(v35,1-v37) v18.CFrame=v38 end local Mag3=(Vector2.new(Pos4.X,Pos4.Z)-Vector2.new(Pos3.X,Pos3.Z)).Magnitude if VuxTbl.CancelEnabled and VuxTbl.LethalCancelDelay<v33 and Mag3<2.2 or 1.5<v33 or not states.XCZ then VuxForceCancel() VuxFlag3=false v24:Disconnect() if VuxTbl.CooldownActive then VuxFlag2=true task.delay(5,function() VuxFlag2=false end) end end end) end

local SupaChar=nil local SupaHum=nil local SupaRoot=nil local SupaLastTick=0 local SupaInCd=false
local function SupaFind() if not SupaRoot then return nil end local cl=nil local sm=20 for _,desc in pairs(Workspace:GetDescendants()) do if desc:IsA("Model") and desc:FindFirstChild("HumanoidRootPart") and desc~=SupaChar then local ok,dist=pcall(function() return (SupaRoot.Position-desc.HumanoidRootPart.Position).Magnitude end) if ok and dist and dist<sm then cl=desc sm=dist end end end return cl end
local function SupaSendDash() pcall(function() local p={{Dash=Enum.KeyCode.W, Key=Enum.KeyCode.Q, Goal="KeyPress"}} if SupaChar and SupaChar:FindFirstChild("Communicate") then SupaChar.Communicate:FireServer(unpack(p)) end end) local function findNil(n,cl) for _,i in pairs(getnilinstances()) do if i.ClassName==cl and i.Name==n then return i end end return nil end pcall(function() local p={{Goal="delete bv", BV=findNil("moveme","BodyVelocity")}} if SupaChar and SupaChar:FindFirstChild("Communicate") then SupaChar.Communicate:FireServer(unpack(p)) end end) end
local function SupaPerform() if not SupaChar or not SupaHum or not SupaRoot then return end local tm=SupaFind() if not tm then return end local tr=tm:FindFirstChild("HumanoidRootPart") if not tr then return end local saved={} pcall(function() saved.WalkSpeed=SupaHum.WalkSpeed saved.JumpPower=SupaHum.JumpPower saved.PlatformStand=SupaHum.PlatformStand saved.AutoRotate=SupaHum.AutoRotate end) local hb=RunService.Heartbeat:Connect(function() if SupaRoot then pcall(function() SupaRoot.Velocity=Vector3.zero SupaRoot.RotVelocity=Vector3.zero end) end end) pcall(function() SupaHum.WalkSpeed=0 SupaHum.JumpPower=0 SupaHum.PlatformStand=true SupaHum.AutoRotate=false SupaRoot.Velocity=Vector3.zero end) for _,d in pairs(SupaChar:GetDescendants()) do if d:IsA("BodyVelocity") or d:IsA("BodyGyro") then pcall(function() d:Destroy() end) end end pcall(SupaSendDash) task.wait(0.2) pcall(function() if SupaHum then SupaHum:ChangeState(Enum.HumanoidStateType.Physics) end end) pcall(function() SupaRoot.CFrame=SupaRoot.CFrame*CFrame.Angles(math.rad(60),0,0) end) local dur=0.2 local st=tick() local fol=RunService.Heartbeat:Connect(function() if dur>tick()-st and SupaRoot and tr then pcall(function() SupaRoot.CFrame=CFrame.new(tr.Position-tr.CFrame.LookVector*0.3)*CFrame.Angles(math.rad(60),0,0) end) end end) task.wait(dur) if fol then fol:Disconnect() end if hb then hb:Disconnect() end pcall(function() SupaHum:ChangeState(Enum.HumanoidStateType.GettingUp) SupaHum.WalkSpeed=saved.WalkSpeed or 16 SupaHum.JumpPower=saved.JumpPower or 50 SupaHum.PlatformStand=saved.PlatformStand or false SupaHum.AutoRotate=saved.AutoRotate or true SupaRoot.Velocity=Vector3.zero end) end
local function SupaTrigger() if not states.Supa or SupaInCd then return end if 0.3<=tick()-SupaLastTick then SupaLastTick=tick() SupaInCd=true task.spawn(function() pcall(SupaPerform) end) task.delay(4,function() SupaInCd=false end) end end

local InstantTwistedConfig={Enabled=false,DashDuration=0.6,Delay=0.22,NoclipEnabled=true,TweenBackDist=6,TweenSpeed=1,NoclipRange=10,AimRange=10,Angle1=0,Angle2=85,Angle3=179,Angle4=70,TwistDelay=0.08}
local TwistedActiveTween=nil local TwistedNoclipConn=nil
local function TwistedSetNoclip(state) if state and InstantTwistedConfig.NoclipEnabled then if TwistedNoclipConn then TwistedNoclipConn:Disconnect() end TwistedNoclipConn=RunService.Stepped:Connect(function() local char=LocalPlayer.Character if not char or not char:FindFirstChild("HumanoidRootPart") then return end local root=char.HumanoidRootPart local params=OverlapParams.new() params.FilterType=Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances={char} local nearby=Workspace:GetPartBoundsInRadius(root.Position,InstantTwistedConfig.NoclipRange,params) for _,part in pairs(nearby) do if part:FindFirstAncestorOfClass("Model") and part.Parent:FindFirstChild("Humanoid") then part.CanCollide=false end end end) else if TwistedNoclipConn then TwistedNoclipConn:Disconnect() TwistedNoclipConn=nil end end end
local function InstantTwistedApply(root,hum) local att=Instance.new("Attachment",root) local align=Instance.new("AlignOrientation",root) align.Mode=Enum.OrientationAlignmentMode.OneAttachment align.Attachment0=att align.RigidityEnabled=false align.MaxTorque=1000000 align.Responsiveness=60 local forceOff=RunService.Heartbeat:Connect(function() hum.AutoRotate=false end) local function setAngle(angle) align.CFrame=root.CFrame*CFrame.Angles(0,math.rad(angle),0) end setAngle(-InstantTwistedConfig.Angle1) task.wait(InstantTwistedConfig.TwistDelay) if align.Parent then setAngle(InstantTwistedConfig.Angle2) end task.wait(InstantTwistedConfig.TwistDelay) if align.Parent then setAngle(-InstantTwistedConfig.Angle3) end task.wait(InstantTwistedConfig.TwistDelay) if align.Parent then setAngle(InstantTwistedConfig.Angle4) end task.wait(InstantTwistedConfig.DashDuration-(InstantTwistedConfig.TwistDelay*3)) forceOff:Disconnect() align:Destroy() att:Destroy() hum.AutoRotate=true end
local function InstantTwistedGetPos() local targetPos,dist=nil,InstantTwistedConfig.AimRange local char=LocalPlayer.Character local root=char and char:FindFirstChild("HumanoidRootPart") if not root then return nil end for _,p in pairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then local tR=p.Character:FindFirstChild("HumanoidRootPart") local tH=p.Character:FindFirstChild("Humanoid") if tR and tH and tH.Health>0 then local d=(root.Position-tR.Position).Magnitude if d<dist then dist=d local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000 local vel=tR.Velocity local pt=math.clamp(ping,0,0.2) targetPos=tR.Position+(Vector3.new(vel.X,0,vel.Z)*pt) end end end end local live=Workspace:FindFirstChild("Live") if live then for _,m in pairs(live:GetChildren()) do if m~=LocalPlayer.Character then local hr=m:FindFirstChild("HumanoidRootPart") local hm=m:FindFirstChildOfClass("Humanoid") if hr and hm and hm.Health>0 then local d=(root.Position-hr.Position).Magnitude if d<dist then dist=d local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/1000 local vel=hr.Velocity local pt=math.clamp(ping,0,0.2) targetPos=hr.Position+(Vector3.new(vel.X,0,vel.Z)*pt) end end end end end return targetPos end
local function InstantTwistedExec() local char=LocalPlayer.Character local hum=char and char:WaitForChild("Humanoid") local root=char and char:WaitForChild("HumanoidRootPart") if not hum or not root then return end local tPos=InstantTwistedGetPos() if tPos then hum.AutoRotate=false root.CFrame=CFrame.lookAt(root.Position,Vector3.new(tPos.X,root.Position.Y,tPos.Z)) end task.spawn(function() if InstantTwistedConfig.TweenBackDist>0 then if TwistedActiveTween then TwistedActiveTween:Cancel() end TwistedActiveTween=TweenService:Create(root,TweenInfo.new(InstantTwistedConfig.TweenSpeed,Enum.EasingStyle.Cubic),{CFrame=root.CFrame*CFrame.new(0,0,InstantTwistedConfig.TweenBackDist)}) TwistedActiveTween:Play() end end) task.spawn(function() TwistedSetNoclip(true) task.wait(InstantTwistedConfig.Delay) if TwistedActiveTween then TwistedActiveTween:Cancel() TwistedActiveTween=nil end FireDashQW() InstantTwistedApply(root,hum) task.wait(InstantTwistedConfig.DashDuration) TwistedSetNoclip(false) end) end

local LethalConfig={Enabled=true,DETECT="12296113986",WAIT=1.6,SNAP=0.38,VELO=62,LOCK=15} local LethalBusy=false
local function LethalGet() local _,_,HRP=GetCharacterData() if not HRP then return nil end local live=Workspace:FindFirstChild("Live") if not live then return nil end local closest=nil local cd=LethalConfig.LOCK for _,v in pairs(live:GetChildren()) do if v:IsA("Model") and v~=LocalPlayer.Character then local hrp=v:FindFirstChild("HumanoidRootPart") local hum=v:FindFirstChildOfClass("Humanoid") if hrp and hum and hum.Health>0 then local d=(HRP.Position-hrp.Position).Magnitude if d<=LethalConfig.LOCK and d<cd then cd=d closest=hrp end end end end return closest end
local function LethalExec() if LethalBusy or not states.LethalDash then return end LethalBusy=true local _,Humanoid,HRP=GetCharacterData() if not HRP or not Humanoid then LethalBusy=false return end task.wait(LethalConfig.WAIT) if not states.LethalDash then LethalBusy=false return end pcall(function() Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end) task.wait() local cur=HRP.AssemblyLinearVelocity HRP.AssemblyLinearVelocity=Vector3.new(cur.X,LethalConfig.VELO,cur.Z) FireDashQW() local target=LethalGet() if target then task.delay(0.2,function() local sT=tick() local conn conn=RunService.RenderStepped:Connect(function() if not states.LethalDash or (tick()-sT)>=LethalConfig.SNAP or not target.Parent then Humanoid.AutoRotate=true conn:Disconnect() LethalBusy=false return end Humanoid.AutoRotate=false local myPos=HRP.Position local tPos=target.Position local flat=Vector3.new(tPos.X,myPos.Y,tPos.Z) local targetCF=CFrame.new(myPos,flat) local prog=math.clamp((tick()-sT)/LethalConfig.SNAP,0.32,1) local sm=prog*prog*(3-2*prog) HRP.CFrame=HRP.CFrame:Lerp(targetCF,sm) end) end) else LethalBusy=false end end

local LoopId=math.random(1,1000000) _G.LoopDashId=LoopId local function LoopIsCurrent() return _G.LoopDashId==LoopId end
local LoopConfig={Enabled=true,loopReworkAnimDetectId="10503381238",LoopDashDelay=0.28,LoopDashJump=55,LoopDashAccuracy=15,LoopDashCancelDelay=0.4,LoopDashMode="BodyGyro",CancelEnabled=true,CooldownActive=true,NoClipEnabled=true,DashRange=8,JumpMode="Normal",JumpDelay=0.25,DashDuration=1.5,CooldownAnims={["10491993682"]=true,["10479335397"]=true,["13380255751"]=true}}
local LoopNoclip=false local LoopCd=false local LoopExecFlag=false
local function LoopClip() LoopNoclip=false local _,hum=GetCharacterData() if hum then hum.AutoRotate=true end end
local function LoopForceCancel() LoopClip() local _,_,hrp=GetCharacterData() if hrp then for _,o in pairs(hrp:GetChildren()) do if o:IsA("BodyVelocity") or o:IsA("BodyAngularVelocity") or o:IsA("AlignOrientation") or (o:IsA("Attachment") and o.Name=="LoopDashAtt") then o:Destroy() end end hrp.AssemblyLinearVelocity=Vector3.zero end end
local function LoopStartCooldown(d) if not LoopIsCurrent() or LoopCd then return end LoopCd=true task.delay(d,function() LoopCd=false end) end
local function LoopGetTorso() local char,_,myRoot=GetCharacterData() if not char or not myRoot then return nil end local params=OverlapParams.new() params.FilterType=Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances={char} local parts=Workspace:GetPartBoundsInRadius(myRoot.Position,LoopConfig.DashRange,params) local target,dist=nil,LoopConfig.DashRange for _,part in pairs(parts) do local m=part:FindFirstAncestorOfClass("Model") if m and m:FindFirstChildOfClass("Humanoid") and m~=char then local torso=m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso") or m:FindFirstChild("HumanoidRootPart") if torso then local d=(myRoot.Position-torso.Position).Magnitude if d<dist then dist=d target=torso end end end end return target end
local function LoopStartRotation(torso) local char,hum,root=GetCharacterData() if not root or not hum or not torso or not torso.Parent then LoopExecFlag=false return end local startT=os.clock() local forwardDir=(torso.Position-root.Position).Unit local sideVec=Vector3.new(-forwardDir.Z,0,forwardDir.X) local bav,ao,att0=nil,nil,nil hum.AutoRotate=false if LoopConfig.LoopDashMode=="BodyGyro" then bav=root:FindFirstChild("LoopDashBAV") or Instance.new("BodyAngularVelocity") bav.Name="LoopDashBAV" bav.MaxTorque=Vector3.new(0,1000000,0) bav.P=15000 bav.AngularVelocity=Vector3.zero bav.Parent=root elseif LoopConfig.LoopDashMode=="AlignOrientation" then ao=root:FindFirstChild("LoopDashAO") or Instance.new("AlignOrientation") ao.Name="LoopDashAO" ao.Mode=Enum.OrientationAlignmentMode.OneAttachment ao.MaxTorque=1000000 ao.Responsiveness=100 att0=root:FindFirstChild("LoopDashAtt") or Instance.new("Attachment",root) att0.Name="LoopDashAtt" ao.Attachment0=att0 ao.Parent=root end local conn conn=RunService.Heartbeat:Connect(function() if not LoopIsCurrent() or not torso or not torso.Parent or not root or not root.Parent then if bav then bav:Destroy() end if ao then ao:Destroy() end if att0 then att0:Destroy() end LoopClip() LoopExecFlag=false conn:Disconnect() return end hum.AutoRotate=false local elapsed=os.clock()-startT local torsoPos,rootPos=torso.Position,root.Position if LoopConfig.LoopDashMode=="BodyGyro" then local angle=(elapsed/0.45)*(math.pi/(LoopConfig.DashDuration/1)) local radius=LoopConfig.LoopDashAccuracy*(1-math.clamp(elapsed/(LoopConfig.DashDuration*0.3),0,1)) local targetLookPos=torsoPos+(sideVec*math.cos(angle)+forwardDir*math.sin(angle))*radius local lookAtCF=CFrame.lookAt(rootPos,Vector3.new(targetLookPos.X,rootPos.Y,targetLookPos.Z)) local rel=root.CFrame:Inverse()*lookAtCF local _,y,_=rel:ToEulerAnglesXYZ() if bav and bav.Parent then bav.AngularVelocity=Vector3.new(0,y*30,0) end elseif LoopConfig.LoopDashMode=="AlignOrientation" then local angle=(elapsed/0.45)*(math.pi/(LoopConfig.DashDuration/1)) local radius=LoopConfig.LoopDashAccuracy*(1-math.clamp(elapsed/(LoopConfig.DashDuration*0.3),0,1)) local targetLookPos=torsoPos+(sideVec*math.cos(angle)+forwardDir*math.sin(angle))*radius if ao and ao.Parent then ao.CFrame=CFrame.lookAt(rootPos,Vector3.new(targetLookPos.X,rootPos.Y,targetLookPos.Z)) end end local distXZ=(Vector2.new(rootPos.X,rootPos.Z)-Vector2.new(torsoPos.X,torsoPos.Z)).Magnitude if (LoopConfig.CancelEnabled and elapsed>LoopConfig.LoopDashCancelDelay and distXZ<2.2) or elapsed>LoopConfig.DashDuration or not states.LoopDash then if bav then bav:Destroy() end if ao then ao:Destroy() end if att0 then att0:Destroy() end LoopForceCancel() LoopExecFlag=false conn:Disconnect() return end end) end
local function LoopExecute() if not LoopIsCurrent() or LoopExecFlag or LoopCd or not states.LoopDash then return end local char,_,root=GetCharacterData() if not root then return end local torso=LoopGetTorso() if not torso then LoopClip() return end LoopExecFlag=true local pre pre=RunService.Heartbeat:Connect(function() if not LoopExecFlag or not torso or not torso.Parent or not root or not root.Parent then if pre then pre:Disconnect() end return end local _,hum=GetCharacterData() if hum then hum.AutoRotate=false end root.CFrame=CFrame.lookAt(root.Position,Vector3.new(torso.Position.X,root.Position.Y,torso.Position.Z)) end) task.spawn(function() if LoopConfig.JumpMode=="Normal" then task.wait(math.max(0,LoopConfig.LoopDashDelay-0.03)) if not LoopIsCurrent() or not torso.Parent or not root.Parent then if pre then pre:Disconnect() end LoopExecFlag=false return end root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,LoopConfig.LoopDashJump,root.AssemblyLinearVelocity.Z) LoopNoclip=true task.wait(0.03) if pre then pre:Disconnect() end FireDashQW() LoopStartRotation(torso) else task.spawn(function() task.wait(LoopConfig.JumpDelay) if LoopIsCurrent() and states.LoopDash and root.Parent then root.AssemblyLinearVelocity=Vector3.new(root.AssemblyLinearVelocity.X,LoopConfig.LoopDashJump,root.AssemblyLinearVelocity.Z) end end) task.wait(LoopConfig.LoopDashDelay) if not LoopIsCurrent() or not torso.Parent or not root.Parent then if pre then pre:Disconnect() end LoopExecFlag=false return end if pre then pre:Disconnect() end LoopNoclip=true FireDashQW() LoopStartRotation(torso) end end) end

local function handleAnim(track) if not track or not track.Animation then return end local animId=tostring(track.Animation.AnimationId or "") local numId=animId:match("%d+") pcall(function() if states.KingTech and KT.a and animId:find(O.DA,1,true) then task.spawn(k1ngTechExecution) end end) pcall(function() if states.XCZ and animId==VuxTbl.LethalAnim then VuxFlickExecute() end if VuxTbl.CooldownActive and VuxTbl.CooldownAnims[numId or ""] then VuxFlag2=true task.delay(5,function() VuxFlag2=false end) end end) pcall(function() if states.LethalDash and animId:find(LethalConfig.DETECT,1,true) then task.spawn(LethalExec) end end) pcall(function() if states.LoopDash and numId==LoopConfig.loopReworkAnimDetectId:match("%d+") then LoopExecute() end if LoopConfig.CooldownAnims[numId or ""] then LoopStartCooldown(5) end end) pcall(function() if states.Supa and (animId:find("10503381238",1,true) or animId:find("13379003796",1,true)) then task.delay(0.3,function() SupaTrigger() end) end end) pcall(function() if states.InstantTwisted and animId:find("13294471966",1,true) then task.spawn(InstantTwistedExec) end end) end
local conns={} local function SetupChar(c) for _,cn in pairs(conns) do pcall(function() cn:Disconnect() end) end conns={} local hum=c:WaitForChild("Humanoid") SupaChar=c SupaHum=hum SupaRoot=c:WaitForChild("HumanoidRootPart") local ok1,con1=pcall(function() return hum.AnimationPlayed:Connect(handleAnim) end) if ok1 and con1 then table.insert(conns,con1) end local anim=hum:FindFirstChildOfClass("Animator") if anim then local ok2,con2=pcall(function() return anim.AnimationPlayed:Connect(handleAnim) end) if ok2 and con2 then table.insert(conns,con2) end end end
LocalPlayer.CharacterAdded:Connect(SetupChar) if LocalPlayer.Character then SetupChar(LocalPlayer.Character) end
RunService.Stepped:Connect(function() if (LoopConfig.NoClipEnabled and LoopNoclip) or (VuxTbl.NoClipEnabled and VuxFlag) or (InstantTwistedConfig.NoclipEnabled and TwistedNoclipConn) then local c=LocalPlayer.Character if c then for _,p in pairs(c:GetChildren()) do if p:IsA("BasePart") then p.CanCollide=false end end end end end)

local SavedConfigs = {}
_G.MNK_Configs = _G.MNK_Configs or {}
SavedConfigs = _G.MNK_Configs

local function GetCurrentConfigTable()
    return {
        v = 11.1,
        KT = {d=KT.d, e=KT.e, f=KT.f, g=KT.g, h=KT.h, i=KT.i, j=KT.j, k=KT.k, k1ngJump=KT.k1ngJump, CharacterTilt=KT.CharacterTilt},
        Loop = {DashRange=LoopConfig.DashRange, LoopDashDelay=LoopConfig.LoopDashDelay, LoopDashJump=LoopConfig.LoopDashJump, LoopDashAccuracy=LoopConfig.LoopDashAccuracy, LoopDashCancelDelay=LoopConfig.LoopDashCancelDelay, DashDuration=LoopConfig.DashDuration, JumpDelay=LoopConfig.JumpDelay, LoopDashMode=LoopConfig.LoopDashMode, JumpMode=LoopConfig.JumpMode},
        XCZ = {LethalDelay=VuxTbl.LethalDelay, LethalJump=VuxTbl.LethalJump, FlickDelay=VuxTbl.FlickDelay, Smoothness=VuxTbl.Smoothness, LethalCancelDelay=VuxTbl.LethalCancelDelay, DashRange=VuxTbl.DashRange},
        InstantTwisted = {DashDuration=InstantTwistedConfig.DashDuration, Delay=InstantTwistedConfig.Delay, TweenBackDist=InstantTwistedConfig.TweenBackDist, TweenSpeed=InstantTwistedConfig.TweenSpeed, NoclipRange=InstantTwistedConfig.NoclipRange, AimRange=InstantTwistedConfig.AimRange, Angle1=InstantTwistedConfig.Angle1, Angle2=InstantTwistedConfig.Angle2, Angle3=InstantTwistedConfig.Angle3, Angle4=InstantTwistedConfig.Angle4, TwistDelay=InstantTwistedConfig.TwistDelay, NoclipEnabled=InstantTwistedConfig.NoclipEnabled},
        Lethal = {WAIT=LethalConfig.WAIT, VELO=LethalConfig.VELO, LOCK=LethalConfig.LOCK, SNAP=LethalConfig.SNAP},
        States = {KingTech=states.KingTech, XCZ=states.XCZ, LethalDash=states.LethalDash, LoopDash=states.LoopDash, Supa=states.Supa, InstantTwisted=states.InstantTwisted, AntiLag=states.AntiLag}
    }
end

local function ApplyConfigTable(t)
    if not t then return false end
    pcall(function()
        if t.KT then KT.d=t.KT.d or KT.d KT.e=t.KT.e or KT.e KT.f=t.KT.f or KT.f KT.g=t.KT.g or KT.g KT.h=t.KT.h or KT.h KT.i=t.KT.i or KT.i KT.j=t.KT.j or KT.j KT.k=t.KT.k or KT.k KT.k1ngJump=t.KT.k1ngJump or KT.k1ngJump KT.CharacterTilt=t.KT.CharacterTilt or KT.CharacterTilt end
        if t.Loop then LoopConfig.DashRange=t.Loop.DashRange or LoopConfig.DashRange LoopConfig.LoopDashDelay=t.Loop.LoopDashDelay or LoopConfig.LoopDashDelay LoopConfig.LoopDashJump=t.Loop.LoopDashJump or LoopConfig.LoopDashJump LoopConfig.LoopDashAccuracy=t.Loop.LoopDashAccuracy or LoopConfig.LoopDashAccuracy LoopConfig.LoopDashCancelDelay=t.Loop.LoopDashCancelDelay or LoopConfig.LoopDashCancelDelay LoopConfig.DashDuration=t.Loop.DashDuration or LoopConfig.DashDuration LoopConfig.JumpDelay=t.Loop.JumpDelay or LoopConfig.JumpDelay LoopConfig.LoopDashMode=t.Loop.LoopDashMode or LoopConfig.LoopDashMode LoopConfig.JumpMode=t.Loop.JumpMode or LoopConfig.JumpMode end
        if t.XCZ then VuxTbl.LethalDelay=t.XCZ.LethalDelay or VuxTbl.LethalDelay VuxTbl.LethalJump=t.XCZ.LethalJump or VuxTbl.LethalJump VuxTbl.FlickDelay=t.XCZ.FlickDelay or VuxTbl.FlickDelay VuxTbl.Smoothness=t.XCZ.Smoothness or VuxTbl.Smoothness VuxTbl.LethalCancelDelay=t.XCZ.LethalCancelDelay or VuxTbl.LethalCancelDelay VuxTbl.DashRange=t.XCZ.DashRange or VuxTbl.DashRange end
        if t.InstantTwisted then InstantTwistedConfig.DashDuration=t.InstantTwisted.DashDuration or InstantTwistedConfig.DashDuration InstantTwistedConfig.Delay=t.InstantTwisted.Delay or InstantTwistedConfig.Delay InstantTwistedConfig.TweenBackDist=t.InstantTwisted.TweenBackDist or InstantTwistedConfig.TweenBackDist InstantTwistedConfig.TweenSpeed=t.InstantTwisted.TweenSpeed or InstantTwistedConfig.TweenSpeed InstantTwistedConfig.NoclipRange=t.InstantTwisted.NoclipRange or InstantTwistedConfig.NoclipRange InstantTwistedConfig.AimRange=t.InstantTwisted.AimRange or InstantTwistedConfig.AimRange InstantTwistedConfig.Angle1=t.InstantTwisted.Angle1 or InstantTwistedConfig.Angle1 InstantTwistedConfig.Angle2=t.InstantTwisted.Angle2 or InstantTwistedConfig.Angle2 InstantTwistedConfig.Angle3=t.InstantTwisted.Angle3 or InstantTwistedConfig.Angle3 InstantTwistedConfig.Angle4=t.InstantTwisted.Angle4 or InstantTwistedConfig.Angle4 InstantTwistedConfig.TwistDelay=t.InstantTwisted.TwistDelay or InstantTwistedConfig.TwistDelay InstantTwistedConfig.NoclipEnabled = t.InstantTwisted.NoclipEnabled~=nil and t.InstantTwisted.NoclipEnabled or InstantTwistedConfig.NoclipEnabled end
        if t.Lethal then LethalConfig.WAIT=t.Lethal.WAIT or LethalConfig.WAIT LethalConfig.VELO=t.Lethal.VELO or LethalConfig.VELO LethalConfig.LOCK=t.Lethal.LOCK or LethalConfig.LOCK LethalConfig.SNAP=t.Lethal.SNAP or LethalConfig.SNAP end
    end)
    return true
end

local function EncodeConfigToCode(tbl)
    local ok, json = pcall(function() return HttpService:JSONEncode(tbl) end)
    if not ok then return nil end
    return "MNK11_"..json
end

local function DecodeCodeToConfig(code)
    if not code or code=="" then return nil end
    local json = code
    if code:sub(1,6)=="MNK11_" then json = code:sub(7) end
    local ok, tbl = pcall(function() return HttpService:JSONDecode(json) end)
    if ok then return tbl else return nil end
end



-- ===== XCZ AUTO TP TO ENEMY HEAD (FROG JUMP) - ADDED FEATURE - EVERYTHING ELSE SAME =====
local XCZ_TP = {
    Enabled = true,
    TP_Delay = 0.24,
    TP_Height = 2,
    MagnetEnabled = true,
    MagnetDuration = 0.5,
    MagnetStrength = 50,
    MaxTPDistance = 25,
    DashCancel = true,
}

local npcList = {}
local lastNpcUpdate = 0
local pullConnection = nil
local dashVelocity = nil

local function updateNpcCache()
    npcList = {}
    local root = nil
    pcall(function() root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") end)
    for _, model in ipairs(Workspace:GetDescendants()) do
        if model:IsA("Model") and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
            local r = model.HumanoidRootPart
            if r ~= root then
                table.insert(npcList, r)
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    if tick() - lastNpcUpdate > 0.5 then
        lastNpcUpdate = tick()
        pcall(updateNpcCache)
    end
end)

local function getClosestTarget()
    local _,_,myRoot = GetCharacterData()
    if not myRoot then return nil end
    local closestRoot = nil
    local shortestDistance = XCZ_TP.MaxTPDistance
    local myPos = myRoot.Position
    
    -- Live folder (TSB players) - best for TSB
    local live = Workspace:FindFirstChild("Live")
    if live then
        for _, model in ipairs(live:GetChildren()) do
            if model:IsA("Model") and model ~= LocalPlayer.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                local root = model:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and root then
                    local dist = (myPos - root.Position).Magnitude
                    if dist < shortestDistance and dist > 0.5 then
                        shortestDistance = dist
                        closestRoot = root
                    end
                end
            end
        end
    end
    
    -- Players fallback
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                local dist = (myPos - root.Position).Magnitude
                if dist < shortestDistance and dist > 0.5 then
                    shortestDistance = dist
                    closestRoot = root
                end
            end
        end
    end
    
    -- NPC cache fallback
    for _, npcRoot in ipairs(npcList) do
        if npcRoot and npcRoot.Parent then
            local dist = (myPos - npcRoot.Position).Magnitude
            if dist < shortestDistance and dist > 0.5 then
                shortestDistance = dist
                closestRoot = npcRoot
            end
        end
    end
    
    return closestRoot
end

local function startMagnetPull()
    if not XCZ_TP.MagnetEnabled then return end
    if pullConnection then pcall(function() pullConnection:Disconnect() end) pullConnection = nil end
    local startTime = tick()
    local pullDuration = XCZ_TP.MagnetDuration
    local pullStrength = XCZ_TP.MagnetStrength
    local smoothness = 0.65
    pullConnection = RunService.Heartbeat:Connect(function()
        local _,_,rootPart = GetCharacterData()
        if not rootPart or not rootPart.Parent then
            if pullConnection then pullConnection:Disconnect() pullConnection = nil end
            return
        end
        local elapsed = tick() - startTime
        if elapsed >= pullDuration then
            if pullConnection then pullConnection:Disconnect() pullConnection = nil end
            return
        end
        local targetRoot = getClosestTarget()
        if not targetRoot then return end
        local currentPos = rootPart.Position
        local targetHorizontal = Vector3.new(targetRoot.Position.X, currentPos.Y, targetRoot.Position.Z)
        local direction = (targetHorizontal - currentPos)
        local distance = direction.Magnitude
        if distance > 1 then
            direction = direction.Unit
            local desiredVel = direction * pullStrength
            local currentVel = rootPart.AssemblyLinearVelocity
            local newVel = currentVel:Lerp(desiredVel, smoothness)
            rootPart.AssemblyLinearVelocity = Vector3.new(newVel.X * 0.85, currentVel.Y, newVel.Z * 0.85)
        end
    end)
end

local function doXCZ_TP_ToHead()
    if not XCZ_TP.Enabled then return end
    local char,hum,rootPart = GetCharacterData()
    if not rootPart or not char then return end
    
    -- Get closest target within max distance
    local targetRoot = getClosestTarget()
    if not targetRoot then return end
    
    -- Wait TP_DELAY like solitude source
    task.wait(XCZ_TP.TP_Delay)
    
    char,hum,rootPart = GetCharacterData()
    if not rootPart or not rootPart.Parent then return end
    if not targetRoot or not targetRoot.Parent then return end
    
    -- TP 2 studs above enemy head (frog jump easy)
    local targetPos = targetRoot.Position + Vector3.new(0, XCZ_TP.TP_Height, 0)
    rootPart.CFrame = CFrame.new(targetPos)
    
    -- Dash cancel (Q) - like combined source
    if XCZ_TP.DashCancel then
        if rootPart then
            for _, child in ipairs(rootPart:GetChildren()) do
                if child:IsA("BodyVelocity") or child:IsA("LinearVelocity") then
                    pcall(function() child:Destroy() end)
                end
            end
            local vel = rootPart.AssemblyLinearVelocity
            rootPart.AssemblyLinearVelocity = Vector3.new(0, vel.Y, 0)
        end
    end
    
    -- Start magnet pull after TP
    startMagnetPull()
    
    pcall(function() Notify("XCZ TP to Head! Frog Jump Ready") end)
end

-- Hook into XCZ execution - run TP after dash ends
local oldVuxFire = nil
pcall(function()
    -- Hook the character ChildAdded for dashVelocity detection (like both sources)
    local function setupDashDetection(newChar)
        local root = newChar:WaitForChild("HumanoidRootPart", 10)
        if not root then return end
        root.ChildAdded:Connect(function(child)
            if child:IsA("BodyVelocity") or child:IsA("LinearVelocity") then
                dashVelocity = child
            end
        end)
    end
    if LocalPlayer.Character then setupDashDetection(LocalPlayer.Character) end
    LocalPlayer.CharacterAdded:Connect(setupDashDetection)
end)

-- Auto trigger after XCZ animation
local XCZ_AnimIds = {"10479335397", "13380255751", "10491993682"}
local xczAnimConnection = nil
local function setupXCZTPHook(char)
    local hum = char:WaitForChild("Humanoid", 10)
    if not hum then return end
    if xczAnimConnection then pcall(function() xczAnimConnection:Disconnect() end) end
    xczAnimConnection = hum.AnimationPlayed:Connect(function(track)
        local animId = track.Animation.AnimationId
        for _, id in ipairs(XCZ_AnimIds) do
            if animId:find(id) then
                if states.XCZ and XCZ_TP.Enabled then
                    task.spawn(function()
                        task.wait(0.05)
                        doXCZ_TP_ToHead()
                    end)
                end
                break
            end
        end
    end)
end

if LocalPlayer.Character then setupXCZTPHook(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char) task.wait(0.5) setupXCZTPHook(char) end)

_G.XCZ_TP = XCZ_TP
_G.doXCZ_TP_ToHead = doXCZ_TP_ToHead


-- ===== BEST UI - EVERYTHING SAME EXCEPT XCZ ADDED TP =====

local KingTab = Window:Tab({ Title = "King Tech", Icon = "crown", Locked = false })
local KingSection = KingTab:Section({ Title = "King Tech [FROM FILE215 - EXACT LIKE BEFORE]", Opened = true })
KingSection:Toggle({ Title = "Enable King Tech", Desc = "Works like before", Icon = "crown", Type = "Checkbox", Value = states.KingTech, Callback = function(v) states.KingTech=v KT.a=v Notify("King "..(v and "ON" or "OFF")) end })
KingSection:Section({ Title = "King Config", Opened = true })
KingSection:Input({ Title = "d delay (2.9)", Value = tostring(KT.d), Type = "Input", Callback = function(v) KT.d=tonumber(v) or 2.9 end })
KingSection:Input({ Title = "e wait (0)", Value = tostring(KT.e), Type = "Input", Callback = function(v) KT.e=tonumber(v) or 0 end })
KingSection:Input({ Title = "f lock (0.5)", Value = tostring(KT.f), Type = "Input", Callback = function(v) KT.f=tonumber(v) or 0.5 end })
KingSection:Input({ Title = "g duration (10)", Value = tostring(KT.g), Type = "Input", Callback = function(v) KT.g=tonumber(v) or 10 end })
KingSection:Input({ Title = "h range (150)", Value = tostring(KT.h), Type = "Input", Callback = function(v) KT.h=tonumber(v) or 150 end })
KingSection:Input({ Title = "i cooldown (40)", Value = tostring(KT.i), Type = "Input", Callback = function(v) KT.i=tonumber(v) or 40 end })
KingSection:Input({ Title = "j smooth (836)", Value = tostring(KT.j), Type = "Input", Callback = function(v) KT.j=tonumber(v) or 836 end })
KingSection:Input({ Title = "k velocity (46)", Value = tostring(KT.k), Type = "Input", Callback = function(v) KT.k=tonumber(v) or 46 end })
KingSection:Input({ Title = "CharacterTilt (60)", Value = tostring(KT.CharacterTilt), Type = "Input", Callback = function(v) KT.CharacterTilt=tonumber(v) or 60 end })
KingSection:Input({ Title = "k1ngJump (0)", Value = tostring(KT.k1ngJump), Type = "Input", Callback = function(v) KT.k1ngJump=tonumber(v) or 0 end })

local LoopTab = Window:Tab({ Title = "Loop Dash", Icon = "repeat", Locked = false })
local LoopSection = LoopTab:Section({ Title = "Loop Dash - Like Before", Opened = true })
LoopSection:Toggle({ Title = "Enable Loop Dash", Value = states.LoopDash, Type = "Checkbox", Callback = function(v) states.LoopDash=v LoopConfig.Enabled=v Notify("Loop "..(v and "ON" or "OFF")) end })
LoopSection:Section({ Title = "Loop Config", Opened = true })
LoopSection:Input({ Title = "DashRange (8)", Value = tostring(LoopConfig.DashRange), Type = "Input", Callback = function(v) LoopConfig.DashRange=tonumber(v) or 8 end })
LoopSection:Input({ Title = "LoopDashDelay (0.28)", Value = tostring(LoopConfig.LoopDashDelay), Type = "Input", Callback = function(v) LoopConfig.LoopDashDelay=tonumber(v) or 0.28 end })
LoopSection:Input({ Title = "LoopDashJump (55)", Value = tostring(LoopConfig.LoopDashJump), Type = "Input", Callback = function(v) LoopConfig.LoopDashJump=tonumber(v) or 55 end })
LoopSection:Input({ Title = "Accuracy (15)", Value = tostring(LoopConfig.LoopDashAccuracy), Type = "Input", Callback = function(v) LoopConfig.LoopDashAccuracy=tonumber(v) or 15 end })
LoopSection:Input({ Title = "CancelDelay (0.4)", Value = tostring(LoopConfig.LoopDashCancelDelay), Type = "Input", Callback = function(v) LoopConfig.LoopDashCancelDelay=tonumber(v) or 0.4 end })
LoopSection:Input({ Title = "Duration (1.5)", Value = tostring(LoopConfig.DashDuration), Type = "Input", Callback = function(v) LoopConfig.DashDuration=tonumber(v) or 1.5 end })
LoopSection:Dropdown({ Title = "Loop Mode", Values = {"BodyGyro","AlignOrientation","Standard"}, Value = LoopConfig.LoopDashMode, Callback = function(v) LoopConfig.LoopDashMode=v end })

local XCZTab = Window:Tab({ Title = "XCZ Flick", Icon = "zap", Locked = false })
local XCZSection = XCZTab:Section({ Title = "XCZ Flick - Like Before + Auto TP Head", Opened = true })
XCZSection:Toggle({ Title = "Enable XCZ Flick", Value = states.XCZ, Type = "Checkbox", Callback = function(v) states.XCZ=v VuxTbl.Enabled=v Notify("XCZ "..(v and "ON" or "OFF")) end })
XCZSection:Section({ Title = "XCZ Config - Like Before", Opened = true })
XCZSection:Input({ Title = "LethalDelay (0.285)", Value = tostring(VuxTbl.LethalDelay), Type = "Input", Callback = function(v) VuxTbl.LethalDelay=tonumber(v) or 0.285 end })
XCZSection:Input({ Title = "FlickDelay (0.25)", Value = tostring(VuxTbl.FlickDelay), Type = "Input", Callback = function(v) VuxTbl.FlickDelay=tonumber(v) or 0.25 end })
XCZSection:Input({ Title = "LethalJump (55)", Value = tostring(VuxTbl.LethalJump), Type = "Input", Callback = function(v) VuxTbl.LethalJump=tonumber(v) or 55 end })
XCZSection:Input({ Title = "Smoothness (500)", Value = tostring(VuxTbl.Smoothness), Type = "Input", Callback = function(v) VuxTbl.Smoothness=tonumber(v) or 500 end })
XCZSection:Input({ Title = "DashRange (25)", Value = tostring(VuxTbl.DashRange), Type = "Input", Callback = function(v) VuxTbl.DashRange=tonumber(v) or 25 end })

-- NEW XCZ AUTO TP FEATURE - ONLY NEW PART
XCZSection:Section({ Title = "XCZ AUTO TP TO HEAD (FROG JUMP) - NEW!", Opened = true })
XCZSection:Toggle({ Title = "Enable Auto TP to Head", Desc = "After XCZ dash ends, TPs to enemy head for easy frog jump", Value = XCZ_TP.Enabled, Type = "Checkbox", Callback = function(v) XCZ_TP.Enabled=v WindUI:Notify({ Title = "XCZ TP", Content = "Auto TP Head "..(v and "ON" or "OFF"), Duration = 2 }) end })
XCZSection:Input({ Title = "TP Delay (0.24)", Desc = "Delay after dash before TP - from Solitude source", Value = tostring(XCZ_TP.TP_Delay), Type = "Input", Callback = function(v) XCZ_TP.TP_Delay=tonumber(v) or 0.24 end })
XCZSection:Input({ Title = "TP Height (2)", Desc = "Studs above enemy head", Value = tostring(XCZ_TP.TP_Height), Type = "Input", Callback = function(v) XCZ_TP.TP_Height=tonumber(v) or 2 end })
XCZSection:Input({ Title = "Max TP Distance (25)", Desc = "Max distance to find enemy", Value = tostring(XCZ_TP.MaxTPDistance), Type = "Input", Callback = function(v) XCZ_TP.MaxTPDistance=tonumber(v) or 25 end })
XCZSection:Toggle({ Title = "Magnet Pull After TP", Desc = "Pull towards enemy after TP - from Combined source", Value = XCZ_TP.MagnetEnabled, Type = "Checkbox", Callback = function(v) XCZ_TP.MagnetEnabled=v end })
XCZSection:Input({ Title = "Magnet Duration (0.5)", Value = tostring(XCZ_TP.MagnetDuration), Type = "Input", Callback = function(v) XCZ_TP.MagnetDuration=tonumber(v) or 0.5 end })
XCZSection:Input({ Title = "Magnet Strength (50)", Value = tostring(XCZ_TP.MagnetStrength), Type = "Input", Callback = function(v) XCZ_TP.MagnetStrength=tonumber(v) or 50 end })
XCZSection:Toggle({ Title = "Dash Cancel After TP", Desc = "Cancels dash velocity (Q action)", Value = XCZ_TP.DashCancel, Type = "Checkbox", Callback = function(v) XCZ_TP.DashCancel=v end })
XCZSection:Button({ Title = "Test TP to Head Now", Locked = false, Callback = function() _G.doXCZ_TP_ToHead() end })

local InstantTab = Window:Tab({ Title = "Instant Twisted", Icon = "wind", Locked = false })
local InstantSection = InstantTab:Section({ Title = "Instant Twisted [FULL 12 CONFIGS]", Opened = true })
InstantSection:Toggle({ Title = "Enable Instant Twisted", Value = states.InstantTwisted, Type = "Checkbox", Callback = function(v) states.InstantTwisted=v InstantTwistedConfig.Enabled=v Notify("Instant Twisted "..(v and "ON" or "OFF")) end })
InstantSection:Section({ Title = "Instant Twisted Config", Opened = true })
InstantSection:Input({ Title = "DashDuration (0.6)", Value = tostring(InstantTwistedConfig.DashDuration), Type = "Input", Callback = function(v) InstantTwistedConfig.DashDuration=tonumber(v) or 0.6 end })
InstantSection:Input({ Title = "Delay (0.22)", Value = tostring(InstantTwistedConfig.Delay), Type = "Input", Callback = function(v) InstantTwistedConfig.Delay=tonumber(v) or 0.22 end })
InstantSection:Input({ Title = "TweenBackDist (6)", Value = tostring(InstantTwistedConfig.TweenBackDist), Type = "Input", Callback = function(v) InstantTwistedConfig.TweenBackDist=tonumber(v) or 6 end })
InstantSection:Input({ Title = "TweenSpeed (1)", Value = tostring(InstantTwistedConfig.TweenSpeed), Type = "Input", Callback = function(v) InstantTwistedConfig.TweenSpeed=tonumber(v) or 1 end })
InstantSection:Input({ Title = "NoclipRange (10)", Value = tostring(InstantTwistedConfig.NoclipRange), Type = "Input", Callback = function(v) InstantTwistedConfig.NoclipRange=tonumber(v) or 10 end })
InstantSection:Input({ Title = "AimRange (10)", Value = tostring(InstantTwistedConfig.AimRange), Type = "Input", Callback = function(v) InstantTwistedConfig.AimRange=tonumber(v) or 10 end })
InstantSection:Input({ Title = "Angle1 (0)", Value = tostring(InstantTwistedConfig.Angle1), Type = "Input", Callback = function(v) InstantTwistedConfig.Angle1=tonumber(v) or 0 end })
InstantSection:Input({ Title = "Angle2 (85)", Value = tostring(InstantTwistedConfig.Angle2), Type = "Input", Callback = function(v) InstantTwistedConfig.Angle2=tonumber(v) or 85 end })
InstantSection:Input({ Title = "Angle3 (179)", Value = tostring(InstantTwistedConfig.Angle3), Type = "Input", Callback = function(v) InstantTwistedConfig.Angle3=tonumber(v) or 179 end })
InstantSection:Input({ Title = "Angle4 (70)", Value = tostring(InstantTwistedConfig.Angle4), Type = "Input", Callback = function(v) InstantTwistedConfig.Angle4=tonumber(v) or 70 end })
InstantSection:Input({ Title = "TwistDelay (0.08)", Value = tostring(InstantTwistedConfig.TwistDelay), Type = "Input", Callback = function(v) InstantTwistedConfig.TwistDelay=tonumber(v) or 0.08 end })

local OtherTab = Window:Tab({ Title = "Other", Icon = "box", Locked = false })
local OtherSection = OtherTab:Section({ Title = "Other Techs", Opened = true })
OtherSection:Toggle({ Title = "Lethal Dash", Value = states.LethalDash, Type = "Checkbox", Callback = function(v) states.LethalDash=v LethalConfig.Enabled=v Notify("Lethal "..(v and "ON" or "OFF")) end })
OtherSection:Toggle({ Title = "Supa", Value = states.Supa, Type = "Checkbox", Callback = function(v) states.Supa=v Notify("Supa "..(v and "ON" or "OFF")) end })

local ConfigTab = Window:Tab({ Title = "Config", Icon = "save", Locked = false })
local ConfigSection = ConfigTab:Section({ Title = "Config Save/Load + Share Codes", Opened = true })
ConfigSection:Input({ Title = "Config Name", Value = "", Placeholder = "e.g. my legit", Type = "Input", Callback = function(v) _G.ConfigNameInput=v end })
ConfigSection:Input({ Title = "Share Code Box", Value = "", Placeholder = "MNK21_... code", Type = "Input", Callback = function(v) _G.ShareCodeBoxInput=v end })
ConfigSection:Button({ Title = "SAVE AS NAMED CONFIG", Locked = false, Callback = function()
    local name = _G.ConfigNameInput or ""
    if name=="" then WindUI:Notify({ Title = "Config", Content = "Enter name!", Duration = 2 }) return end
    local cfg=GetCurrentConfigTable() cfg.name=name cfg.savedAt=os.date("%Y-%m-%d %H:%M")
    cfg.XCZ_TP = XCZ_TP
    SavedConfigs[name]=cfg _G.MNK_Configs=SavedConfigs
    local code=EncodeConfigToCode(cfg)
    _G.ShareCodeBoxInput=code
    pcall(function() if writefile then writefile("mnk_d3vxz_configs.json", HttpService:JSONEncode(SavedConfigs)) end if setclipboard then setclipboard(code) end end)
    WindUI:Notify({ Title = "Config", Content = "Saved: "..name, Duration = 3 })
end })
ConfigSection:Button({ Title = "LOAD NAMED CONFIG", Locked = false, Callback = function()
    local name = _G.ConfigNameInput or ""
    local cfg=SavedConfigs[name]
    pcall(function() if not cfg and readfile and isfile and isfile("mnk_d3vxz_configs.json") then local data=readfile("mnk_d3vxz_configs.json") local decoded=HttpService:JSONDecode(data) SavedConfigs=decoded _G.MNK_Configs=decoded cfg=decoded[name] end end)
    if cfg then ApplyConfigTable(cfg) if cfg.XCZ_TP then for k,v in pairs(cfg.XCZ_TP) do XCZ_TP[k]=v end end WindUI:Notify({ Title = "Config", Content = "Loaded: "..name, Duration = 3 }) else WindUI:Notify({ Title = "Config", Content = "Not found: "..name, Duration = 3 }) end
end })
ConfigSection:Button({ Title = "EXPORT CODE (COPY)", Locked = false, Callback = function()
    local cfg=GetCurrentConfigTable() cfg.XCZ_TP = XCZ_TP local code=EncodeConfigToCode(cfg)
    _G.ShareCodeBoxInput=code
    pcall(function() if setclipboard then setclipboard(code) end end)
    WindUI:Notify({ Title = "Config", Content = "Code exported!", Duration = 3 })
end })
ConfigSection:Button({ Title = "IMPORT CODE FROM BOX", Locked = false, Callback = function()
    local code=_G.ShareCodeBoxInput or "" local tbl=DecodeCodeToConfig(code)
    if tbl then ApplyConfigTable(tbl) if tbl.XCZ_TP then for k,v in pairs(tbl.XCZ_TP) do XCZ_TP[k]=v end end if tbl.name then SavedConfigs[tbl.name]=tbl end WindUI:Notify({ Title = "Config", Content = "Imported!", Duration = 3 }) else WindUI:Notify({ Title = "Config", Content = "Invalid code!", Duration = 3 }) end
end })

local AntiTab = Window:Tab({ Title = "Anti Lag", Icon = "shield", Locked = false })
local AntiSection = AntiTab:Section({ Title = "Anti Lag System", Opened = true })
AntiSection:Toggle({ Title = "Anti Lag", Value = states.AntiLag, Type = "Checkbox", Callback = function(v) states.AntiLag=v if v then AntiLag:Apply() else AntiLag:Restore() end end })
AntiSection:Button({ Title = "Deep Clean Particles", Locked = false, Callback = function() local n=AntiLag:DeepClean() WindUI:Notify({ Title = "Anti Lag", Content = "Cleaned "..n, Duration = 2 }) end })
AntiSection:Button({ Title = "FPS BOOST 999", Locked = false, Callback = function() pcall(function() setfpscap(999) settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 Lighting.GlobalShadows=false AntiLag:DeepClean() end) WindUI:Notify({ Title = "Boost", Content = "FPS Boosted", Duration = 2 }) end })

WindUI:Notify({
    Title = "mnk / d3vxz v21 XCZ TP HEAD",
    Content = "Developer- d3vxz | Everything same except XCZ now TPs to head for frog jump!",
    Duration = 5
})

Notify("v21 XCZ TP Head Loaded - Developer- d3vxz!")
