package model.ADT;

import model.exception.ADTException;
import model.value.IValue;
import java.util.Map;

public interface IMyHeap<V> {
    int allocate(V value);
    void deallocate(int address);

    public void add(Integer id, V value) throws ADTException;
    boolean contains(int address);
    void update(int address, V value);
    V get(int address);

    Map<Integer, V> getContent();
    void setContent(Map<Integer, V> content);

}
