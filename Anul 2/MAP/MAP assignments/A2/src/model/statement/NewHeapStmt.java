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


public class NewHeapStmt implements IStmt {
    String var_name;
    IExp exp;

    public NewHeapStmt(String var_name, IExp exp) {
        this.var_name = var_name;
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyStack<IStmt> stack = state.getStack();
        IMyDictionary <String, IValue> symTbl = state.getSymTable();
        IMyHeap<IValue> heap = state.getHeap();

        if(symTbl.isDefined(var_name)){
            if(symTbl.lookup(var_name).getType() instanceof RefType){
                IValue val = exp.eval(symTbl, heap);
                IValue tblVal = symTbl.lookup(var_name);
                if(val.getType().equals(((RefType)(tblVal.getType())).getInner())){
                    int addr = heap.allocate(val);
                    symTbl.update(var_name, new RefValue(addr, val.getType()));
                }
                else{
                    throw new StatementException("Value's type is not correct!");
                }
            }
            else{
                throw new StatementException("Value's type is not reference!");
            }
        }
        else{
            throw new StatementException("Value is not declared!");
        }
        state.setSymTable(symTbl);
        state.setHeap(heap);
        state.setExeStack(stack);
        return state;
    }

    @Override
    public IStmt deepCopy() {
        return new NewHeapStmt(var_name, exp.deepCopy());
    }

    @Override
    public String toString(){
        return "new(" + var_name + ", " + exp + ")";
    }
}