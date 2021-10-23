package Controller;

import Exception.CustomException;
import Model.IEntity;
import Repository.*;

public class Controller {
    IRepository repository;

    public Controller(IRepository repository) {
        this.repository = repository;
    }

    public void addElement(IEntity element) throws CustomException {
        repository.addElement(element);
    }

    public void removeElement(String name) throws CustomException {
        repository.deleteElement(name);
    }

    public String[] filterItems(int minimumAge) {
        String[] s = new String[repository.getElements().length];
        int size = 0;
        for(IEntity item: repository.getElements()) {
            if(item == null)
                break;
            if(item.isOlderThan(minimumAge)) {
                s[size++] = item.toString();
            }
        }
        String[] newArray = new String[size];
        System.arraycopy(s, 0, newArray, 0, size);

        return newArray;
    }
}