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


-- time system

 init_time()
 

--crops

 crops={}
 
--hyrdation enabled

	hydration_enabled = false
	snaptotile = true
	
--fishes

	fishes ={}
	init_fishes()


--world

airdrag = -0.3



end
-->8
--update

function _update()

	for player in all(players) do
		
		player:update()
		for crop in all(crops) do
			if player.tx == crop.tx then
				if player.ty == crop.ty then
					if crop.stage >=2 then
						sfx(6)
				 	crop:harvest(player)
				 	add(player.produce,crop)
	 				player.money+=crop.harvest_value
	 				player.seeds+=crop.harvest_seeds
	 				del(crops,crop)
	 				mset(tx,ty,12)
				 end
				end				 
			end
		end
		
	
	end --end player loop
	
	update_time()
	
 update_crops()
 
 update_fishes()

end

-->8
--draw

function _draw()
	cls(4)
	map()
	
	draw_crops()
	
	for player in all(players) do
	
		player:draw()
	
	end --end for player loop
	
	draw_ui()
	
	draw_fishes()
	
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
	tx=0,
	ty=0,
	h=8,
	w=8,
})


-->8
--player

--define player class object

player=entity:new({
	pos="p1",
	name="player 1",
	sprite=16,
	health=5,
	velx=0,
	vely=0,
	w=8,
	h=8,
	x=0,
	y=0,
	tx=0,
	ty=0,
	seeds = 0,
	produce = {},
	money = 0,
	lure_out = false,
	lure_cast_time = 0,
	lure_landed = false,
	lure_in_water = false,
	lure_spr = 21,
	lure_anim = 0,
	lure_anim_range = 3,
	lure_size = 8,
	lure_x = x,
	lure_y = y,
	lure_z = 0,
	lure_velx=0,
	lure_vely=0,
	lure_velz=0,
	
	
	
	update=function(_ENV)
		
			--poll controllers
			
			if btn(5) and btn(2) then
				
				lure_velx=3
				lure_vely=0
				lure_velz=2
				cast_lure()
			end
			
			
			
			if btn(0) then
				if fget(mget(tx-1,ty),0) then
					x+=-1
					--tx=flr(x+(w*0.5)/8)
					tx=flr(x/8)
					if ((minute%2) == 0) sfx(0)	
				else
					sfx(2)
				end
				--sprite=1
			end
			
			if btn(1) then
			 --tx=flr((x+(w*0.5))/8)
				tx=flr(x/8)
				if fget(mget(tx+1,ty),0) then
					x+=1
					--tx=flr(x+(w*0.5)/8)
					tx=flr(x/8)
					if ((minute%2) == 0) sfx(0)
				else sfx(2)
				end
				--sprite=3
			end
				
			if btn(2) then
			 --ty=flr(y+(h*0.5)/8)
				if fget(mget(tx,ty-1),0) then
					y+=-1
					--ty=flr(y+(h*0.5)/8)
					ty=flr(y/8)
					if ((minute%2) == 0) sfx(0)
				else sfx(2)
				end
				--sprite=2
			end
			
			if btn(3) then
			 --ty=flr(y+(h*0.5)/8) 
				if fget(mget(tx,ty+1),0) then
					y+=1
					--ty=flr(y+(h*0.5)/8)
					tx=flr(x/8)
					if ((minute%2) == 0) sfx(0)
				else sfx(2)
				end
			end
			--end controller update
			
			if btnp(5) then
			 --tx=flr(x+(w*0.5)/8)
		  --ty=flr(y+(h*0.5)/8)
				tx=flr(x/8)
				ty=flr(y/8)
				till(tx,ty)
			end
			
			if btnp(4) then
			 --tx=flr(x+(w*0.5)/8)
		  --ty=flr(y+(h*0.5)/8)
		  if seeds >= 1 then
					tx=flr(x/8)
					ty=flr(y/8)
					plant(tx,ty)
					seeds -= 1
				end -- if seeds
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
		
		--get player tile location
		--tx=flr(x+(w*0.5)/8)
		--ty=flr(y+(h*0.5)/8)
		tx=flr(x/8)
		ty=flr(y/8)
	
	--update lure
		if lure_out then
			if lure_landed then
				lure_velx = 0
				lure_vely = 0
				if fget(mget(lure_tx,lure_ty),4) then
					lure_in_water = true
				end
				if lure_in_water then
					lure_anim += 1
					lure_anim = lure_anim % lure_anim_range
				end
			else 
			 lire_cast_time += 1
				lure_x += lure_velx
				lure_velx += airdrag
				lure_tx = flr(lure_x/8)
				
				lure_y += lure_vely
				lure_vely += airdrag
				lure_ty = flr(lure_y/8)
				
				lure_z += lure_velz
				lure_velz += airdrag
				if lure_z <= 0 then
					lure_landed = true
				end --lure on ground check
			end --else	
		end --if lure_out
		
 end --end update player function
end,

 
	--draw player function
	
	draw = function(_ENV)
		spr(sprite,x,y)
		if lure_out then
		 if lure_landed then
		 	if lure_in_watner then
			   spr(lure_spr+lure_anim,lure_x,lure_y)
			 end
			else
				spr(lure_spr,lure_x,lure_y)
				line(x,y,lure_x,lure_y,7)  
		end
	end
	end, -- end draw player function
	
	cast_lure = function(_ENV)
		if lure_out == false then
			lure_out = true
			lure_x = x
		 lure_y = y
		 lure_z = z
			lure_velx = x
			lure_vely = y
			lure_velz = z
			lure_cast_time = 0
		else 
			retract_lure()
		end
	end, --end cast_lure()
	
	retract_lure = function(_ENV)
	 if lure_landed == true then
	 	if lure_in_water == true then
	 	 print("checking for fish")
	 	end --if lure in water
	 end --if lure landed
		lure_out = false
		lure_cast_time = 0
	end, --end retract_lure()
	
	
	
	
	
		
		
	
	
	
	}) --end player object definition


--start init player function

function init_player()

	p1 = player:new({
		name="farmer 1",
		x=40,
		y=40,
		w=8,
		h=8,
		seeds=5,
		money=0
			})
	
	add(players,p1)
	
end  --end init player function


-->8
--map interaction

--tilling

--start till function
 function till(ptx,pty)
 	if fget(mget(ptx,pty),1) then
	 	sfx(1)
	 	mset(ptx,pty,12)
	 end --else if
	 	
	
	end --end till function


--plant seeds
	function plant(ptx,pty)	
	 if mget(ptx,pty) == 12 then
			sfx(3)
			mset(ptx,pty,32)
	 	local newcrop = crop:new({
	 	x=ptx*8,
	 	y=pty*8,
	 	})
	 	add(crops, newcrop)
		else
			sfx(7)
		end	
	end	--end function
	

		
			



	
snap_to_tile = function(x,y)
 	local tx=flr((x+4/8))
  local ty=flr((y+6/8))
  return tx*8,ty*8
 end
-->8
--time

function init_time()
	minute=0
 hour=0
 day=0

end --end init time


--update time
function update_time()

 --[[minute+=1
 
 hour=minute % 60
 
 day = hour % 24
 ]]--

 minute+=1
 
 if minute >= 60 then
 	minute = 0
 	hour += 1
 end
 
 if hour >= 24 then
 	hour = 0
 	day += 1
 end 

end --end update time






-->8
--ui

	function draw_ui()
	
		print("time:" .. day .. ":" .. hour .. ":" .. minute, 1, 1, 7)
		for player in all(players) do
			print(player.name .. " : " .. player.tx .. "/" .. player.ty .. "/" .. mget(player.tx,player.ty),50, 1, 7)
   print("money: " .. player.money)
		print("seeds: " .. player.seeds)		
		end
		local numcrops = 0
		for crop in all(crops) do
		 numcrops += 1
   --print(crop.name .. ": x:" .. crop.x .. " y:" .. crop.y .. " : " .. crop.growtimer,5,((numcrops*9)+18),11)		
		end
		print("crops:" .. numcrops)
		
		  
	
	
	end -- draw ui
-->8
--crops

  
function draw_crops()
	for mycrop in all(crops) do
		mycrop:draw()
	end
end --end draw crops

function update_crops()
	for mycrop in all(crops) do
		mycrop:update()
	end
end --end update crops


--crop object definition

crop = entity:new({
 name = "carrot",
 stage = 0,
 --stages=0:seed, 1:seedling,2:ripe
 spr_seed = 33,
 spr_seedling = 34,
 spr_ripe=35,
 hyd=6,
 hydcheck=120,
 hydtimer=0,
 minhyd=1,
 hydloss=1,
 harvest_item="carrot",
 harvest_value=5,
 harvest_seeds=2,
 snaptotile=true,
 --position information
 --health
 health=3,
 growtimer=0,
 ttgrow=300,
  --end snap to tile function
 
 draw = function(_ENV)
 	spr(spr_seed+stage,x,y)
	end,
	
	update = function(_ENV)
		--[[if snaptotile then 
			x,y=snap_to_tile(x,y)
		
		end]]--
	 
	 growtimer+=1
	 tx=flr(x/8)
	 ty=flr(y/8)
	 
	 --update hydration
	 if hydration_enabled then
			hydtimer+=1
			if hydtimer >= hydcheck then
				hydtimer=0 --reset hydration timer to 0
				hyd-=hydloss --subtract hydloss from hydration
				if hyd < minhyd then --check hyrdation
					health -= 1
					if health <= 0 then
						growtimer = 0 
						crop_death()
					end
				end
			end
		end --end hydration
			
			--start growth check
		if growtimer >= ttgrow then
			if stage <=2 then
				sfx(4)
				stage+=1
				growtimer=0
			end
		end
	end,
 --end update function
	
	crop_death = function(_ENV)
		score -= flr(harvest_value/2)
		del(crops,crop)
	end,
					
	harvest = function(_ENV,p1)
	 add(p1.produce,self)
	 p1.money+=harvest_value
	 p1.seeds+=harvest_seeds
	 del(crops,self)
	end,
		 
 }) --end crop definition
 
 


-->8
--collision

function collide(a,b)
	local a_left=a.x
	local a_top=a.y
	local a_right=a.x+a.w
	local a_bottom=a.y+a.h
	
	
	local b_left=b.x
	local b_top=b.y
	local b_right=b.x+b.w
	local b_bottom=b.y+b.h
	
	if a_top > b_bottom then 
		return false end
	if b_top > a_bottom then
		return false end
	if a_left > b_right then
		return false end
	if b_left > a_right then
		return false end
		 
	

	return true
	
end

-->8
--fish

function init_fishes()
	for tilex=0,15 do
		for tiley=0,15 do
			if fget(mget(tilex,tiley),4) then
			 if rnd(5) > 4 then
				 sfx(5)
					fishy = fish:new({
					x=tilex*8,
					y=tiley*8,
					velx=rnd(1)-2,
					vely=rnd(1)-2,
					})
					add(fishes,fishy)
					sfx(5)
				end
			end
		end
	end
end


function update_fishes()
	for fish in all(fishes) do
		fish:update()
	end
end

function draw_fishes()
	for fish in all(fishes) do
		fish:draw()
	end
end



fish = entity:new({
	velx=rnd(2)-1,
	vely=rnd(2)-1,
	sprite=48,
	update = function(_ENV)
	  tx=flr(x/8)
	  ty=flr(y/8)
	  if fget(mget(tx+velx,ty),4) then
	  	x+=velx
	  else
	  	velx = velx * -1
	  end
	  if fget(mget(tx,ty+vely),4) then
	  	y+=vely
	  else
	  	vely = vely * -1
	  end
 end, --update
 
 draw = function(_ENV)
 	spr(sprite,x,y)
 end, --end draw fish
})


__gfx__
0000000044444444444444444ccccccc44444444ccccccc4cccccccc4444444444444444ccccccc44ccccccccccccccc44444444333333335555555555555555
0000000044444644446444444ccccccccc4c44ccccccccc4cccccccc4ccc44cccc4c44c4ccccccc44ccccccccccccccc44d4d4d4333333b35555555555555555
00700700444544444454446444cccccccccccccccccccc44cccccccc44ccccccccccccc4cccccc4444cccccccccccccc4d4d4d4433333bb35555555555555555
00077000444444444444444444ccccccccccccccccccccc4cccccccc44ccccccccccccc4ccccccc444cccccccccccccc444444443b3333b35555555555777755
0007700044444444444444444ccccccccccccccccccccc44cccccccc4ccccccccccccc44cccccc444ccccccccccccccc4444444433b333b35555555555777755
00700700464444444444444444cccccccccccccccccccc44cccccccc44cccccccccccc44cccccc444ccccccccccccccc44d4d4d433b333335555555555555555
0000000044444454454445444cccccccccccccccccccccc4cc44c4cc4cccccccccccccc4cc44ccc44c44c4cccccccccc4d4d4d44333333335555555555555555
0000000044444444444444444cccccccccccccccccccccc4444444444cccccccccccccc44444444444444444cccccccc44444444333333335555555555555555
00aaa000000000000000000000000000000000000077000000077000000770000000000000000000000000000000000000000000333333330000000000000000
0aaaaa00000000000000000000000000000000000088000000088000001111000000000000000000000000000000000000000000333333330000000000000000
00c9c000000000000000000000000000000000000077000000111100100000010000000000000000000000000000000000000000333333330000000000000000
00999000000000000000000000000000000000000000000000000000011111100000000000000000000000000000000000000000333333330000000000000000
11161110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333330000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333330000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333330000000000000000
00d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333330000000000000000
4444444400000000000000000000000000b000000666666000000000000000000000000000000000000000000000000000000000000000000000000000000000
444444440090d0d00000d0d0003030d003b000000d77776000000000000000000000000000000000000000000000000000000000000000000000000000000000
444444440d0d09000d0d00000d034d00003390000d73776000000000000000000000000000000000000000000000000000000000000000000000000000000000
4454545400000000000b000000099000003990000d39976000000000000000000000000000000000000000000000000000000000000000000000000000000000
45454544000000000000b00000599500009999000d79976000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444400d090d0000090d0000554d0000d99900d77996000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444090d0d000d0d0d000d0d0d000000d9990d77776000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444400000000000000000000000000000d990dddddd000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00dddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0055550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0555595000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d5555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d6666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d000dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0003031010101010101010100b03010100000000000000000000000000030000050303010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d0d1d1d0d1d1d1d1d0d1d0d1d0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d02021d1d1d1d1d1d1d1d1d1d1d1d0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d021d0d1d1d1d1d0d1d0704040800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d0d1d1d1d1d1d1d1d0d1d1d030b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d1d1d1d1d0d1d1d1d070b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d0d1d02020201011d1d030b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d0202010d011d1d1d030b0b0b0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1d1d0d0101020201010d0a0606060900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010d1d011d1d010d1d1d1d0d1d1d1d0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01011d1d1d01011d1d1d1d1d1d1d1d0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101011d010101011d0101010101010200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101020201010102020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000200000603004020000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000103500e05012050190501e050220500205000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000004550085500c55011550185501f550255502e5501d5500955007550065500455004550045500455000000000000000000000000000000000000000000000000000000000000000000000000000000000
00020000083501235019350273503d350353502a3501f350163501136009350053500034000350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000005500055000550015500355004550075500a5500d5501255016550195501e55023550285500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000005750087500b7500f750147501e7503375029750177500d7500775005750037500375003750077500d750067500575007750047500275000700007000070000700007000070000700007000070000700
00040000051500a1500d1500e1500e1500b1500a15007150061500515005150061500a1500b1500a1500715006150071500b1500f15014150151501615019150001001b15020150241502d150321500010000100
000600000675007650137501e650367502b6501b7500f650037500075000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
