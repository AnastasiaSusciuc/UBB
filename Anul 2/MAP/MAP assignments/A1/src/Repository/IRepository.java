package Repository;
import Exception.CustomException;
import Model.*;

public interface IRepository {
    void addElement(IEntity elementToAdd) throws CustomException;
    IEntity[] getElements();
    void deleteElement(String name) throws CustomException;
    IEntity getElementFromPosition(int position) throws CustomException;
    void updateElement(int position, IEntity newElement) throws CustomException;
}