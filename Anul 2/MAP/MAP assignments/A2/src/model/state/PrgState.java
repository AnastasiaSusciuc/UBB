package model.state;

import model.ADT.*;
import model.statement.IStmt;
import model.value.StringValue;
import model.value.IValue;

import java.io.BufferedReader;

public class PrgState {
    private IMyStack<IStmt> exeStack;
    private IMyDictionary<String, IValue> symTable;
    private IMyList<IValue> out;
    private IMyDictionary<StringValue, BufferedReader> fileTable;
    private IStmt originalProgram; //optional field, but good to have

    public PrgState(IMyStack<IStmt> stk, IMyDictionary<String, IValue> symtbl, IMyList<IValue> ot, IMyDictionary<StringValue, BufferedReader> fT, IStmt prg) {
        exeStack = stk;
        symTable = symtbl;
        out = ot;
        fileTable = fT;
        originalProgram = prg;
        stk.push(prg);
    }

    public PrgState(IMyStack<IStmt> stack, MyDictionary<String, IValue> stringValueMyDictionary, MyList<IValue> valueMyList) {
        exeStack = stack;
        symTable = stringValueMyDictionary;
        out = valueMyList;
    }

    @Override
    public String toString() {
        String str = "Program state\n" +
                "Exe Stack: " + exeStack + " \n" +
                "Sym Table: " + symTable + " \n" +
                "Output Console: " + out + " \n" +
                "File Table: " + fileTable + " \n";
        return str;
    }

    public IMyStack<IStmt> getStack() {
        return exeStack;
    }

    public IMyDictionary<String, IValue> getSymTable() {
        return symTable;
    }

    public IStmt getOriginalProgram(){
        return originalProgram;
    }

    public IMyDictionary<StringValue, BufferedReader> getFileTable() {
        return fileTable;
    }

    public void setFileTable(IMyDictionary<StringValue, BufferedReader> newFileTable) {
        fileTable = newFileTable;
    }

    public void setExeStack(IMyStack<IStmt> stack) {
        exeStack = stack;
    }

    public void setSymTable(IMyDictionary<String, IValue> table) {
        symTable = table;
    }

    public IMyList<IValue> getOutConsole() {
        return out;
    }

    public void setOutConsole(IMyList<IValue> outConsole) {
        out = outConsole;
    }
}