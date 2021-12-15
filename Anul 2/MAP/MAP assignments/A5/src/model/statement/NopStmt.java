package model.statement;

import model.exception.StatementException;
import model.state.PrgState;

public class NopStmt implements IStmt {
    @Override
    public PrgState execute(PrgState state) throws StatementException {
        return null;
    }
    @Override
    public IStmt deepCopy() {
        return new NopStmt();
    }
}