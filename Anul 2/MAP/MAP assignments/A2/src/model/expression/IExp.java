package model.expression;
import model.ADT.IMyHeap;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.exception.ExpressionException;

public interface IExp {
    public IValue eval(IMyDictionary <String, IValue> table, IMyHeap<IValue> heap) throws ExpressionException;
    IExp deepCopy();
}
