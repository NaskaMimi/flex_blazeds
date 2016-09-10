package services
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.AbstractOperation;
    import mx.rpc.AsyncToken;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.RemoteObject;

    public class GreetingService extends EventDispatcher implements IGreetingService
    {
        private static const CHANNEL_ID:String = "my-amf";
        private static const DESTINATION:String = "greetingService";
        private static const ENDPOINT_URL:String = "http://localhost:8080/webapp/spring/messagebroker/amf";

        public function GreetingService(presenter:MainPresenter)
        {
            super();
            this.presenter = presenter;
            initialize();
        }
        public var presenter:MainPresenter;
        private var _service:RemoteObject;

        public function getText(value:String):AsyncToken
        {
            const operation:AbstractOperation = _service.getOperation("getText");
            operation.addEventListener(FaultEvent.FAULT, getText_faultEventHandler);
            operation.addEventListener(ResultEvent.RESULT, getText_resultEventHandler);

            return operation.send(value);
        }

        protected function initialize():void
        {
            var channel:AMFChannel = new AMFChannel(CHANNEL_ID, ENDPOINT_URL);
            var channelSet:ChannelSet = new ChannelSet();
            channelSet.addChannel(channel);

            _service = new RemoteObject();
            _service.destination = DESTINATION;
            _service.channelSet = channelSet;
        }

        private function getText_resultEventHandler(event:ResultEvent):void
        {
            IEventDispatcher(event.target).removeEventListener(event.type, arguments.callee);

            dispatchEvent(event.clone());

            presenter.setText(event.result.toString());
        }

        private function getText_faultEventHandler(event:FaultEvent):void
        {
            IEventDispatcher(event.target).removeEventListener(event.type, arguments.callee);

            dispatchEvent(event.clone());
        }
    }
}
