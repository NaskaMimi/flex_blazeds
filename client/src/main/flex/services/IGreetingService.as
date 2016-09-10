package services
{
    import flash.events.IEventDispatcher;

    import mx.rpc.AsyncToken;

    public interface IGreetingService extends IEventDispatcher
    {
        function getText(value:String):AsyncToken;
    }
}
