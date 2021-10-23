package model.expression;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.exception.ExpressionException;

public interface IExp {
    public IValue eval(IMyDictionary <String, IValue> table) throws ExpressionException;

    IExp deepCopy();
}
