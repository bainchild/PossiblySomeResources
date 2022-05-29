for _,v in pairs(arg) do
	if _>0 then
		local fh = io.open(v,'r')
		if fh then
			fh:close()
			local s,pngdec = pcall(require('PngLibrary'),v)
			if s then
				local outfh = io.open(v..'.json','w')
				outfh:write(require('cjson').encode(pngdec))
				outfh:close()
			else
				print('err on '..tostring(v)..": "..tostring(pngdec))
			end
		else
			print("Couldn't open "..tostring(v))
		end
	end
end
