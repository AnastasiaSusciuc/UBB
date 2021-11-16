import java.io.BufferedReader;
import java.io.IOException;

import controller.Controller;
import model.ADT.IMyStack;
import model.ADT.MyDictionary;
import model.ADT.MyList;
import model.ADT.MyStack;
import model.expression.*;
import model.state.PrgState;
import model.exception.*;
import model.statement.*;
import model.type.BoolType;
import model.type.IntType;
import model.type.StringType;
import model.value.BoolValue;
import model.value.IValue;
import model.value.IntValue;
import model.value.StringValue;
import repository.IRepository;
import repository.Repository;
import view.ExitCommand;
import view.RunExample;
import view.TextMenu;


public class Main {
    public static void main(String[] args) throws IOException, RepositoryException, ControllerException {
        IMyStack<IStmt> stack1 = new MyStack<>();
        IMyStack<IStmt> stack2 = new MyStack<>();
        IMyStack<IStmt> stack3 = new MyStack<>();
        IMyStack<IStmt> stack4 = new MyStack<>();
        IMyStack<IStmt> stack5 = new MyStack<>();

        IStmt example_1 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );


        PrgState prg1 = new PrgState(stack1, new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), example_1);
        IRepository repo1 = new Repository(prg1, "log1.txt");
        Controller ctr1 = new Controller(repo1);

        IStmt example_2 = new CompStmt(
               new VarDeclStmt("a", new IntType()), new CompStmt(
                   new VarDeclStmt("b", new IntType()), new CompStmt(
                        new AssignStmt("a", new ArithExp(new ValueExp(new IntValue(2)),
                                new ArithExp(
                                    new ValueExp(new IntValue(3)),
                                    new ValueExp(new IntValue(5)), '*'),
                                '+')), new CompStmt(
                   new AssignStmt("b", new ArithExp(new VarExp("a"), new ValueExp(new IntValue(1)), '+')),
                   new PrintStmt(new VarExp("b")))
        )));
        PrgState prg2= new PrgState(stack2, new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), example_2);
        IRepository repo2 = new Repository(prg2, "log2.txt");
        Controller ctr2 = new Controller(repo2);

        IStmt example_3 = new CompStmt(
                new VarDeclStmt("a" , new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(
                                new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(
                                        new IfStmt(
                                                new VarExp("a"),
                                                new AssignStmt("v", new ValueExp(new IntValue(2))),
                                                new AssignStmt("v", new ValueExp(new IntValue(3)))
                                        ),
                                        new PrintStmt(new VarExp("v"))
                                )
                        )
                )
        );

        PrgState prg3 = new PrgState(stack3, new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), example_3);
        IRepository repo3 = new Repository(prg3, "log3.txt");
        Controller ctr3 = new Controller(repo3);

        IStmt example_4 = new CompStmt(new VarDeclStmt("varf", new StringType()), new CompStmt(new AssignStmt("varf", new ValueExp(new StringValue("test.in"))),
                new CompStmt(new OpenRFileStmt(new VarExp("varf")), new CompStmt(new VarDeclStmt("varc", new IntType()),
                        new CompStmt(new ReadFileStmt(new VarExp("varf"),"varc"), new CompStmt(new PrintStmt(new VarExp("varc")),
                                new CompStmt(new ReadFileStmt(new VarExp("varf"),"varc"), new CompStmt(new PrintStmt(new VarExp("varc")), new CloseRFileStmt(new VarExp("varf"))))))))));

        PrgState prg4 = new PrgState(stack4, new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), example_4);
        IRepository repo4 = new Repository(prg4, "log4.txt");
        Controller ctr4 = new Controller(repo4);

        // int nr2 = 0;
        // int v = 2;
        // if (v < nr2)
        //  print(v);
        // else
        // print(nr2);
        IStmt example_5 = new CompStmt(new VarDeclStmt("nr2",new IntType()), new CompStmt(new VarDeclStmt("v",new IntType()),
                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(2))), new IfStmt(new RelationalExp(new VarExp("v"), new VarExp("nr2"),1),
                        new PrintStmt(new VarExp("v")), new PrintStmt(new VarExp("nr2"))))));
        PrgState prg5 = new PrgState(stack5, new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), example_5);
        IRepository repo5 = new Repository(prg5, "log5.txt");
        Controller ctr5 = new Controller(repo5);

        TextMenu menu = new TextMenu();

        repo1.addState(prg1);
        repo2.addState(prg2);
        repo3.addState(prg3);
        repo4.addState(prg4);
        repo5.addState(prg5);

        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExample("1", example_1.toString(), ctr1));
        menu.addCommand(new RunExample("2", example_2.toString(), ctr2));
        menu.addCommand(new RunExample("3", example_3.toString(), ctr3));
        menu.addCommand(new RunExample("4", example_4.toString(), ctr4));
        menu.addCommand(new RunExample("5", example_5.toString(), ctr5));

        menu.show();
    }
}