package model.value;


import model.type.StringType;
import model.type.IType;

import java.util.Objects;

public class StringValue implements IValue{
    private String str;

    public StringValue(String str) {
        this.str = str;
    }

    public StringValue() {
        str = "";
    }

    public String getValue() {
        return str;
    }

    @Override
    public IType getType() {
        return new StringType();
    }

    @Override
    public IValue deepCopy() {
        return new StringValue(str);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        StringValue that = (StringValue) o;
        return Objects.equals(str, that.str);
    }

    @Override
    public String toString() {
        return str;
    }
}