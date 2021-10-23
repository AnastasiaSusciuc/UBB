package model.type;

import model.value.StringValue;
import model.value.IValue;

public class StringType implements IType {

    @Override
    public IValue defaultValue() {
        return new StringValue("");
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        return true;
    }

    @Override
    public String toString() {
        return "string";
    }

    @Override
    public IType deepCopy() {
        return new StringType();
    }
}
