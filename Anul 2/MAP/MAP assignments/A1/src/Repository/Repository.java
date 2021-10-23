package Repository;

import Exception.CustomException;
import Model.IEntity;

import java.util.Objects;

public class Repository implements IRepository {
    private IEntity[] all_animals;
    private int size;
    private int length;

    public Repository(int maxCapacity) {
        all_animals = new IEntity[maxCapacity];
        size = 0;
        length = maxCapacity;
    }

    @Override
    public void addElement(IEntity elementToAdd) throws CustomException {
        if(size == length) {
            throw new CustomException("Limit reached!");
        }
        all_animals[size++] = elementToAdd;
    }

    @Override
    public IEntity[] getElements() {
        return all_animals;
    }

    @Override
    public void deleteElement(String name) throws CustomException {
        int was_erased = 0;
        for (int i = size-1; i >= 0; i--)
            if (Objects.equals(all_animals[i].getName(), name))
            {
                IEntity aux = all_animals[i];
                all_animals[i] = all_animals[size-1];
                size--;
                was_erased = 1;
            }
        if (was_erased == 0)
            throw new CustomException("No animals with this name!");
    }

    @Override
    public IEntity getElementFromPosition(int position) throws CustomException {
        if(position >= size || position < 0)
            throw new CustomException("Invalid position");
        return all_animals[position];
    }

    @Override
    public void updateElement(int position, IEntity newElement) throws CustomException {
        if(position >= size || position < 0)
            throw new CustomException("Invalid position");
        all_animals[position] = newElement;
    }
}