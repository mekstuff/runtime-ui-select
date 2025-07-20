-- Compiled with roblox-ts v3.0.0
local GoodSignal = require(script.Parent:WaitForChild("GoodSignal"))
local Signal
do
	Signal = setmetatable({}, {
		__tostring = function()
			return "Signal"
		end,
	})
	Signal.__index = Signal
	function Signal.new(...)
		local self = setmetatable({}, Signal)
		return self:constructor(...) or self
	end
	function Signal:constructor()
		-- this.Qsig = new QuentySignal<params>();
		self.ClassName = "Signal"
		self._dev = {}
		self._id = "Signal" .. tostring(math.random())
		self.Qsig = GoodSignal.new()
		-- this.Qsig = new QuentySignal<params>();
	end
	function Signal:IsA(Class)
		if Class == "Signal" or Class == "Pseudo" then
			return true
		end
		return false
	end
	function Signal:DisconnectAll()
		if not self.Qsig then
			return nil
		end
		return self.Qsig:DisconnectAll()
	end
	function Signal:Connect(Callback)
		if not self.Qsig then
			return nil
		end
		local _callback = Callback
		local _exp = type(_callback) == "function"
		local _callback_1 = Callback
		local _arg1 = `Expected function as callback, got {typeof(_callback_1)}`
		assert(_exp, _arg1)
		return self.Qsig:Connect(Callback)
	end
	function Signal:ConnectParallel(Callback)
		if not self.Qsig then
			return nil
		end
		local _callback = Callback
		local _exp = type(_callback) == "function"
		local _callback_1 = Callback
		local _arg1 = `Expected function as callback, got {typeof(_callback_1)}`
		assert(_exp, _arg1)
		return self.Qsig:ConnectParallel(Callback)
	end
	function Signal:Once(Callback)
		if not self.Qsig then
			return nil
		end
		local _callback = Callback
		local _exp = type(_callback) == "function"
		local _callback_1 = Callback
		local _arg1 = `Expected function as callback, got {typeof(_callback_1)}`
		assert(_exp, _arg1)
		return self.Qsig:Once(Callback)
	end
	function Signal:Fire(...)
		local args = { ... }
		if not self.Qsig then
			return nil
		end
		return self.Qsig:Fire(unpack(args))
	end
	function Signal:Wait()
		if not self.Qsig then
			return nil
		end
		return self.Qsig:Wait()
		-- const res = this.Qsig.Wait() as never;
		-- if (!res) {
		-- 	return undefined as never;
		-- }
		-- return $tuple(...res);
	end
	function Signal:Destroy()
		if not self.Qsig then
			return nil
		end
		self.Qsig:DisconnectAll()
		self.Qsig = nil
	end
end
return {
	Signal = Signal,
}
