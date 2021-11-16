package model.statement;
import model.ADT.IMyDictionary;
import model.ADT.IMyList;
import model.ADT.IMyStack;
import model.exception.ADTException;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.IntType;
import model.type.StringType;
import model.value.IValue;
import model.value.IntValue;
import model.value.StringValue;


import java.io.BufferedReader;
import java.io.IOException;

public class ReadFileStmt implements IStmt {
    private IExp exp;
    private String varName;
    private String fileName;

    public ReadFileStmt(IExp expression, String varName) {
        this.exp = expression;
        this.varName = varName;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException, ADTException {
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IMyDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();

        if (symTable.isDefined(varName)) {
            if (symTable.lookup(varName).getType().equals(new IntType())) {
                IValue val = exp.eval(symTable);
                if (val.getType().equals(new StringType())) {
                    StringValue stringVal = (StringValue) val;
                    if (fileTable.isDefined(stringVal)) {
                        BufferedReader bufferedReader = fileTable.lookup(stringVal);
                        try {
                            String line = bufferedReader.readLine();
                            IValue intVal;
                            IntType type = new IntType();
                            if (line == null) {
                                intVal = type.defaultValue();
                            } else {
                                intVal = new IntValue(Integer.parseInt(line));
                            }
                            symTable.update(varName, intVal);
                        } catch (IOException e) {
                            throw new StatementException(e.getMessage());
                        }
                    }
                    else {
                        throw new StatementException("The file " + stringVal.getValue() + " is not in the File Table!");
                    }
                }
                else {
                    throw new StatementException("The value couldn't be evaluated to a string value!");
                }
            }
            else {
                throw new StatementException(varName + " is not of type int!");
            }
        }
        else {
            throw new StatementException(varName + " is not defined in Sym Table");
        }

        return null;
    }


    @Override
    public String toString() {
        return "Read From " + exp + " into " + varName;
    }

    @Override
    public IStmt deepCopy() {
        return new ReadFileStmt(exp.deepCopy(), new String(varName));
    }
}