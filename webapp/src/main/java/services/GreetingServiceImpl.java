package services;

public class GreetingServiceImpl implements GreetingService
{
    public String getText(String value)
    {
        return "Response: " + value;
    }
}
