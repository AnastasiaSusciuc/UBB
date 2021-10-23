package model.statement;

import model.ADT.IMyList;
import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.value.IValue;

public class PrintStmt implements IStmt{
    IExp exp;

    public PrintStmt(IExp deepCopy) {
        exp = deepCopy;
    }

    @Override
    public String toString(){
        return "print(" + exp.toString() +")";
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyStack<IStmt> stack = state.getStack();
        IMyList<IValue> outConsole = state.getOutConsole();
        outConsole.add(exp.eval(state.getSymTable()));
        state.setExeStack(stack);
        state.setOutConsole(outConsole);
        return state;
    }

    @Override
    public IStmt deepCopy() {
        return new PrintStmt(exp.deepCopy());
    }

}
