local open = io.open

local function read_file(path)
    local file = open(path, "r")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

path = io.read()
s = read_file(path)
if (s == nil) then 
	print("Error: That file does not exist")
	os.exit() 
end
c = 0
n = string.len(s)
output = "" 
mempos = 1
currentpos = 1
memory = {}
code = {}
size = 0

for i = 1, (n + 1) do
	code[i] = string.byte(string.sub(s, i, i))
	size = i
end

for i = 1, 3001 do
	memory[i] = 0
end
			
while (currentpos < size) do
            
    c = code[currentpos]
    if (c == 62)  then mempos = mempos + 1
    elseif (c == 60 and mempos ~= 0) then mempos = mempos - 1
    elseif (c == 46) then
		output = output .. string.char(memory[mempos])
		print(string.char(memory[mempos]))
    elseif (c == 44) then memory[mempos] = string.byte(io.read())
    elseif (c == 43 and memory[mempos] ~= 255) then memory[mempos] = memory[mempos] + 1
    elseif (c == 43 and memory[mempos] == 255) then memory[mempos] = 0
    elseif (c == 45 and memory[mempos] ~= 0) then memory[mempos] = memory[mempos] - 1
    elseif (c == 45 and memory[mempos] == 0) then memory[mempos] = 255
    elseif (c == 91 and memory[mempos] == 0) then
        open = 1
        while (open ~= 0 and currentpos <= size) do
            currentpos = currentpos + 1
            if (code[currentpos] == 91) then open = open + 1
            elseif (code[currentpos] == 93) then open = open - 1 end
        end
    elseif (c == 93 and memory[mempos] ~= 0) then
        deopen = 1
        while (deopen ~= 0 and currentpos >= 0) do
            currentpos = currentpos - 1
            if (code[currentpos] == 93) then deopen = deopen + 1 
            elseif (code[currentpos] == 91) then deopen = deopen - 1 end
        end
	end
    currentpos = currentpos + 1
end
print("")
print(output)