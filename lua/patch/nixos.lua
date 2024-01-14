local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

-- https://qiita.com/Sumi-Sumi/items/eda5894c0918f15ba971
local function return_exe_value(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()

    return result
end


local function is_bin(path)
    local elf = return_exe_value("file " .. path, true):find("ELF")
    if elf ~= nil then
        return true
    end

    return false
end

local mason_registry = require("mason-registry")
if vim.fn.has("linux") and vim.api.nvim_exec("!cat /etc/os-release | grep '^NAME'", true):find("NixOS") ~= nil then
    mason_registry:on("package:install:success", function(pkg)
        pkg:get_receipt():if_present(function(receipt)
            -- Figure out the interpreter inspecting nvim itself
            -- This is the same for all packages, so compute only once
            local interpreter = return_exe_value(
                "patchelf --print-interpreter $(type nvim | grep -oE '\\/nix\\/store\\/[a-z0-9]+-neovim-unwrapped-[0-9]+\\.[0-9]+\\.[0-9]+\\/bin\\/nvim' $(which nvim))"
            ):sub(1, -2)
            for _, rel_path in pairs(receipt.links.bin) do
                local bin_abs_path = pkg:get_install_path() .. "/" .. rel_path
                -- print("path is " .. bin_abs_path)
                if is_bin(bin_abs_path) == true then
                    local patch_cmd = ('patchelf --set-interpreter %s %s'):format(interpreter, bin_abs_path)
                    return_exe_value(patch_cmd)
                end
            end
        end)
    end)
end
