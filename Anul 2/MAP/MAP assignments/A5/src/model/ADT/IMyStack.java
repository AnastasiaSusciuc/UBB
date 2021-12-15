package model.ADT;

import model.exception.ADTException;

public interface IMyStack <T> {
    public T pop() throws ADTException;
    public void push(T value);
    boolean isEmpty();
}
