function init()
  storage.state = false

  self.interactive = config.getParameter("interactive", true)
  object.setInteractive(self.interactive)

  if config.getParameter("inputNodes") then
    processWireInput()
  end

  setEyeState(storage.state)
end

function onNodeConnectionChange(args)
  processWireInput()
end

function onInputNodeChange(args)
  processWireInput()
end

function onInteraction(args)
  if not config.getParameter("inputNodes") or not object.isInputNodeConnected(0) then
    storage.state = not storage.state
    setEyeState(storage.state)
  end
end

function processWireInput()
  if object.isInputNodeConnected(0) then
    object.setInteractive(false)
    storage.state = object.getInputNodeLevel(0)
    setEyeState(storage.state)
  elseif self.interactive then
    object.setInteractive(true)
  end
end

function setEyeState(newState)
  if newState then
    animator.setAnimationState("light", "on")
  else
    animator.setAnimationState("light", "off")
  end
end
