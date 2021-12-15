package model.statement;

import model.ADT.*;
import model.exception.ADTException;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.state.PrgState;
import model.value.IValue;
import model.value.StringValue;

import java.io.BufferedReader;
import java.util.Map;

public class ForkStmt implements IStmt{
    private IStmt statement;

    public ForkStmt(IStmt statement) {
        this.statement = statement;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException, ADTException {
        IMyStack<IStmt> stk = state.getStack();
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IMyHeap<IValue> heap = state.getHeap();
        IMyList<IValue> outList = state.getOutConsole();
        IMyDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();

        MyStack<IStmt> newStk = new MyStack<IStmt>();
        MyDictionary<String, IValue> newSymTable = new MyDictionary<String, IValue>();
        for (Map.Entry<String, IValue> entry: symTable.getContent().entrySet()) {
            newSymTable.update(new String(entry.getKey()), entry.getValue().deepCopy());
        }
        return new PrgState(newStk, newSymTable, outList, fileTable, heap, statement);
    }

    @Override
    public IStmt deepCopy() {
        return new ForkStmt(statement.deepCopy());
    }

    @Override
    public String toString() {
        return "ForkStmt{" +
                "statement=" + statement +
                '}';
    }
}
