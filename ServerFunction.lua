-- Compiled with https://roblox-ts.github.io v0.2.14
-- August 13, 2019, 4:24 PM New Zealand Standard Time

local TS = require(script.Parent.vendor.RuntimeLib);
local exports = {};
local _0 = TS.import(script.Parent, "internal");
local findOrCreateRemote, IS_CLIENT, t_assert = _0.findOrCreateRemote, _0.IS_CLIENT, _0.t_assert;
local function t_string(value)
	return true;
end;
local NetServerFunction;
do
	NetServerFunction = setmetatable({}, {
		__tostring = function() return "NetServerFunction" end;
	});
	NetServerFunction.__index = NetServerFunction;
	function NetServerFunction.new(...)
		local self = setmetatable({}, NetServerFunction);
		self:constructor(...);
		return self;
	end;
	function NetServerFunction:constructor(name, ...)
		local recievedPropTypes = { ... };
		self.getCallback = function()
			warn(self.instance.Name .. "::getCallback is deprecated, use " .. self.instance.Name .. "::GetCallback instead!");
			return self:GetCallback();
		end;
		self.getClientCache = function()
			warn(self.instance.Name .. "::getClientCache is deprecated, use " .. self.instance.Name .. "::GetClientCache instead!");
			return self:GetClientCache();
		end;
		self.setCallback = function(func)
			warn(self.instance.Name .. "::setCallback is deprecated, use " .. self.instance.Name .. "::SetCallback instead!");
			return self:SetCallback(func);
		end;
		self.setClientCache = function(timeout)
			warn(self.instance.Name .. "::setClientCache is deprecated, use " .. self.instance.Name .. "::SetClientCache instead!");
			return self:SetClientCache(timeout);
		end;
		self.instance = findOrCreateRemote("RemoteFunction", name);
		assert(not IS_CLIENT, "Cannot create a Net.ServerFunction on the Client!");
		if #recievedPropTypes > 0 then
			self.propTypes = recievedPropTypes;
		end;
	end;
	function NetServerFunction:GetCallback()
		return self.instance.OnServerInvoke;
	end;
	function NetServerFunction:SetCallback(func)
		if self.propTypes ~= nil then
			self.instance.OnServerInvoke = function(player, ...)
				local args = { ... };
				if t_assert(self.propTypes, args) then
					return func(player, unpack(args));
				else
					error("Client failed type checks", 2);
				end;
			end;
		else
			self.instance.OnServerInvoke = func;
		end;
		return self;
	end;
	function NetServerFunction:GetInstance()
		return self.instance;
	end;
	function NetServerFunction:GetClientCache()
		local cache = self.instance:FindFirstChild("Cache");
		if cache then
			return cache.Value;
		else
			return 0;
		end;
	end;
	function NetServerFunction:SetClientCache(time)
		local cache = self.instance:FindFirstChild("Cache");
		if not cache then
			local cacheTimer = Instance.new("NumberValue", self.instance);
			cacheTimer.Value = time;
			cacheTimer.Name = "Cache";
		else
			cache.Value = time;
		end;
		return self;
	end;
end;
exports.default = NetServerFunction;
return exports;