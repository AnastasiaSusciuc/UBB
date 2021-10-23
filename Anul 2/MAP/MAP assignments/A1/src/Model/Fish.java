package Model;

public class Fish implements IEntity {
    private int age;
    private String colour;
    private String name;

    public Fish(String name, String colour, int age) {
        this.name = name;
        this.age = age;
        this.colour = colour;
    }

    @Override
    public int getAge() {
        return age;
    }

    @Override
    public void setAge(int age) {
        this.age = age;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public String getColour() {
        return colour;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public boolean isOlderThan(int age) {
        return this.getAge() >= age;
    }

    @Override
    public String toString() {
        return "Name" + this.getName() + ", Colour: " + this.getColour() + ", Age: " + this.getAge();
    }
}