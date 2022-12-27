local status_ok, surround = pcall(require, "nvim-surround")
if not status_ok then
  return
end

surround.setup {}


local hop_status_ok, hop = pcall(require, "hop")
if not hop_status_ok then
  return
end

hop.setup {}

