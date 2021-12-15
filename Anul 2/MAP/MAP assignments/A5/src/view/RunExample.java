package view;

import controller.Controller;
import model.exception.*;

import java.io.IOException;

public class RunExample extends Command {
    private Controller controller;

    public RunExample(String key, String description, Controller controller) {
        super(key, description);
        this.controller = controller;
    }

    @Override
    public void execute() {
        try {
            controller.allStep();
        }
        catch (ControllerException | RepositoryException | IOException e) {
            System.out.println(e.toString());
        }
    }
}
