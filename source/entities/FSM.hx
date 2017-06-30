package entities;

class FSM {

    private var stack:Array<Void->Void>;

    public function new() {
        stack = new Array<Void->Void>();
    }

    public function push(state:Void->Void):Void
    {
        if (getActiveState() != state)
            stack.push(state);
    }

    public function pop():Void->Void
    {
        return stack.pop();
    }

    public function getActiveState():Void->Void
    {
        if (stack.length > 0)
            return stack[stack.length - 1];
        else
            return null;
    }

    public function update(elapsed:Float):Void 
    {
        var activeState:Void->Void = getActiveState();
        if (activeState != null) 
        {
            activeState();
        }
    }
}