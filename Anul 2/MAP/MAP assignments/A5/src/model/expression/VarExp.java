package model.expression;
import model.ADT.IMyHeap;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.exception.ExpressionException;


public class VarExp implements IExp {
    String var_ex;

    public VarExp(String s) {
        var_ex = s;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> tbl, IMyHeap<IValue> heap) throws ExpressionException {
        return tbl.lookup(var_ex);
    }

    @Override
    public String toString() {
        return var_ex;
    }

    @Override
    public IExp deepCopy() {
        return new VarExp(new String(var_ex));
    }
}
