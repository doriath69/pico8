pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--lazydevs shmup tutorial

function _init()


	--init game state
	gamemode=0
	animcounter=0
	shots = 0
	
	
	--init starfield
	stars={}
	star_types={star,far_star,near_star}
	numstars = 50
	score=0
	
	for i=1,numstars do
		local star_type=rnd(star_types)
		add(stars,star_type:new({
		x=rnd(127),
		y=rnd(127), 
		}))
	end
		 
	
	
	--init player1
	
	
	p1spr=2
	p1sprlen=3
	p1health = 3
	p1healthmax = 5
	
	
	p1exstspr=5
	p1exstsprlen=3
	
	p1bulspr=9
	p1bulx=130
	p1buly=130
	p1bulvelx=0
	p1bulvely=0
	muzzleflash=0
	
	
	p1health=3
	p1score=0
	p1x=50
	p1y=50
	p1velx=0
	p1vely=0
	
	
	
	--init enemies
	
	bot1spr=17
	bot1sprlen=3
	bot1spd=1
	bot1x=30
	bot1y=0
	bot1velx=0
	bot1vely=1

end




-->8
function _update()

	animcounter+=1
	p1spr=2
	
	--poll controllers
	if btn(0) then
		p1velx=-1
		p1spr=1
		end
	
	if btn(1) then
		p1velx=1
		p1spr=3
		end
		
	if btn(2) then
		p1vely=-1
		p1spr=2
		end
	
	if btn(3) then
		p1vely=1
		p1spr=2
		end
	
	if btn(4) then
		p1bulx=p1x
		p1buly=p1y+2
		p1bulvely=-8
		sfx(0)
		muzzleflash=3
		end
		
	if btnp(4) then 
		shots+=1
	end



	--update player position 
	p1x = p1x+p1velx
	if p1x>120 then
		p1x = 120
		p1xvel = 0
	elseif p1x <0 then
		p1x=0
		p1xvel = 0
	end
	
	
	p1y = p1y+p1vely
	if p1y>120 then
		p1y = 120
		p1yvel = 0
	elseif p1y<=0 then
		p1y=0
		p1yvel=0	
	end
	
	--update player animation
	p1exstspr=5+animcounter%3
	
	
	--update bullet
	p1bulx=p1bulx+p1bulvelx
	p1buly=p1buly+p1bulvely
	
	
	--update enemies position
	bot1velx=rnd(5)-rnd(5)
	bot1x=bot1x+bot1velx
	if bot1x>200 then
		bot1x = 0
	elseif bot1x<0 then
	 bot1x=120
	 end
	 
	--update enemies animation 
	bot1spr=17+animcounter%3
	bot1y=bot1y+bot1vely
	if bot1y>200 then
		bot1y = 0
	elseif bot1y<0 then
	 bot1y=120
	 end

--update starfield
for star in all(stars) do
		star:update()
	end


end


-->8
function _draw()

--clear screen
cls(0)


--draw starfield

for star in all(stars) do
		star:draw()
end


--draw player sprite
spr(p1spr,p1x,p1y)
spr(p1exstspr,p1x,p1y+7)
--draw player bullet
spr(p1bulspr,p1bulx,p1buly)
if muzzleflash>0 then 
	circfill(p1x+4,p1y,muzzleflash,7)
	muzzleflash -= 1
	end
	
--draw enemies
spr(bot1spr,bot1x,bot1y)

--draw ui
--healthbar
for healthbar=0,p1healthmax do
	if p1health > healthbar then
		spr(10,12*healthbar,2)

	else
			spr(11,12*healthbar,2)
	end
end
	
--shot counted (to be replaced)
print("shots fired:" .. shots, 70, 2, 6)



end


-->8
-- oop - metatable

gobal=_ENV

class=setmetatable({
	new=function(self,tbl)
		tbl=tbl or {}
		setmetatable(tbl,{
		 	__index=self
		 })
		return tbl
	end, --new(
},{__index=_ENV})

entity=class:new({
	x=0,
	y=0,
})

-->8
--starfield

star =entity:new({
	spd=.5,
	rad=0,
	clr=13,
	
	
	
	update=function(_ENV)
		y+=spd
		
		if y-rad > 127 then
			y = rad
			gobal.score += 1
		end
	end,
	
	draw=function(_ENV)
		circfill(
			x,
			y,
			rad,
			clr
		)
	end,
})

far_star=star:new({
	clr=1,
	rad=0,
	spd=0.25
})
 --end star




near_star=star:new({
	clr=7,
	rad=1,
	spd=1,
	
	new=function(self,tbl)
		tbl=star.new(self,tbl)
		tbl.spd = tbl.spd+rnd(.5)
		return tbl 
	end --near_star
})
__gfx__
0000000000000000000000000000000000000000009aa900009aa9000009900000009000000aa000088008800880088000000000000000000000000000000000
000000000000000000000000000000000000000000899800009aa900009aa900009aa900000aa00088888ee88008800800000000000000000000000000000000
00700700000d0000000dd000000d0000000000000008800000899800009aa9000098a0000009a000888888e88000000800000000000000000000000000000000
00077000007600000006600000067000000000000000000000088000000980000009800000099000888888888000000800000000000000000000000000000000
0007700000c6d00000dccd0000d6c000000000000000000000000000000880000000800000000000088888800800008000000000000000000000000000000000
007007000dddd0000dddddd000dddd00000000000000000000000000000000000008000000000000008888000080080000000000000000000000000000000000
00000000000d0000000dd000000d0000000000000000000000000000000000000000000000000000000880000008800000000000000000000000000000000000
00000000000a0000000aa000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000030000300300003003000030030000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000bbbb0000bbbb0000bbbb0000bbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000b88b0000bb88000088bb0000b88b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000003bbbbbb33bbbbbb33bbbbbb33bbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070707077070707007070707070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000000000000000360503405031050000002c05000000280500000023050000001d0500000019050000001405012050100500e0500b0500a050000000000000000000000000000000000000000000000
