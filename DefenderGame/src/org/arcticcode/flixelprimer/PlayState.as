package org.arcticcode.flixelprimer
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	
	public class PlayState extends FlxState
	{
		[Embed( source="/assets/audio/ExplosionShip.mp3" )]
		private var SoundExplosionShip:Class;
		[Embed( source="/assets/audio/ExplosionAlien.mp3" )]
		private var SoundExplosionAlien:Class;
		[Embed( source="/assets/audio/Bullet.mp3" )]
		private var SoundBullet:Class;
		
		private var _ship:Ship;
		private var _aliens:FlxGroup;
		private var _bullets:FlxGroup;
		private var _spawnTimer:Number;
		private var _spawnInterval:Number = 2.5;
		private var _scoreText:FlxText;
		private var _gameOverText:FlxText;
		
		override public function update():void
		{
			if ( FlxG.keys.justPressed( "SPACE" ) && _ship.dead == false )
			{
				spawnBullet( _ship.getBulletSpawnPosition());
			}
			
			if ( FlxG.keys.justPressed( "ENTER" ) && _ship.dead )
			{
				FlxG.state = new PlayState();
			}
			
			FlxU.overlap(_aliens, _bullets, overlapAlienBullet);
			FlxU.overlap(_aliens, _ship, overlapAlienShip);
			
			_spawnTimer -= FlxG.elapsed;
			
			if ( _spawnTimer < 0 )
			{
				spawnAlien();
				resetSpawnTimer();
			}
			super.update();
		}
		
		override public function create():void
		{
			bgColor = 0xFFABCC7D;
			
			_ship = new Ship();
			add( _ship );
			
			_aliens = new FlxGroup();
			add( _aliens );
			
			_bullets = new FlxGroup();
			add( _bullets );
			
			FlxG.score = 0;
			_scoreText = new FlxText( 10, 8, 200, FlxG.score.toString());
			_scoreText.setFormat( null, 32, 0xFF597137, "left" );
			add( _scoreText );
			
			resetSpawnTimer();
			
			super.create();
		}
		
		private function spawnAlien():void
		{
			var x:Number = FlxG.width;
			var y:Number = Math.random() * ( FlxG.height - 100 ) + 50;
			_aliens.add( new Alien( x, y ));
		}
		
		private function resetSpawnTimer():void
		{
			_spawnTimer = _spawnInterval;
			_spawnInterval *= 0.95;
			
			if ( _spawnInterval < 0.1 )
			{
				_spawnInterval = 0.1;
			}
		}
		
		private function spawnBullet( p:FlxPoint ):void
		{
			FlxG.play(SoundBullet);
			var bullet:Bullet = new Bullet( p.x, p.y );
			_bullets.add( bullet );
		}
		
		private function overlapAlienBullet( alien:Alien, bullet:Bullet ):void
		{
			FlxG.play(SoundExplosionAlien);
			alien.kill();
			bullet.kill();
			FlxG.score += 1;
			_scoreText.text = FlxG.score.toString();
			
			var emitter:FlxEmitter = createEmtter();
			emitter.at(alien);
		}
		
		private function overlapAlienShip( alien:Alien, ship:Ship ):void
		{
			FlxG.play(SoundExplosionShip);
			
			ship.kill();
			alien.kill();
			FlxG.quake.start( 0.02 );
			
			_gameOverText = new FlxText( 0, FlxG.height / 2, FlxG.width, "Game Over\nPress ENTER To Play Again" );
			_gameOverText.setFormat( null, 16, 0xFF597137, "center" );
			add( _gameOverText );
			
			var emitter:FlxEmitter = createEmtter();
			emitter.at(ship);
		}
		
		private function createEmtter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.delay = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed(-500, 500);
			emitter.setYSpeed(-500, 500);
			var particles:int = 10;
			for(var i:uint = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFF597137);
				particle.exists = false;
				emitter.add(particle);
			}
			
			emitter.start();
			add(emitter);
			return emitter;
		}
	}
}