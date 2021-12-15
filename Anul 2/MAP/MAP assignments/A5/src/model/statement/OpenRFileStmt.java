package model.statement;
import model.ADT.IMyDictionary;
import model.ADT.IMyList;
import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.StringType;
import model.value.IValue;
import model.value.StringValue;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;


public class OpenRFileStmt implements IStmt {
    IExp expression;
    public OpenRFileStmt(IExp exp) {
        expression = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IValue val = expression.eval(symTable, state.getHeap());

        if (val.getType().equals(new StringType())) {
            IMyDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
            StringValue stringVal = (StringValue) val;
            if (!fileTable.isDefined(stringVal)) {
                try {
                    Reader reader = new FileReader(stringVal.getValue());
                    BufferedReader bufferedReader = new BufferedReader(reader);
                    fileTable.update(stringVal, bufferedReader);
                }
                catch (FileNotFoundException e) {
                    throw new StatementException(e.getMessage());
                }
            }
            else
                throw new StatementException("The file is already in use!");
        }
        else {
            throw new StatementException("Expression couldn't be evaluated to a string value in File Open!");
        }
        return null;// todo
    }

    @Override
    public String toString() {
        return "Open(" + expression + ")";
    }

    @Override
    public IStmt deepCopy() {
        return new OpenRFileStmt(expression.deepCopy());
    }
}
