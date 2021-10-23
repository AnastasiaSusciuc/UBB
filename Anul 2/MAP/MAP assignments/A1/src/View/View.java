package View;
import Controller.*;
import Exception.CustomException;
import Repository.Repository;
import Repository.IRepository;
import Model.*;

public class View {
    public static void main() {
        IRepository repo = new Repository(10);
        Controller controller = new Controller(repo);

        Fish fish1 = new Fish("Nemo", "orange", 17);
        Fish fish2 = new Fish("Bubba", "golden", 10);
        Turtle turtle1 = new Turtle("Leonardo", 124);
        Turtle turtle2 = new Turtle( "Mack", 2);

        try {
            controller.addElement(fish1);
            controller.addElement(fish2);
            controller.addElement(turtle1);
            controller.addElement(turtle2);
        }
        catch (CustomException exception) {
            System.out.println(exception.toString());
        }
        String[] array = controller.filterItems(10);
        for(String el: array) {
            System.out.println(el);
        }

        try {
           controller.removeElement("Leonardo");
        }
        catch (CustomException exception) {
            System.out.println(exception.toString());
        }
        System.out.println();
        array = controller.filterItems(10);
        for(String el: array) {
            System.out.println(el);
        }
    }
}