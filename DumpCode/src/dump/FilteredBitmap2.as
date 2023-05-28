package {
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.filters.BlurFilter;
    import flash.events.Event;
    import flash.geom.Point;

    public class FilteredBitmap2 extends Sprite {
        private var _bitmap:BitmapData;
        private var _bitmap2:BitmapData;
        private var _image:Bitmap;
        private var _blurFilter:BlurFilter;

        public function FilteredBitmap2(  ) {
            _bitmap = new BitmapData(stage.stageWidth, stage.stageHeight,
                                  false, 0xff000000);
            _bitmap2 = new BitmapData(stage.stageWidth, stage.stageHeight,
                                   false, 0xff000000);
            _image = new Bitmap(_bitmap);
            addChild(_image);
            _blurFilter = new BlurFilter(  );
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function onEnterFrame(event:Event):void {
            for(var i:int = 0; i < 100; i++) {
            _bitmap2.setPixel(mouseX + Math.random(  ) * 20 - 10,
                           mouseY + Math.random(  ) * 20 - 10,
                          0xffffffff);
            }
            _bitmap.applyFilter(_bitmap2, _bitmap.rect, new Point(  ), _blurFilter);
        }
    }
}