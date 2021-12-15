package model.type;
import model.value.IValue;
import model.value.RefValue;
import java.util.Objects;

public class RefType implements IType{
    private IType inner;

    public RefType(IType inner)
    {
        this.inner=inner;
    }

    public RefType()
    {
        this.inner=null;
    }

    public IType getInner() {
        return inner;
    }

    public boolean equals(Object another){
        if (this == another) return true;
        if (another == null || getClass() != another.getClass()) return false;
        RefType refType = (RefType) another;
        return Objects.equals(inner, refType.inner);
    }

    public String toString() {
        return "Ref(" +inner.toString()+")";
    }

    public IValue defaultValue() {
        return new RefValue(0,inner);
    }

    @Override
    public IType deepCopy() {
        return new RefType(inner.deepCopy());
    }
}