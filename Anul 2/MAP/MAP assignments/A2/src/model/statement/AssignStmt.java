package model.statement;

import model.exception.ExpressionException;
import model.ADT.IMyDictionary;
import model.state.PrgState;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.IType;
import model.value.IValue;

public class AssignStmt implements IStmt {
    String id;
    IExp exp;

    public AssignStmt(String s, IExp copy) {
        id = s;
        exp = copy;
    }

    @Override
    public String toString(){
        return id+"="+ exp.toString();
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IValue value = exp.eval(symTable);
        if (symTable.isDefined(id)) {
            IType type = (symTable.lookup(id)).getType();
            if (value.getType().equals(type)) {
                symTable.update(id, value);
            }
            else {
                throw new StatementException("Declared type of variable " +
                        id +
                        " and type of the assigned expression do not match");
            }
        }
        else {
            throw new StatementException("The used variable " + id + " was not declared before");
        }
        state.setSymTable(symTable);
        return state;
    }
    @Override
    public IStmt deepCopy() {
        return new AssignStmt(new String(id), exp.deepCopy());
    }
}