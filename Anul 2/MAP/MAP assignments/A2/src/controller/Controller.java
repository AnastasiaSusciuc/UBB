package controller;

import model.ADT.IMyStack;
import model.ADT.MyDictionary;
import model.ADT.MyList;
import model.ADT.MyStack;
import model.state.PrgState;
import model.exception.*;
import model.expression.ArithExp;
import model.expression.ValueExp;
import model.expression.VarExp;
import model.statement.*;
import model.type.BoolType;
import model.type.IntType;
import model.value.BoolValue;
import model.value.IValue;
import model.value.IntValue;
import repository.IRepository;


import java.io.IOException;

public class Controller {
    private IRepository repository;

    public Controller(IRepository repository) {
        this.repository = repository;
    }

    public PrgState oneStep(PrgState state) throws ADTException, StatementException, ExpressionException, ControllerException {
        IMyStack<IStmt> stack = state.getStack();
        if (stack.isEmpty()) {
            throw new ControllerException("Stack is empty");
        }
        IStmt currentStmt = stack.pop();
        return currentStmt.execute(state);
    }

    public void allStep() throws ControllerException, IOException, RepositoryException {
        PrgState prg = repository.getCrtPrg();
        repository.printPrgState(prg);

        while (!prg.getStack().isEmpty()) {
            try {
                oneStep(prg);
                repository.printPrgState(prg);
            } catch (ControllerException | ADTException | StatementException | ExpressionException exception) {
                throw new ControllerException(exception.getMessage());
            }
        }
    }


}
