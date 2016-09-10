package
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import mx.core.UIComponent;

    import services.IGreetingService;

    public class MainPresenter extends UIComponent
    {
        public function MainPresenter()
        {

            var button:MovieClip = new MovieClip();
            button.graphics.beginFill(0xFF0000);
            button.graphics.drawRect(500, 500, 100, 50);
            button.graphics.endFill();
            addChild(button);

            _textRequest.text = "Type something";
            _textRequest.width = 100;
            _textRequest.height = 30;
            _textRequest.border = true;
            _textRequest.type = TextFieldType.INPUT;
            _textRequest.x = 500;
            _textRequest.y = 400;
            addChild(_textRequest);

            _textResponse.text = "Waiting for response...";
            _textResponse.width = 100;
            _textResponse.height = 30;
            _textResponse.x = 500;
            _textResponse.y = 450;
            addChild(_textResponse);
            button.addEventListener(MouseEvent.CLICK, clickSend);

        }
        public var service:IGreetingService;
        private var _textResponse:TextField = new TextField();
        private var _textRequest:TextField = new TextField();

        public function setText(value:String):void
        {
            _textResponse.text = value;
        }

        private function clickSend(event:MouseEvent):void
        {
            service.getText(_textRequest.text);
        }
    }
}