local cmd = vim.cmd
local o_s = vim.o

wxy.opt = function(o, v, scopes)
	scopes = scopes or { o_s }
	for _, s in ipairs(scopes) do
		s[o] = v
	end
end

wxy.augroup = function(group, cmds, clear)
	clear = clear == nil and false or clear
	if type(cmds) == "string" then
		cmds = { cmds }
	end
	cmd("augroup " .. group)
	if clear then
		cmd([[au!]])
	end
	for _, c in ipairs(cmds) do
		cmd("autocmd " .. c)
	end
	cmd([[augroup END]])
end

wxy.autocmd = function(cmds)
	if type(cmds) == "string" then
		cmds = { cmds }
	end
	for _, c in ipairs(cmds) do
		cmd("autocmd " .. c)
	end
end
