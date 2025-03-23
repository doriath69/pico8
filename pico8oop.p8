pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
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
		
end --init()


function _update()
	for star in all(stars) do
		star:update()
	end
end --_update()

function _draw()
	cls()
	print(score,80,5,8)
	for star in all(stars) do
		star:draw()
	end
end --_draw()
-->8
-- metatable

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
--stars

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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
