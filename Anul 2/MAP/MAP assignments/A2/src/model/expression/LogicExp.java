package model.expression;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.value.BoolValue;
import model.type.BoolType;
import model.exception.ExpressionException;

public class LogicExp implements IExp {
    IExp e1;
    IExp e2;
    int op;

    public LogicExp(IExp deepCopy, IExp deepCopy1, int op1) {
        e1 = deepCopy;
        e2 = deepCopy1;
        op = op1;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> tbl) throws ExpressionException {
        IValue val1, val2;
        val1 = e1.eval(tbl);
        if (val1.getType().equals(new BoolType())) {
            val2 = e2.eval(tbl);
            if (val2.getType().equals(new BoolType())) {
                BoolValue i1 = (BoolValue)val1;
                BoolValue i2 = (BoolValue)val2;
                boolean x = i1.getValue();
                boolean y = i2.getValue();
                if (op == 1) {
                    return new BoolValue(x && y);
                }
                else if (op == 2) {
                    return new BoolValue(x || y);
                }
            }
            else {
                throw new ExpressionException("Second operand is not a boolean");
            }
        }
        else {
            throw new ExpressionException("First operand is not a boolean");
        }

        return new BoolValue(false);
    }

    @Override
    public IExp deepCopy() {
        return new LogicExp(e1.deepCopy(), e2.deepCopy(), op);
    }

}