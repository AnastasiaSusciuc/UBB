package model.value;

import model.type.IntType;
import model.type.IType;

public class IntValue implements IValue {
    int val;

    public IntValue(int v) {
        val = v;
    }

    public IntValue() {
        val = 0;
    }

    public int getValue() {
        return val;
    }

    @Override
    public String toString() {
        return Integer.toString(val);
    }

    @Override
    public IType getType() {
        return new IntType();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof IntValue))
            return false;
        IntValue t = (IntValue) o;
        return t.val == val;
    }

    @Override
    public IValue deepCopy() {
        return new IntValue(val);
    }

}
