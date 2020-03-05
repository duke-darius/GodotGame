using Godot;
using System;

public class Player : KinematicBody2D
{
	public float MAX_SPEED = 200;
	public float ACC = 700;
	public Vector2 motion = Vector2.Zero;

	
	
	public override void _PhysicsProcess(float delta){
		var axis = GetInputAxis();

		if (axis == Vector2.Zero){
			ApplyFriction(ACC * delta);
		}else{
			ApplyMotion(axis * ACC * delta);
		}
		motion = MoveAndSlide(motion);


		if(Input.IsActionJustPressed("ui_fire")){
			FireProjectile();
		}
	}

	public Vector2 GetInputAxis(){
		var axis = Vector2.Zero;
		axis.x = (Input.IsActionPressed("ui_right")?1:0) - (Input.IsActionPressed("ui_left")?1:0);
		axis.y = ( Input.IsActionPressed("ui_down")?1:0) - (Input.IsActionPressed("ui_up")?1:0);

		MAX_SPEED = (Input.IsActionPressed("ui_sprint")? 300: 200);

		return axis.Normalized();
	}

	public void ApplyFriction(float amount){
		if(motion.Length() > amount){
			motion -= motion.Normalized() * amount;
		}
		else{
			motion = Vector2.Zero;
		}
	}

	public void ApplyMotion(Vector2 acceleration){
		motion += acceleration;
		motion = motion.Clamped(MAX_SPEED);
	}

	public void FireProjectile(){
		GD.Print("Fire");
		
		var world = (ResourceLoader.Load("res://World.tscn") as PackedScene).Instance();
		var ps = (ResourceLoader.Load("res://Entities/Projectile.tscn") as PackedScene);
		Projectile projectile = new Projectile();
		if(ps != null){
			GD.Print("Scene is not null");
			world.AddChild(ps.Instance());
		}else{
			GD.Print("Oof");
		}


		projectile.Init((GetGlobalMousePosition() - GlobalPosition).Normalized());
		GD.Print("New vector: " + projectile.direction.ToString());
		AddChild(projectile);


		
	}

	


}
	

