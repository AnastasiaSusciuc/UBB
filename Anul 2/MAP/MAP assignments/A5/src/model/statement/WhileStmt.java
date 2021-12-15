package model.statement;


import model.ADT.IMyDictionary;
import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.BoolType;
import model.value.BoolValue;
import model.value.IValue;

public class WhileStmt implements IStmt {
    private IExp exp;
    private IStmt statement;

    public WhileStmt(IExp exp, IStmt statement) {
        this.exp = exp;
        this.statement = statement;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyStack<IStmt> stk = state.getStack();
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IValue val = exp.eval(symTable, state.getHeap());
        if (val.getType().equals(new BoolType())) {
            BoolValue boolVal = (BoolValue) val;
            if (boolVal.getValue()) {
                stk.push(this.deepCopy());
                stk.push(statement);
            }
        }
        else {
            throw new StatementException("The While condition is not a boolean");
        }
        return null;
    }


    @Override
    public IStmt deepCopy() {
        return new WhileStmt(exp.deepCopy(), statement.deepCopy());
    }

    @Override
    public String toString() {
        return "(while (" + exp + ") " + statement + ")";
    }
}