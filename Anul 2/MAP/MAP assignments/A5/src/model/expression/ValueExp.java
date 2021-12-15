package model.expression;
import model.ADT.IMyHeap;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.exception.ExpressionException;

public class ValueExp implements IExp {
    IValue val_ex;

    public ValueExp(IValue deepCopy) {
        val_ex = deepCopy;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> tbl, IMyHeap<IValue> heap) throws ExpressionException {
        return val_ex;
    }

    @Override
    public String toString() {
        return val_ex.toString();
    }

    @Override
    public IExp deepCopy() {
        return new ValueExp(val_ex.deepCopy());
    }
}
