package model.statement;

import model.ADT.IMyDictionary;
import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ADTException;
import model.exception.StatementException;
import model.type.BoolType;
import model.type.IType;
import model.type.IntType;
import model.type.StringType;
import model.value.BoolValue;
import model.value.IValue;
import model.value.IntValue;
import model.value.StringValue;

public class VarDeclStmt implements IStmt {
    String name;
    IType type;

    public VarDeclStmt(String s, IType deepCopy) {
        name = s;
        type = deepCopy;
    }

    public PrgState execute(PrgState state) throws StatementException, ADTException {
        IMyStack <IStmt> stack = state.getStack();
        IMyDictionary <String, IValue> table = state.getSymTable();
        if (table.isDefined(name)) {
            throw new StatementException("Variable is already declared");
        } else {
            if (type.equals(new IntType())) {
                table.add(name, new IntValue());
            }else if (type.equals(new BoolType())) {
                table.add(name, new BoolValue());
            }else if (type.equals(new StringType())) {
                table.add(name, new StringValue());
            }  else {
                throw new StatementException("Type does not exist");
            }
        }
        state.setSymTable(table);
        state.setExeStack(stack);
        return state;
    }

    @Override
    public String toString() {
        return type + " " + name;
    }

    @Override
    public IStmt deepCopy() {
        return new VarDeclStmt(new String(name), type.deepCopy());
    }

}
