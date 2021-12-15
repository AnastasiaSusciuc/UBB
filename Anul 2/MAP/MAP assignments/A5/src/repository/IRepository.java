package repository;
import model.state.PrgState;
import model.exception.RepositoryException;
import model.statement.IStmt;

import java.io.IOException;
import java.util.List;


public interface IRepository {
    public List<PrgState> getPrgList();
//    PrgState getCrtPrg();
    IStmt getOriginalProgram();
    void printPrgState(PrgState prgState) throws RepositoryException, IOException;
    void setPrgList(List<PrgState> state_lst);
    void addState(PrgState state);
}