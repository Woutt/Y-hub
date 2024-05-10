return function(Directory, Contents)
    local WriteFile = writefile or write_file or write or nil
    local IsFolder = isfolder or is_folder or nil
    local MakeFolder = makefolder or make_folder or createfolder or create_folder or nil

    if WriteFile and IsFolder and MakeFolder then
        if (Directory:sub(1, 1) == "/") then
            Directory = Directory:sub(2, -1)
        end

        if (Directory:sub(1, 2) == "./") then
            Directory = Directory:sub(3, -1)
        end

        if (not Directory:find("/")) then
            return WriteFile(Directory, Contents)
        end

        local Directories = Directory:split("/")
        local CurrentDirectory = ""
        
        for i = 1, #Directories - 1 do
            local Direct = Directories[i]
            CurrentDirectory = CurrentDirectory .. "/" .. Direct
            if (not IsFolder(CurrentDirectory)) then
                MakeFolder(CurrentDirectory)
            end
        end
        if Contents then
            return WriteFile(Directory, Contents)
        end
    else
        print("File System Isnt Supported With Your Exploit")
    end
end