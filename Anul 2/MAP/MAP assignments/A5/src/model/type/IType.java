package model.type;

import model.value.IValue;

public interface IType {
    IType deepCopy();
    IValue defaultValue();
}
