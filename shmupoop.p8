pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--lazydevs shmup tutorial

function _init()

 --init global
 global=_ENV

	--init game state
	gamemode="start"
	animcounter=0
	shots = 0
	lives=3
	hiscore=0
	score=0
	
	
	--init starfield
	stars={}
	star_types={star,far_star,near_star}
	numstars = 50
	
	
	for i=1,numstars do
		local star_type=rnd(star_types)
		add(stars,star_type:new({
		x=rnd(127),
		y=rnd(127), 
		}))
	end
		 
	
	
	--init player1
	
	p1=player:new()
	
	
	--init enemies
	numenemies=4
	enemies={}
	for i=1,numenemies do
		add(enemies,enemy:new({
		x=20+rnd(30),
		y=rnd(10),
		velx=5-rnd(10),
		vely=1
		}))
	end
	
	
	
	
	
	--init bullets
	bullets={}
	
 --init explosions
 explosions={}

end


function startgame()
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
	
	p1=player:new()
	
	
	--init enemies
	numenemies=4
	enemies={}
	for i=1,numenemies do
		add(enemies,enemy:new({
		x=20+rnd(30),
		y=rnd(10),
		velx=5-rnd(10),
		vely=1
		}))
	end
	
	
	
	
	
	--init bullets
	bullets={}
end
-->8
--update

function _update()

	if gamemode == "game" then
		update_game()
	elseif gamemode == "start" then
	 update_start()
	elseif gamemode == "gameover" then
		update_gameover()
	end 


end --main update


--start screen update function

function update_start()

	if btnp(4) or btnp(5) then gamemode="game" end

end

function update_gameover()

 if btnp(4) or btnp(5) then
 	global.lives = 3
 	score=0 
  gamemode="start" end

end


--main game update function

function update_game()

	
--update players	
		
	p1:update()
	
--update enemies
 if #enemies <= 0 then
	  spawnenemies()
	end
	
	
	for enemy in all(enemies) do
		enemy:update()
		
		if enemy.health <=0 then
			explode(enemy.x,enemy.y,enemy.w)
			del(enemies,enemy)
		end
		
		if collide(p1,enemy) then
		 print(enemy.ramage,p1.x,p1.y,12)
			p1:damage(enemy.ramage)
			print(p1.ramage,enemy.x,enemy.y,12)
			enemy:damage(p1.ramage)
		end --if collide with player
	end --for each enemy in ememies
	
	--end
	
	

--update starfield
	for star in all(stars) do
		star:update()
	end

--update bullets
	for bullet in all(bullets) do
		bullet:update()
		if bullet.y<0 then
			del(bullets,bullet)
		end --if statement
		for enemy in all(enemies) do
			if collide(bullet,enemy) then
				enemy:damage(bullet.damage)
				del(bullets,bullet)
			end --if collide statement
		end --for enemies for loop
	end --for bullets
 
	--update explosions
	
	for explosion in all(explosions) do
		explosion:update()
	end

 --update score
 if score > hiscore then
 	hiscore=score
 end

end  --_update


-->8
--draw

function _draw()

if gamemode == "game" then
	draw_game()
elseif gamemode == "start" then
 draw_start()
elseif gamemode == "gameover" then
	draw_gameover()
end 


end --main draw


function draw_start()
	cls(1)
	print("my awesome shmup",30,40,12)
	print("press any key to start", 30,60,12)
end	--draw_start()

function draw_gameover()
	cls(12)
	print("game over",30,40,1)
	print("press any key",30,60,1)
end







function draw_game()

--clear screen
cls(0)


--draw starfield

for star in all(stars) do
		star:draw()
end


--draw player sprite

p1:draw()

	
--draw enemies
for enemy in all(enemies) do
	enemy:draw()
end


--draw bullets
for bullet in all(bullets) do
	bullet:draw()
end

--draw explosions
for explosion in all(explosions) do
	explosion:draw()
	if explosion.size<=0 then
		del(explosions,explosion)
	end
end


--draw ui
--healthbar
for healthbar=0,p1.healthmax do
	if p1.health > healthbar then
		spr(10,12*healthbar,2)

	else
			spr(11,12*healthbar,2)
	end
end
	
--shot counted (to be replaced)
print("shots fired:" .. shots, 70, 2, 6)

--score
print("hiscore:" .. hiscore,80,10,10)
if score >= hiscore then
	print("score:" .. score,80,20,10)
else
	print("score:" .. score,80,20,12) 	
end


--lives
print("lives:" .. global.lives, 80, 30, 12)

--enemies

print("enemies:" .. #enemies, 80,40, 12)

end

function draw_gameover()

 cls(9)
 for i=1,50 do
 	print("game over",65,65,0)
 end
end


-->8
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
--starfield

star=entity:new({
	spd=.5,
	rad=0,
	clr=13,
	
	
	
	update=function(_ENV)
		y+=spd
		
		if y-rad > 127 then
			y = rad
			
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
	
	new=function(_ENV,tbl)
		tbl=star.new(_ENV,tbl)
		tbl.spd = tbl.spd+rnd(.5)
		return tbl 
	end --near_star
})
-->8
--player

player = entity:new({
	--playervalues
	animcounter=0,
	sprite=2,
	sprlen=3,
	x=50,
	y=50,
	velx=0,
	vely=0,
	health=3,
	healthmax=5,
	ramage=1,
	
	
	
	
	--temp bullet code
	bulx=0,
	buly=0,
	bulvelx=0,
	bulvely=0,
	bulsprite=9,
	muzzleflash=0,
	exstsprite=5,
	
	update=function(_ENV)
		
		--update animation
		animcounter+=1
		
		--poll controllers
		if btn(0) then
			velx=-1
			sprite=1
			end
		
		if btn(1) then
			velx=1
			sprite=3
			end
			
		if btn(2) then
			vely=-1
			sprite=2
			end
		
		if btn(3) then
			vely=1
			sprite=2
			end
		
		if btnp(4) then
			add(global.bullets, bullet:new({
				x=x,
				y=y+2,
				vely=-8,
				}))
			sfx(0)
			muzzleflash=3
			global.shots+=1
			end
			
		if btnp(5) then 
			startgame()
		end
	--end poll buttons
	
	
		--update player position 
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
		
		--update player animation
		exstspr=5+animcounter%3
	

	 --temp update bullet
	 bulx=bulx+bulvelx
		buly=buly+bulvely
	
	end, --end update player

 draw=function(_ENV)
 	spr(sprite,x,y)
  spr(exstspr,x,y+7)
  --draw player bullet
  spr(bulsprite,bulx,buly)
  if muzzleflash>0 then 
	  circfill(x+4,y,muzzleflash,7)
	  muzzleflash -= 1
	 end
	end, -- draw player
	
	damage=function(_ENV,damtaken)
		health-=1
		if health <=0 then
			shiploss()
		end
	end, --end damage taken
		
	shiploss=function()
		global.lives -= 1
		health = 3
		sfx(1)
		if global.lives <=0 then
			global.gamemode="gameover"
		else
			startgame()
		end
	end, --shiploss

})--end player obj definition




-->8

--enemies

enemy = entity:new({
	animcounter=0,
	sprite=17,
	cursprite=sprite,
	sprlen=4,
	x=50,
	y=0,
	velx=0,
	vely=1,
	health=1,
	xp=5,
	ramage=1,
	
	update=function(_ENV)
		
		--update animation
		animcounter+=1
		
		--update enemy position
		
		--update enemies position
		
		
		if x>=127 or x<=0 then
			velx = -2 * velx
		end
		
		x+=velx
		x=x%127
		y+=vely
		y=y%127
	
		
	
		cursprite = sprite + (animcounter%sprlen)
  
  if health <= 0 then
			explode(x,y,w)
			global.score+=xp
			del(enemies,self)
		end
  	
		
		end, --end update enemy
		
		
		
		draw=function(_ENV)
	 	spr(cursprite,x,y)
		end, -- end draw enemy
		
		
		damage=function(_ENV,damtaken)
			health-=damtaken
			if health <= 0 then
				explode(x,y,w)
				sfx(2)
				global.score+=xp
				del(enemies,self)
			end
		end, --end damage function

})--end enemy obj definition



enemy_vec=enemy:new({
sprite = 33,
sprlen = 4,
x = rnd(10),
}) --end enemy_vec object definition

enemy_eye=enemy:new({
sprite = 49,
sprlen = 4,
x = rnd(100),
})

enemy_saucer=enemy:new({
sprite = 15,
sprlen = 4,
x = rnd(100),
})





function spawnenemies()
	numenemies=8
	enemies={}
	for i=1,numenemies do
		
	
		local enemy_type=flr(rnd(4))
		
		if enemy_type == 0 then	

			add(enemies,enemy:new({
			x=20+rnd(30),
			y=rnd(10),
			velx=5-rnd(10),
			vely=1,
			}))
			
		--end --if enemytype==0
		elseif enemy_type == 1 then
		
			add(enemies,enemy_vec:new({
			x=10+rnd(30),
			y=rnd(6),
			velx=5-rnd(10),
			vely=1,
			})
			)
			
		elseif enemy_type == 2 then
		
			add(enemies,enemy_eye:new({
			y=rnd(6),
			velx=5-rnd(10),
			vely=1,
			})
			)
  elseif enemy_type == 3 then
  	add(enemies,enemy_saucer:new({
			y=rnd(6),
			velx=5-rnd(10),
			vely=2,
			})
			)
  else
		end -- if for enemy type
		 
	end --for
end --function

function explode(x,y,size)
	add(explosions, explosion:new({
		x=x,
		y=y,
		size=size,
		duration=2,
		}))
end






-->8
--bullets
bullet = entity:new({
	sprite=9,
	velx=0,
	vely=-1,
	damage=1,
	update = function(_ENV)
		x=x+velx
		y=y+vely
	end, --bullet update
	draw = function(_ENV)
		spr(sprite,x,y)
	end, --bullet draw
	})
	
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
--explosions

explosion = entity:new({
	animcounter=0,
	size=5,
	velx=0,
	vely=1,
	duration=1,
	
	update = function(_ENV)
		x=x+velx
		y=y+vely
		size-=animcounter
		if size <= 0 then
			del(explosions,self)
		end
	end, --explosion update
	draw = function(_ENV)
		circfill(x,y,size*2,9)
	 circfill(x,y,size,10)
	 animcounter+=1
	 if animcounter >= duration then
	 	del(explosions,self)
	 end
	end, --explosion draw
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
000000000300003003000030030000300300003000ccc70000ccc70000ccc70000ccc70000000000000000000000000000000000000000000000000000000000
0000000000bbbb0000bbbb0000bbbb0000bbbb0000cccc0000cccc0000cccc0000cccc0000000000000000000000000000000000000000000000000000000000
0000000000b88b0000bb88000088bb0000b88b0000cdcc0000cdcc0000cdcc0000cdcc0000000000000000000000000000000000000000000000000000000000
000000003bbbbbb33bbbbbb33bbbbbb33bbbbbb30666666006666660066666600666666000000000000000000000000000000000000000000000000000000000
00000000070707077070707007070707070707076666666666666666666666666666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000d6aa6600d6aa6600d6aa6600d6aa66000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000008900000088000000a80000009800000000000000000000000000000000000000000000000000000000000
000000000008000000080000000a0000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000898000009a9000008a8000009990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005a5000005a500000595000005a50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055555000555550005555500055555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000005588e5505588e5505588e5505588e5500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550005505500055055000550550005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000580008505800085058000850580008500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000700000007000000070000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007870000078700000787000007870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070887000780870007880700078087000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000770887707780877077880770778087700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000770887707780877077880770778087700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070887000780870007880700078087000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007870000078700000787000007870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000700000007000000070000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000000000000000360503405031050000002c05000000280500000023050000001d0500000019050000001405012050100500e0500b0500a050000000000000000000000000000000000000000000000
0003000024660296702d670306703167032670306602f6502d6502a6401864013640126300f6300c630096200b620066200861006610016100361002610016100161001610016000160000600006000060000000
000300003865020650206503465012650076500565007650056500465002650006500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
