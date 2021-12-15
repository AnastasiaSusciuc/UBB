package model.statement;

import model.ADT.IMyDictionary;
import model.ADT.IMyHeap;
import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ADTException;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.RefType;
import model.value.RefValue;
import model.value.IValue;

public class WriteHeapStmt implements IStmt {
    private String variableName;
    private IExp exp;

    public WriteHeapStmt(String variableName, IExp exp) {
        this.variableName = variableName;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyDictionary<String, IValue> symTable = state.getSymTable();
        IMyHeap<IValue> heap = state.getHeap();

        if (symTable.isDefined(variableName)) {
            if (symTable.lookup(variableName).getType() instanceof RefType) {
                RefValue refVal = (RefValue) symTable.lookup(variableName);
                if (heap.contains(refVal.getAddr())) {
                    IValue val = exp.eval(symTable, heap);
                    if (symTable.lookup(variableName).getType().equals(new RefType(val.getType()))) {
                        int address = refVal.getAddr();
                        heap.update(address, val);
                    }
                    else {
                        throw new StatementException("The pointing variable has a different type than the evaluated expression.");
                    }
                }
                else {
                    throw new StatementException("The address to which " + variableName + " points is not in the heap");
                }
            }
            else {
                throw new StatementException(variableName + " is not a reference variable");
            }
        }
        else {
            throw new StatementException(variableName + " is not defined");
        }

        return null;
    }


    @Override
    public IStmt deepCopy() {
        return new WriteHeapStmt(new String(variableName), exp.deepCopy());
    }

    @Override
    public String toString() {
        return "wH(" + variableName + "," + exp + ")";
    }
}