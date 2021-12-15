import java.io.BufferedReader;
import java.io.IOException;

import controller.Controller;
import model.ADT.*;
import model.expression.*;
import model.state.PrgState;
import model.exception.*;
import model.statement.*;
import model.type.BoolType;
import model.type.IntType;
import model.type.RefType;
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

        IStmt example_1 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );

        PrgState prg1 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_1);
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
        PrgState prg2= new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(),  new MyHeap<>(),example_2);
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

        PrgState prg3 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_3);
        IRepository repo3 = new Repository(prg3, "log3.txt");
        Controller ctr3 = new Controller(repo3);

        IStmt example_4 = new CompStmt(new VarDeclStmt("varf", new StringType()), new CompStmt(new AssignStmt("varf", new ValueExp(new StringValue("test.in"))),
                new CompStmt(new OpenRFileStmt(new VarExp("varf")), new CompStmt(new VarDeclStmt("varc", new IntType()),
                        new CompStmt(new ReadFileStmt(new VarExp("varf"),"varc"), new CompStmt(new PrintStmt(new VarExp("varc")),
                                new CompStmt(new ReadFileStmt(new VarExp("varf"),"varc"), new CompStmt(new PrintStmt(new VarExp("varc")), new CloseRFileStmt(new VarExp("varf"))))))))));

        PrgState prg4 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_4);
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

        PrgState prg5 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_5);
        IRepository repo5 = new Repository(prg5, "log5.txt");
        Controller ctr5 = new Controller(repo5);

        // Ref int v;new(v,20);Ref Ref int a; new(a,v);print(v);print(a)
        IStmt example_6 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewHeapStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewHeapStmt("a", new VarExp("v")),
                                        new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                                new PrintStmt(new ArithExp(new ReadHeapExp(new ReadHeapExp(new VarExp("a"))),
                                                        new ValueExp(new IntValue(5)),
                                                        '+')))))));


        PrgState prg6 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_6);
        IRepository repo6 = new Repository(prg6, "log6.txt");
        Controller ctr6 = new Controller(repo6);

        IStmt example_7 = new CompStmt(new VarDeclStmt("x", new IntType()),
                new CompStmt(new AssignStmt("x", new ValueExp(new IntValue(10))),
                        new CompStmt(new WhileStmt(new RelationalExp(new VarExp("x"), new ValueExp(new IntValue(0)), 5), new CompStmt(new PrintStmt(new VarExp("x")), new AssignStmt("x", new ArithExp(new VarExp("x"), new ValueExp(new IntValue(1)), '-')))),
                                new PrintStmt(new VarExp("x")))));



        PrgState prg7 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_7);
        IRepository repo7 = new Repository(prg7, "log7.txt");
        Controller ctr7 = new Controller(repo7);

        // Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);
        IStmt example_8 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewHeapStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                new CompStmt(new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(new ArithExp(new ReadHeapExp(new VarExp("v")), new ValueExp(new IntValue(5)), '+')))
                                )));



        PrgState prg8 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_8);
        IRepository repo8 = new Repository(prg8, "log8.txt");
        Controller ctr8 = new Controller(repo8);

        // Ref int v;new(v,20);Ref Ref int a; new(a,v); new(v,30);print(rH(rH(a)))
        IStmt example_9 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewHeapStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewHeapStmt("a", new VarExp("v")),
                                        new CompStmt(new NewHeapStmt("v", new ValueExp(new IntValue(30))),
                                            new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a"))))))
                        )));



        PrgState prg9 = new PrgState(new MyStack<>(), new MyDictionary<String, IValue>(),  new MyList<IValue>(), new MyDictionary<StringValue, BufferedReader>(), new MyHeap<>(), example_9);
        IRepository repo9 = new Repository(prg9, "log10.txt");
        Controller ctr9 = new Controller(repo9);

        TextMenu menu = new TextMenu();

        repo1.addState(prg1);
        repo2.addState(prg2);
        repo3.addState(prg3);
        repo4.addState(prg4);
        repo5.addState(prg5);
        repo6.addState(prg6);
        repo7.addState(prg7);
        repo8.addState(prg8);
        repo9.addState(prg9);

        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExample("1", example_1.toString(), ctr1));
        menu.addCommand(new RunExample("2", example_2.toString(), ctr2));
        menu.addCommand(new RunExample("3", example_3.toString(), ctr3));
        menu.addCommand(new RunExample("4", example_4.toString(), ctr4));
        menu.addCommand(new RunExample("5", example_5.toString(), ctr5));
        menu.addCommand(new RunExample("6", example_6.toString(), ctr6));
        menu.addCommand(new RunExample("7", example_7.toString(), ctr7));
        menu.addCommand(new RunExample("8", example_8.toString(), ctr8));
        menu.addCommand(new RunExample("9", example_9.toString(), ctr9));

        menu.show();
    }
}