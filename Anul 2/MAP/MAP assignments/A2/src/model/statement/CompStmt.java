package model.statement;

import model.exception.*;
import model.ADT.IMyStack;
import model.state.PrgState;

public class CompStmt implements IStmt {
    private IStmt first;
    private IStmt second;

    public CompStmt(IStmt deepCopy, IStmt deepCopy1) {
        first = deepCopy;
        second = deepCopy1;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException {
        IMyStack <IStmt> stack = state.getStack();
        stack.push(second);
        stack.push(first);
        state.setExeStack(stack);
        return state;
    }

    @Override
    public String toString() {
        return "(" + first + ";" + second + ")";
    }

    @Override
    public IStmt deepCopy() {
        return new CompStmt(first.deepCopy(), second.deepCopy());
    }

}
