package model.expression;
import model.ADT.IMyHeap;
import model.value.IValue;
import model.ADT.IMyDictionary;
import model.value.IntValue;
import model.type.IntType;
import model.exception.ExpressionException;

public class ArithExp implements IExp {
    IExp e1;
    IExp e2;
    int op; //1-plus, 2-minus, 3-star, 4-divide

    public ArithExp(IExp deepCopy, IExp deepCopy1, char op) {
        this.e1 = deepCopy;
        this.e2 = deepCopy1;
        if(op == '+')
            this.op = 1;
        if(op == '-')
            this.op = 2;
        if(op == '*')
            this.op = 3;
        if(op == '/')
            this.op = 4;
    }

    @Override
    public IValue eval(IMyDictionary<String, IValue> tbl, IMyHeap<IValue> heap) throws ExpressionException {
        IValue val1, val2;
        val1 = e1.eval(tbl, heap);
        if (val1.getType().equals(new IntType())) {
            val2 = e2.eval(tbl, heap);
            if (val2.getType().equals(new IntType())) {
                IntValue i1 = (IntValue)val1;
                IntValue i2 = (IntValue)val2;
                int n1 = i1.getValue();
                int n2 = i2.getValue();
                switch (op) {
                    case 1:
                        return new IntValue(n1 + n2);
                    case 2:
                        return new IntValue(n1 - n2);
                    case 3:
                        return new IntValue(n1 * n2);
                    case 4:
                        if (n2 == 0) {
                            throw new ExpressionException("Division by zero");
                        }
                        else {
                            return new IntValue(n1 / n2);
                        }
                    default:
                        throw new ExpressionException("Incorrect operation");
                }
            }
            else {
                throw new ExpressionException("Second operand is not an integer");
            }
        }
        else {
            throw new ExpressionException("First operand is not an integer");
        }

    }

    @Override
    public String toString() {
        switch (op) {
            case 1:
                return e1.toString() + "+" + e2.toString();
            case 2:
                return e1.toString() + "-" + e2.toString();
            case 3:
                return e1.toString() + "*" + e2.toString();
            case 4:
                return e1.toString() + '/' + e2.toString();
            default:
                return "";
        }
    }

    @Override
    public IExp deepCopy() {
        switch (op) {
            case 1:
                return new ArithExp(e1.deepCopy(), e2.deepCopy(), '+');
            case 2:
                return new ArithExp(e1.deepCopy(), e2.deepCopy(), '-');
            case 3:
                return new ArithExp(e1.deepCopy(), e2.deepCopy(), '*');
            case 4:
                return new ArithExp(e1.deepCopy(), e2.deepCopy(), '/');
            default:
                return new ArithExp(e1.deepCopy(), e2.deepCopy(), '+');
        }
    }
}
