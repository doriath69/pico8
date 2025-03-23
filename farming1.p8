pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--farming game


-->8
--init

function _init()


end
-->8
--update

function _update()
end

-->8
--draw

function _draw()
	cls(4)
	map()
end


__gfx__
0000000044444444444444444ccccccc44444444ccccccc4cccccccc4444444444444444ccccccc44ccccccccccccccc00000000000000000000000000000000
0000000044444644446444444ccccccccc4c44ccccccccc4cccccccc4ccc44cccc4c44c4ccccccc44ccccccccccccccc00000000000000000000000000000000
00700700444544444454446444cccccccccccccccccccc44cccccccc44ccccccccccccc4cccccc4444cccccccccccccc00000000000000000000000000000000
00077000444444444444444444ccccccccccccccccccccc4cccccccc44ccccccccccccc4ccccccc444cccccccccccccc00000000000000000000000000000000
0007700044444444444444444ccccccccccccccccccccc44cccccccc4ccccccccccccc44cccccc444ccccccccccccccc00000000000000000000000000000000
00700700464444444444444444cccccccccccccccccccc44cccccccc44cccccccccccc44cccccc444ccccccccccccccc00000000000000000000000000000000
0000000044444454454445444cccccccccccccccccccccc4cc44c4cc4cccccccccccccc4cc44ccc44c44c4cccccccccc00000000000000000000000000000000
0000000044444444444444444cccccccccccccccccccccc4444444444cccccccccccccc44444444444444444cccccccc00000000000000000000000000000000
00aaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c9c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11161110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
