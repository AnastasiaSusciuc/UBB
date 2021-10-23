package view;

import controller.Controller;
import model.exception.*;
import repository.*;

import java.io.IOException;

public class AppView {
    Controller controller;

    public void printMenu() {
        System.out.println("****************\n");
        System.out.println("Example_1 = int x;  x=17;   print(x)\n");
        System.out.println("Example_2 = int x;  x=3+5*7;    print(x)\n");
        System.out.println("Example_3 = bool s; int x;  s=false;    if (s == true) then {x=20} else {x=2};  print(x)\n");
        System.out.println("****************\n");
    }

    public AppView() {
        IRepository repository = new Repository("log.txt");
        this.controller = new Controller(repository);
        printMenu();
        try {
            controller.example();
            controller.allStep();
        } catch (RepositoryException | ControllerException | IOException e) {
            System.out.println(e.getMessage());
        }
    }
}