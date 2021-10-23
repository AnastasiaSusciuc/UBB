package Exception;

public class CustomException extends Exception {
    public CustomException(String message) {
        super(message);
    }

    @Override
    public String toString() {
        return "Error: " + super.getMessage();
    }
}