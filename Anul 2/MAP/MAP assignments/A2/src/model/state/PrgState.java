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
    private IStmt originalProgram;
    private IMyHeap<IValue> heap;

    public PrgState(IMyStack<IStmt> stk, IMyDictionary<String, IValue> symtbl, IMyList<IValue> ot, IMyDictionary<StringValue, BufferedReader> fT, IMyHeap<IValue> hp, IStmt prg) {
        exeStack = stk;
        symTable = symtbl;
        out = ot;
        fileTable = fT;
        originalProgram = prg;
        heap = hp;
        stk.push(prg);
    }

    public PrgState(IMyStack<IStmt> stack, MyDictionary<String, IValue> stringValueMyDictionary, MyList<IValue> valueMyList) {
        exeStack = stack;
        symTable = stringValueMyDictionary;
        out = valueMyList;
        heap = new MyHeap<IValue>();
    }

    @Override
    public String toString() {
        String str = "Program state\n" +
                "Exe Stack: " + exeStack + " \n" +
                "Sym Table: " + symTable + " \n" +
                "Output Console: " + out + " \n" +
                "Heap: " + heap + " \n" +
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

    public IMyHeap<IValue> getHeap() {
        return heap;
    }

    public void setFileTable(IMyDictionary<StringValue, BufferedReader> newFileTable) {
        fileTable = newFileTable;
    }

    public void setHeap(IMyHeap<IValue> hp) {
        heap = hp;
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