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
import model.value.RefValue;
import repository.IRepository;


import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


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
        System.out.println(currentStmt);
        return currentStmt.execute(state);
    }

    public void allStep() throws ControllerException, IOException, RepositoryException {
        PrgState prg = repository.getCrtPrg();
        repository.printPrgState(prg);

        while (!prg.getStack().isEmpty()) {
            try {
                oneStep(prg);

//                prg.getHeap().setContent(unsafeGarbageCollector(
//                        getAddrFromSymTable(prg.getSymTable().getContent().values()),
//                        prg.getHeap().getContent()));
                prg.getHeap().setContent(garbage_collector(get_used_addresses(prg.getSymTable().getContent().values(),
                        prg.getHeap().getContent().values()), prg.getHeap().getContent()));
                repository.printPrgState(prg);
            } catch (ControllerException | ADTException | StatementException | ExpressionException exception) {
//                System.out.println(exception.getMessage());
                throw new ControllerException(exception.getMessage());
            }
        }
    }

    Map<Integer, IValue> unsafeGarbageCollector(List<Integer> addresses, Map<Integer, IValue> heap) {
        return heap.entrySet().stream()
                .filter(elem -> addresses.contains(elem.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
    List<Integer> getAddrFromSymTable(Collection<IValue> symTableValues) {
        return symTableValues.stream()
                .filter(v -> v instanceof RefValue)
                .map(v -> {
                    RefValue v1 = (RefValue) v;
                    return v1.getAddr();
                })
                .collect(Collectors.toList());
    }

    private List<Integer> get_used_addresses(Collection<IValue> symbols_table_values, Collection<IValue> heap_table_values)
    {
        List<Integer> symbols_table_addresses = symbols_table_values.stream()
                .filter(v -> v instanceof RefValue)
                .map(value->{RefValue value2 = (RefValue) value;
                    return value2.getAddr();})
                .collect(Collectors.toList());

        List<Integer> heap_table_addresses = heap_table_values.stream()
                .filter(v -> v instanceof RefValue)
                .map(value->{RefValue value2 = (RefValue) value;
                    return value2.getAddr();})
                .collect(Collectors.toList());

        symbols_table_addresses.addAll(heap_table_addresses);
        return symbols_table_addresses;
    }

    private Map<Integer, IValue> garbage_collector(List<Integer> used_addresses, Map<Integer, IValue> heap)
    {
        return heap.entrySet().stream()
                .filter(e -> used_addresses.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
}

