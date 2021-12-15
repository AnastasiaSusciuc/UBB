package model.expression;
import model.ADT.IMyHeap;
import model.type.IntType;
import model.value.BoolValue;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.exception.ExpressionException;
import model.value.IntValue;


public class RelationalExp implements IExp {
    private IExp exp1;
    private IExp exp2;
    private int op; // 1 <, 2 <=, 3 ==, 4 !=, 5 >, 6 >=

    public RelationalExp(IExp exp1, IExp exp2, int op) {
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.op = op;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> symTable, IMyHeap<IValue> heap) throws ExpressionException {
        IValue val1, val2;
        val1 = exp1.eval(symTable, heap);
        val2 = exp2.eval(symTable, heap);
        if (val1.getType().equals(new IntType()) && val2.getType().equals(new IntType())) {
            IntValue intVal1, intVal2;
            intVal1 = (IntValue) val1;
            intVal2 = (IntValue) val2;
            int x = intVal1.getValue();
            int y = intVal2.getValue();
            switch (op) {
                case 1:
                    return new BoolValue(x < y);
                case 2:
                    return new BoolValue(x <= y);
                case 3:
                    return new BoolValue(x == y);
                case 4:
                    return new BoolValue(x != y);
                case 5:
                    return new BoolValue(x > y);
                case 6:
                    return new BoolValue(x >= y);
            }
        }
        else {
            throw new ExpressionException("At least one operand is not an integer");
        }

        return new BoolValue(false);
    }

    @Override
    public String toString() {
        String s = "";
        switch (op) {
            case 1:
                s = "<";
                break;
            case 2:
                s = "<=";
                break;
            case 3:
                s = "==";
                break;
            case 4:
                s = "!=";
                break;
            case 5:
                s = ">";
                break;
            default:
                s = ">=";
        }
        return exp1 + s + exp2;
    }

    @Override
    public IExp deepCopy() {
        return new RelationalExp(exp1.deepCopy(), exp2.deepCopy(), op);
    }
}