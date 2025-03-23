package utils;

import account.Account;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {

    public static String validateAccount(Account account) {
        
        String error;

        error = validateUsername(account.getUsername());
        if (!error.equals("Valid")) return error;

        error = validatePassword(account.getPassword());
        if (!error.equals("Valid")) return error;
        
        error = validateName(account.getName());
        if (!error.equals("Valid")) return error;

        error = validateAddress(account.getAddress());
        if (!error.equals("Valid")) return error;

        error = validateEmail(account.getEmail());
        if (!error.equals("Valid")) return error;

        error = validatePhone(account.getPhone());
        if (!error.equals("Valid")) return error;

        return "Valid";
    }

    private static String validateUsername(String username) {
        if (username == null || username.length() < 3 || username.length() > 20 || username.contains(" ")) {
            return "Username must be between 3 and 20 characters and have no space.";
        }
        return "Valid";
    }

    private static String validatePassword(String password) {
        if (password == null || password.length() < 8) {
            return "Password must be at least 8 characters long.";
        }
        boolean hasUpper = false, hasDigit = false, hasSpecial = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            if (Character.isDigit(c)) hasDigit = true;
            if (!Character.isLetterOrDigit(c)) hasSpecial = true;
        }
        if (!hasUpper || !hasDigit || !hasSpecial) {
            return "Password must contain at least 1 uppercase letter, 1 number, and 1 special character.";
        }
        return "Valid";
    }

    private static String validateName(String name) {
        if (name == null || name.length() < 3 || name.length() > 30) {
            return "Name must be between 3 and 30 characters.";
        }
        return "Valid";
    }

    private static String validateAddress(String address) {
        if (address == null || address.length() > 100) {
            return "Address must not exceed 100 characters.";
        }
        return "Valid";
    }

    private static String validateEmail(String email) {
        if (email == null || !email.contains("@") || !email.contains(".")) {
            return "Invalid email format.";
        }
        return "Valid";
    }

    private static String validatePhone(String phone) {
        if (phone == null || phone.length() < 10 || phone.length() > 14) {
            return "Phone number must be between 10 and 14 characters.";
        }
        for (char c : phone.toCharArray()) {
            if (!Character.isDigit(c)) {
                return "Phone number must contain only digits.";
            }
        }
        return "Valid";
    }
    public static String hash(String password) throws NoSuchAlgorithmException{
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashedPassword = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedPassword) {
            sb.append(String.format("%02X", b));
        }
        return sb.toString();
    }
}
