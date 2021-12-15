package repository;

import model.state.PrgState;
import model.exception.RepositoryException;
import model.statement.IStmt;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

public class Repository implements IRepository {
    private List<PrgState> states;
    private IStmt originalProgram;
    private String fileName;

    public Repository(PrgState prgState, String fileName) throws RepositoryException, IOException {
        originalProgram = prgState.getOriginalProgram();
        this.fileName = fileName;
        File myFile = new File(fileName);
        myFile.createNewFile();
        try (FileWriter fileWriter = new FileWriter(myFile)) {
            fileWriter.write("");
        }
        catch (IOException e) {
            throw new RepositoryException(e.getMessage());
        }
        states = new LinkedList<>();
    }

    @Override
    public List<PrgState> getPrgList() {
        return states;
    }

//    @Override
//    public PrgState getCrtPrg() {
//        PrgState state = states.get(0);
//        states.remove(0);
//        return state;
//    }

    @Override
    public IStmt getOriginalProgram() {
        return originalProgram;
    }

    @Override
    public void printPrgState(PrgState prgState) throws RepositoryException, IOException {
        File yourFile = new File(fileName);
        boolean res = yourFile.createNewFile();
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(yourFile, true));
            PrintWriter logFile = new PrintWriter(bw);

            logFile.write(prgState + "\n");
            logFile.close();
        }
        catch (IOException e) {
            throw new RepositoryException(e.getMessage());
        }
    }

    @Override
    public void addState(PrgState state) {
        states.add(state);
    }

    public void setPrgList(List<PrgState> state_lst) {
        states = state_lst;
    }

}
