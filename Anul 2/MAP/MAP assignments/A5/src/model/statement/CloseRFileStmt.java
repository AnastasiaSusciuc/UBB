package model.statement;

import model.ADT.IMyDictionary;
import model.ADT.IMyList;
import model.ADT.IMyStack;
import model.exception.ADTException;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.value.IValue;
import model.type.IntType;
import model.type.StringType;
import model.value.IntValue;
import model.value.StringValue;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFileStmt implements IStmt {
    private IExp exp;

    public CloseRFileStmt(IExp exp) {
        this.exp = exp;
    }


    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException, ADTException {
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IValue val = exp.eval(symTable, state.getHeap());
        if (val.getType().equals(new StringType())) {
            IMyDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
            StringValue stringVal = (StringValue) val;
            if (fileTable.isDefined(stringVal)) {
                BufferedReader bufferedReader = fileTable.lookup(stringVal);
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    throw new StatementException(e.getMessage());
                }
                fileTable.remove(stringVal);
            } else {
                throw new StatementException("The file doesn't exist in the File Table!");
            }
        }
        else {
            throw new StatementException("Expression could not be evaluated to a string in File Close!");
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return "close(" + exp + ")";
    }
}