mob/Monsters/Gargoyle
	UsesPoison=1
	icon = 'Gargoyle.dmi'
	density = 1
	weightmax = 160
	Race = "Gargoyle"
	SubRace = "Stone"
	IsWood = 0
	Running = 1
	Delay = 5
	Carn = 1
	ImmuneToMagic = 1
	ImmuneToTemperature = 1
	SpearSkill = 10
	HasWings = 1
	SwordSkill  = 10
	Skinned = 1
	AxeSkill  = 10
	MaceSkill  = 10
	ImmunePoison = 1
	UnArmedSkill  = 50
	BowSkill = 10
	ShieldSkill  = 10
	WearingFullPlateHelm = 1
	ArmourSkill  = 10
	WingsOut = 1
	WoodCraftingSkill  = 10
	MetalCraftingSkill  = 15
	SkinningSkill  = 10
	ButcherySkill  = 10
	LeatherCraftingSkill  = 10
	PoisonSkill  = 10
	BoneCraftingSkill  = 10
	StoneCraftingSkill  = 35
	SneakingSkill  = -10
	LockPickingSkill = 0
	JewlCraftingSkill = 35
	CookingSkill  = 0
	FishingSkill  = -10
	HasLeftEye = 1
	HasRightEye = 1
	HasTeeth  = 1
	HasLeftArm  = 1
	HasRightArm = 1
	HasLeftLeg = 1
	HasRightLeg = 1
	HasHead = 1
	HasLeftEar = 1
	HasRightEar = 1
	HasNose = 1
	OrganMaxHP = 155

mob/Monsters/Gargoyle/New()
	Age = rand(20,60)
	usr.Strength += rand(20,25)
	usr.Agility += rand(2,5)
	usr.Defence += 40
	usr.Intelligence += rand(-5,-8)
	usr.DieAge += rand(2000,5000)
	StartAllProcs()
	..()
	var/image/I = new('mob.dmi',src)
	src.Star = I