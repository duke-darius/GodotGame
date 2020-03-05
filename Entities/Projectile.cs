using Godot;
using System;

public class Projectile : KinematicBody2D
{
	public Projectile(){
		GD.Print($"Projectile {Name} crated");
	}

	public float speed = 500;
	public Vector2 direction = new Vector2(1,1);


	public void Init(Vector2 dir){
		direction = dir;
	}

	public override void _Ready(){
		SetAsToplevel(true);
	}
	public override void _PhysicsProcess(float delta){
		
		MoveAndCollide(direction.Normalized() * speed * delta);
	}
}
