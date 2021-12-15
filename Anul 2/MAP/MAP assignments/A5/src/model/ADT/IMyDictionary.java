package model.ADT;
import model.exception.ADTException;

import java.util.Map;

public interface IMyDictionary<K, V> {
    public V lookup(K key);
    public void update(K key, V value);
    public void remove(K key) throws ADTException;

    boolean isDefined(K id);
    public Map<K, V> getContent();
    void add(K name, V intValue) throws ADTException;
}
