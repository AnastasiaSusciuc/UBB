package model.value;

import model.type.BoolType;
import model.type.IType;

public class BoolValue implements IValue {
    boolean val;

    public BoolValue(boolean v) {
        this.val = v;
    }

    public BoolValue() {
        val = false;
    }

    public boolean getValue() {
        return val;
    }

    @Override
    public String toString() {
        return val ? "true" : "false";
    }

    @Override
    public IType getType() {
        return new BoolType();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof BoolValue))
            return false;
        BoolValue t = (BoolValue) o;
        return t.val == val;
    }

    @Override
    public IValue deepCopy() {
        return new BoolValue(val);
    }
}