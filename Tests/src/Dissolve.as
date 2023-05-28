package {
    import com.arcticcode.greenFlames.graphics.ColourUtils;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;

    public class Dissolve extends Sprite {
        private var _bitmap:BitmapData;
        private var _bitmap2:BitmapData;
        private var _image:Bitmap;
        private var _seed:Number;
        private var _pixelCount:int = 0;

        public function Dissolve(  ) {
            _bitmap = new BitmapData(stage.stageWidth,
                                  stage.stageHeight,
                                  false, ColourUtils.getRanColor());
            _bitmap2 = new BitmapData(stage.stageWidth,
                                   stage.stageHeight,
                                   false, ColourUtils.getRanColor());
            _image = new Bitmap(_bitmap);
            addChild(_image);
            _seed = Math.random(  ) * 100000;
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function onEnterFrame(event:Event):void {
            _seed = _bitmap.pixelDissolve(_bitmap2,
                                       _bitmap.rect,
                                       new Point(  ),
                                       _seed,
                                       1000,ColourUtils.getRanColor());
            _pixelCount += 1000;
            if(_pixelCount > _bitmap.width * _bitmap.height) {
            	trace("Complete");
                removeEventListener(Event.ENTER_FRAME,
                                    onEnterFrame);
            }
        }
    }
}