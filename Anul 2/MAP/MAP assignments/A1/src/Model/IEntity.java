package Model;
/*
8. Intr-un acvariu traiesc pesti si broaste testoase.
Sa se afiseze toate vietuitoarele din acvariu care sunt
mai batrine de 1 an.
* */

public interface IEntity {
    int getAge();
    void setAge(int age);
    String getName();
    void setName(String name);
    boolean isOlderThan(int age);
}
