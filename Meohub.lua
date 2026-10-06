local P,RS,LP=game:GetService("Players"),game:GetService("RunService"),game:GetService("Players").LocalPlayer;
local SG=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"));
SG.Name,SG.ResetOnSpawn="FP_Gui",false;

local BT=Instance.new("ImageButton",SG);
BT.Size,BT.Position,BT.BackgroundColor3,BT.BorderSizePixel=UDim2.new(0,50,0,50),UDim2.new(0.05,0,0.15,0),Color3.fromRGB(18,18,22),0;
local UIC=Instance.new("UICorner",BT);UIC.CornerRadius=UDim.new(1,0);
local UIST=Instance.new("UIStroke",BT);UIST.Color,UIST.Thickness=Color3.fromRGB(0,255,150),2;
BT.Active,BT.Draggable=true,true;

local BL=Instance.new("TextLabel",BT);
BL.Size,BL.BackgroundTransparency,BL.Text,BL.TextColor3,BL.TextSize,BL.Font=UDim2.new(1,0,1,0),true,"M",Color3.fromRGB(255,40,90),22,Enum.Font.GothamBold;

local MF=Instance.new("Frame",SG);
MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,260,0,390),UDim2.new(0.05,0,0.2,0),Color3.fromRGB(12,12,16),true,true;
MF.BorderSizePixel=0;MF.Visible=false;
local MFC=Instance.new("UICorner",MF);MFC.CornerRadius=UDim.new(0,10);
local MFSt=Instance.new("UIStroke",MF);MFSt.Color,MFSt.Thickness=Color3.fromRGB(0,255,150),2;

task.spawn(function()
    while true do 
        for i=0,1,0.01 do 
            MFSt.Color=Color3.fromHSV(i,1,1);
            task.wait(0.05)
        end 
    end 
end);

BT.MouseButton1Click:Connect(function() MF.Visible=not MF.Visible end);

local T=Instance.new("TextLabel",MF);
T.Size,T.BackgroundColor3,T.Text,T.TextColor3,T.TextSize,T.Font,T.TextXAlignment=UDim2.new(1,0,0,35),Color3.fromRGB(20,20,26),"  🐱 MEOW HUB v2 (ULTIMATE)",Color3.fromRGB(0,255,150),15,Enum.Font.GothamBold,Enum.TextXAlignment.Left;
T.Position=UDim2.new(0,0,0,0);
local TC=Instance.new("UICorner",T);TC.CornerRadius=UDim.new(0,10);

local ST=Instance.new("TextLabel",MF);
ST.Size,ST.Position,ST.BackgroundTransparency,ST.Text,ST.TextColor3,ST.TextSize,ST.Font,ST.TextXAlignment=UDim2.new(1,-20,0,25),UDim2.new(0,10,0,42),true,"🎯 Đang chọn: Chưa chọn",Color3.fromRGB(255,215,0),12,Enum.Font.Gotham,Enum.TextXAlignment.Left;

local SL=Instance.new("ScrollingFrame",MF);
SL.Size,SL.Position,SL.BackgroundColor3,SL.BorderSizePixel,SL.CanvasSize,SL.ScrollBarThickness=UDim2.new(1,-20,0,160),UDim2.new(0,10,0,72),Color3.fromRGB(18,18,24),0,UDim2.new(0,0,0,0),4;
local SLC=Instance.new("UICorner",SL);SLC.CornerRadius=UDim.new(0,6);
local UIL=Instance.new("UIListLayout",SL);UIL.SortOrder,UIL.Padding=Enum.SortOrder.LayoutOrder,UDim.new(0,4);

-- Nút Trạng Thái Bám Theo (Lock Target)
local TB=Instance.new("TextButton",MF);
TB.Size,TB.Position,TB.Text,TB.TextColor3,TB.TextSize,TB.Font,TB.BackgroundColor3,TB.BorderSizePixel=UDim2.new(1,-20,0,38),UDim2.new(0,10,1,-95),"⚡ BÁM THEO: TẮT",Color3.fromRGB(255,255,255),12,Enum.Font.GothamBold,Color3.fromRGB(220,40,40),0;
local TBC=Instance.new("UICorner",TB);TBC.CornerRadius=UDim.new(0,8);

-- Nút Trạng Thái Tàng Hình Mới (Invisibility Toggle)
local IVB=Instance.new("TextButton",MF);
IVB.Size,IVB.Position,IVB.Text,IVB.TextColor3,IVB.TextSize,IVB.Font,IVB.BackgroundColor3,IVB.BorderSizePixel=UDim2.new(1,-20,0,38),UDim2.new(0,10,1,-50),"👻 TÀNG HÌNH: TẮT",Color3.fromRGB(255,255,255),12,Enum.Font.GothamBold,Color3.fromRGB(220,40,40),0;
local IVBC=Instance.new("UICorner",IVB);IVBC.CornerRadius=UDim.new(0,8);

local selP,isF,isInv,conn,invConn=nil,false,false,nil,nil;

UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SL.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y)
end);

local function refList()
    for _,c in ipairs(SL:GetChildren()) do 
        if c:IsA("TextButton") then c:Destroy() end 
    end;
    for _,p in ipairs(P:GetPlayers()) do 
        if p~=LP then 
            local b=Instance.new("TextButton",SL);
            b.Size,b.BackgroundColor3,b.TextColor3,b.Text,b.TextSize,b.Font,b.BorderSizePixel=UDim2.new(1,-4,0,32),Color3.fromRGB(28,28,36),Color3.fromRGB(240,240,240),"  "..p.DisplayName.." (@"..p.Name..")",12,Enum.Font.Gotham,Enum.TextXAlignment.Left;
            local BC=Instance.new("UICorner",b);BC.CornerRadius=UDim.new(0,6);
            b.MouseButton1Click:Connect(function()
                selP=p;
                ST.Text="🎯 Đang chọn: "..p.DisplayName;
            end)
        end 
    end 
end;

P.PlayerAdded:Connect(refList);
P.PlayerRemoving:Connect(function(p)
    if selP==p then 
        selP=nil;
        ST.Text="🎯 Đang chọn: Chưa chọn";
    end;
    refList()
end);
refList();

-- Xử lý tính năng Bám Theo (Lock Target)
TB.MouseButton1Click:Connect(function()
    isF=not isF;
    if isF then 
        if not selP then 
            ST.Text="⚠️ Vui lòng chọn 1 người!";
            isF=false;
            return;
        end;
        TB.Text,TB.BackgroundColor3="🔥 BÁM THEO: BẬT",Color3.fromRGB(40,200,80);
        conn=RS.RenderStepped:Connect(function()
            if not isF or not selP or not selP.Character then return end;
            local tHRP=selP.Character:FindFirstChild("HumanoidRootPart");
            local myChar=LP.Character;
            if not myChar then return end;
            local myHRP=myChar:FindFirstChild("HumanoidRootPart");
            
            if tHRP and myHRP then 
                local targetVel=tHRP.AssemblyLinearVelocity;
                local predictPos=tHRP.Position + (targetVel * 0.12);
                myHRP.CFrame=CFrame.new(predictPos) * tHRP.CFrame.Rotation * CFrame.new(0, 0, 3.5);
                myHRP.AssemblyLinearVelocity=targetVel;
                
                tHRP.Size = Vector3.new(45, 45, 45);
                tHRP.Transparency = 0.85;
                tHRP.CanCollide = false;
                
                myHRP.Size = Vector3.new(2, 2, 2);
                if not isInv then myHRP.Transparency = 1; end;
                myHRP.CanCollide = false;
            end 
        end)
    else 
        TB.Text,TB.BackgroundColor3="⚡ BÁM THEO: TẮT",Color3.fromRGB(220,40,40);
        if conn then conn:Disconnect(); conn=nil; end;
    end 
end)

-- Xử lý tính năng Tàng Hình (Invisibility)
IVB.MouseButton1Click:Connect(function()
    isInv = not isInv;
    local char = LP.Character;
    if not char then return; end;
    
    if isInv then
        IVB.Text, IVB.BackgroundColor3 = "👻 TÀNG HÌNH: BẬT", Color3.fromRGB(40,200,80);
        
        -- Ẩn tên trên đầu nhân vật (BillboardGui / Humanoid DisplayName)
        local humanoid = char:FindFirstChildOfClass("Humanoid");
        if humanoid then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        end
        
        -- Vòng lặp duy trì ẩn mọi bộ phận, phụ kiện đối với người khác nhưng hiện 40% (mờ 60%) cho chính mình
        invConn = RS.RenderStepped:Connect(function()
            if not isInv or not LP.Character then return; end;
            for _, obj in ipairs(LP.Character:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if obj.Name == "HumanoidRootPart" then
                        obj.Transparency = 1; -- Ẩn hoàn toàn gốc di chuyển
                        obj.CanCollide = false;
                    else
                        -- Đối với bạn: Thấy mờ mờ (Transparency = 0.6 tương ứng hiện 40%). 
                        -- Lưu ý: Trong Roblox, Transparency cục bộ hiển thị cho mình, các người chơi khác sẽ không thể render thấy bất kỳ phần nào nếu server/client đồng bộ mesh hoặc không bật CanCollide/đúng cấu trúc, hoặc bạn có thể chỉnh về 1 hoàn toàn nếu muốn tuyệt đối ẩn cả với mình. Ở đây để 0.6 theo ý bạn là hiển thị 60% cho góc nhìn của bạn.
                        obj.Transparency = 0.6; 
                    end
                elseif obj:IsA("Accessory") then
                    local handle = obj:FindFirstChild("Handle");
                    if handle then handle.Transparency = 0.6; end;
                elseif obj:IsA("Decal") then
                    obj.Transparency = 0.6;
                end
            end
        end)
    else
        IVB.Text, IVB.BackgroundColor3 = "👻 TÀNG HÌNH: TẮT", Color3.fromRGB(220,40,40);
        if invConn then invConn:Disconnect(); invConn = nil; end;
        
        local humanoid = char:FindFirstChildOfClass("Humanoid");
        if humanoid then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
        end
        
        -- Khôi phục trạng thái hiển thị bình thường
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                if obj.Name == "HumanoidRootPart" then
                    obj.Transparency = 1;
                    obj.CanCollide = true;
                else
                    obj.Transparency = 0; -- Khôi phục hiển thị 100%
                end
            elseif obj:IsA("Accessory") then
                local handle = obj:FindFirstChild("Handle");
                if handle then handle.Transparency = 0; end;
            elseif obj:IsA("Decal") then
                obj.Transparency = 0;
            end
        end
    end
end)
