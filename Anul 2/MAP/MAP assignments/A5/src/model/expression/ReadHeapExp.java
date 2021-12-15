package model.expression;

import model.ADT.IMyDictionary;
import model.ADT.IMyHeap;
import model.exception.ExpressionException;
import model.value.RefValue;
import model.value.IValue;

public class ReadHeapExp implements IExp {
    private IExp exp;

    public ReadHeapExp(IExp exp) {
        this.exp = exp;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symTable, IMyHeap<IValue> heap) throws ExpressionException {
        IValue val = exp.eval(symTable, heap);
        if (val instanceof RefValue) {
            RefValue refVal = (RefValue) val;
            if (heap.contains(refVal.getAddr())) {
                return heap.get(refVal.getAddr());
            } else {
                throw new ExpressionException("The address doesn't exist in the heap");
            }

        } else {
            throw new ExpressionException("The expression could not be evaluated to a RefValue");
        }
    }

    @Override
    public IExp deepCopy() {
        return new ReadHeapExp(exp.deepCopy());
    }


    @Override
    public String toString() {
        return "rH(" + exp + ")";
    }
}