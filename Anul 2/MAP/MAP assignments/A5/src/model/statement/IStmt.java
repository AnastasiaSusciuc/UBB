package model.statement;

import model.exception.*;
import model.state.PrgState;

public interface IStmt {
    public PrgState execute(PrgState state) throws StatementException, ExpressionException, ADTException;
    IStmt deepCopy();
}
