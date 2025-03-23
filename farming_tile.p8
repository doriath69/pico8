pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--farming game


-->8
--init

function _init()

--init player

	players = {}
	
	init_player()

 

end
-->8
--update

function _update()

	for player in all(players) do
		
		print("name: " .. player.name)
		player:update()
	
	end --end player loop
	
end

-->8
--draw

function _draw()
	cls(4)
	map()
	
	for player in all(players) do
	
		player:draw()
	
	end --end for player loop
	
end --end _draw function


-->8
--oop

-- oop - metatable

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
	h=8,
	w=8,
})


-->8
--player

--define player class object

player=entity:new({
	pos="p1",
	name="farmer",
	sprite=16,
	health=5,
	velx=0,
	vely=0,
	
	update=function(_ENV)
		
			--poll controllers
			if btn(0) then
				x+=-1
				sfx(0)
				--sprite=1
			end
			
			if btn(1) then
				x+=1
				sfx(0)
				--sprite=3
			end
				
			if btn(2) then
				y+=-1
				sfx(0)
				--sprite=2
			end
			
			if btn(3) then 
				y+=1
				sfx(0)
				--sprite=2
			end
		
	
	 --update position and
	 --mantain map boundaries
	
		x = x+velx
		if x>120 then
			x = 120
			velx = 0
		elseif x < 0 then
			x=0
			velx = 0
		end
		
		
		y = y+vely
		if y>120 then
			y = 120
			vely = 0
		elseif y<=0 then
			y=0
			vely=0	
		end
	
		
	end, --end update player function

	--draw player function
	
	draw = function(_ENV)
		spr(sprite,x,y)
	
	end, -- end draw player function
	
	}) --end player object definition


--start init player function

function init_player()

	p1 = player:new({
	name="player 1",
	x=40,
	y=40,
	})
	
	add(players,p1)
	
end  --end init player function


-->8
--controls

function update_controls()

	


end --end update controls
__gfx__
0000000044444444444444444ccccccc44444444ccccccc4cccccccc4444444444444444ccccccc44ccccccccccccccc44444444000000000000000000000000
0000000044444644446444444ccccccccc4c44ccccccccc4cccccccc4ccc44cccc4c44c4ccccccc44ccccccccccccccc44d4d4d4000000000000000000000000
00700700444544444454446444cccccccccccccccccccc44cccccccc44ccccccccccccc4cccccc4444cccccccccccccc4d4d4d44000000000000000000000000
00077000444444444444444444ccccccccccccccccccccc4cccccccc44ccccccccccccc4ccccccc444cccccccccccccc44444444000000000000000000000000
0007700044444444444444444ccccccccccccccccccccc44cccccccc4ccccccccccccc44cccccc444ccccccccccccccc44444444000000000000000000000000
00700700464444444444444444cccccccccccccccccccc44cccccccc44cccccccccccc44cccccc444ccccccccccccccc44d4d4d4000000000000000000000000
0000000044444454454445444cccccccccccccccccccccc4cc44c4cc4cccccccccccccc4cc44ccc44c44c4cccccccccc4d4d4d44000000000000000000000000
0000000044444444444444444cccccccccccccccccccccc4444444444cccccccccccccc44444444444444444cccccccc44444444000000000000000000000000
00aaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c9c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11161110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b0b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102020101010101020202020202010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010201010102020102010704040800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010101010101010201010102030b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010102020102070b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010102020201010202030b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010202010201020201030b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010201010102020101020a0606060900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101020102020101020202020201020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101020202020202020202020101020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101020202010101010101010101010200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101020101010101010101010101010200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
