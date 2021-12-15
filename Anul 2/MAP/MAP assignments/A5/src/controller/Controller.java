package controller;

import model.state.PrgState;
import model.exception.*;
import model.value.IValue;
import model.value.RefValue;
import repository.IRepository;


import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ExecutionException;
import java.util.stream.Stream;

public class Controller {
    private IRepository repository;
    private ExecutorService executor;


    public Controller(IRepository repository) {
        this.repository = repository;
    }

//    public PrgState oneStep(PrgState state) throws ADTException, StatementException, ExpressionException, ControllerException {
//        IMyStack<IStmt> stack = state.getStack();
//        if (stack.isEmpty()) {
//            throw new ControllerException("Stack is empty");
//        }
//        IStmt currentStmt = stack.pop();
//        System.out.println(currentStmt);
//        return currentStmt.execute(state);
//    }

    void oneStepForAllPrg(List<PrgState> prgList) throws ControllerException {
        //System.out.println(prgList);

        prgList.forEach(prg-> {
            try {
                repository.printPrgState(prg);
            } catch (RepositoryException | IOException e) {
                e.printStackTrace();
            }
        });
        List <Callable<PrgState>> callList = prgList.stream()
                .map((PrgState p)->(Callable<PrgState>)(p::oneStep))
                .collect(Collectors.toList());
        try {
            List<PrgState> newPrgList = executor.invokeAll(callList).stream()
                    .map(future -> {
                        try {
                            return future.get();
                        } catch (ExecutionException | InterruptedException e) {
                            //System.out.println(e.getMessage());
                        }
                        return null;
                    })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
            prgList.addAll(newPrgList);
        }
        catch(InterruptedException e)
        {
            throw  new ControllerException(e.getMessage());
        }

        prgList.forEach(prg -> {
            try {
                repository.printPrgState(prg);
            } catch (RepositoryException | IOException e) {
                e.printStackTrace();
            }
        });


        repository.setPrgList(prgList);
    }

    public void allStep() throws ControllerException, IOException, RepositoryException {
        executor = Executors.newFixedThreadPool(2);
        //remove the completed programs
        List<PrgState>  prgList=removeCompletedPrograms(repository.getPrgList());
        while(prgList.size() > 0){
            garbageCollector(prgList);
            prgList=removeCompletedPrograms(repository.getPrgList());
            prgList=removeDuplicateStates(prgList);
            oneStepForAllPrg(prgList);
        }

        executor.shutdownNow();
        repository.setPrgList(prgList);
    }

    public List<PrgState> removeDuplicateStates(List<PrgState> prgList) {
        return prgList.stream().distinct().collect(Collectors.toList());
    }

    List<PrgState> removeCompletedPrograms(List<PrgState> prgList){
        return prgList.stream().filter(p -> p.isNotCompleted()).collect(Collectors.toList());
    }

    Map<Integer, IValue> unsafeGarbageCollector(List<Integer> addresses, Map<Integer, IValue> heap) {
        return heap.entrySet().stream()
                .filter(elem -> addresses.contains(elem.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAddrFromSymTable(Collection<IValue> symTableValues, Collection<IValue> values) {
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

    void garbageCollector(List<PrgState> prgList) {
        List<Integer> adresses = Objects.requireNonNull(prgList.stream()
                .map(p -> getAddrFromSymTable(
                        p.getSymTable().getContent().values(),
                        p.getHeap().getContent().values()))
                .map(Collection::stream)
                .reduce(Stream::concat).orElse(null)).collect(Collectors.toList());
        prgList.forEach(programState -> {
            programState.getHeap().setContent(
                    unsafeGarbageCollector(
                            adresses,
                            prgList.get(0).getHeap().getContent()
                    ));
        });
    }
}

