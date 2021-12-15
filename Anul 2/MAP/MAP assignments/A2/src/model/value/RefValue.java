package model.value;

import model.type.IType;
import model.type.RefType;

public class RefValue implements IValue{
    private int address;
    private IType locationType;

    public RefValue(int addr, IType location) {
        address = addr;
        locationType = location;
    }
    public RefValue() {
        address = 0;
        locationType = null;
    }

    public int getAddr() {
        return address;
    }

    public IType getType() {
        return new RefType(locationType);
    }

    @Override
    public IValue deepCopy() {
        return new RefValue(address, locationType.deepCopy());
    }

    @Override
    public String toString() {
        return "(" + address + ", " + locationType + ")";
    }
}