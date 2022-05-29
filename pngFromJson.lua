for _,v in pairs(arg) do
	if _>0 then
		local fh = io.open(v,'r')
		if fh then
            local dec = require('cjson').decode(fh:read("*a"))
            fh:close()
            local npng = require('pngencoder')(dec["width"],dec["height"])
            local x,y = 0,1
            print(dec.width,dec.height)
            os.execute('sleep 2')
            for _=1,dec.width*dec.height do
                if x==dec.width then x=0 y=y+1 end
                x=x+1
                npng:write({dec.pixels[x][y].R,dec.pixels[x][y].G,dec.pixels[x][y].B})
            end
            assert(npng.done,'Data does not fill png!')
            local nf = io.open(v:sub(1,-#(".json "))..".out",'w')
            nf:write(table.concat(npng.output,''))
            nf:close()
		else
			print("Couldn't open "..tostring(v))
		end
	end
end
