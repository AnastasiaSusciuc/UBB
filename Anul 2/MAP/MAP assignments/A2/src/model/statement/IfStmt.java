package model.statement;


import model.ADT.IMyStack;
import model.state.PrgState;
import model.exception.ExpressionException;
import model.exception.StatementException;
import model.expression.IExp;
import model.type.BoolType;
import model.value.BoolValue;
import model.value.IValue;

public class IfStmt implements IStmt {
    private IExp expression;
    private IStmt thenStatement;
    private IStmt elseStatement;

    public IfStmt(IExp e, IStmt thenSt, IStmt elseSt) {
        expression = e;
        thenStatement = thenSt;
        elseStatement = elseSt;
    }

    @Override
    public String toString() {
        return "if (" + expression + ") then {" + thenStatement + "} else {" + elseStatement + "}";
    }

    @Override
    public PrgState execute(PrgState state) throws StatementException, ExpressionException {
        IMyStack<IStmt> stack = state.getStack();
        IValue cond = expression.eval(state.getSymTable());
        if (!cond.getType().equals(new BoolType())) {
            throw new StatementException("Condition is not of boolean");
        }
        if (cond.equals(new BoolValue(true))) {
            stack.push(thenStatement.deepCopy());
        } else {
            stack.push(elseStatement.deepCopy());
        }
        state.setExeStack(stack);
        return state;
    }

    @Override
    public IStmt deepCopy() {
        return new IfStmt(expression.deepCopy(), thenStatement.deepCopy(), elseStatement.deepCopy());
    }

}