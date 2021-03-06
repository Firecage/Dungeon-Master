/mob/WorkShops/Masonary
	name = "Masonry"

/mob/WorkShops/Masonary/Left
	density = 1
	layer = 4
	icon = 'Cave.dmi'
	icon_state = "WorkShopLeft2"

/mob/WorkShops/Masonary/Right
	density = 1
	layer = 4
	icon = 'Cave.dmi'
	icon_state = "WorkShopRight2"

/mob/WorkShops/Masonary/DblClick()
	for(var/mob/Monsters/M in usr.Selected)
		if(M.Race == "Spider") return
		if(M.Wagon == 1) return
		var/list/menu = new()
		menu += "Craft"
		menu += "Destroy"
		menu += "Cancel"
		var/Result = input("What Action Will You Choose?", "Choose", null) in menu
		if (Result != "Cancel")
			..()
		if (Result == "Destroy")
			if(M in range(1,src))
				M.DestroyMason()
		if (Result == "Craft")
			var/list/menu2 = new()
			menu2 += "Stone Pillar"
			menu2 += "Stone Door"
			menu2 += "Anti-Portal Stone"
			menu2 += "Stone Fence"
			menu2 += "Stone Statue"
			menu2 += "Tomb Stone"
			if(M.StoneCraftingSkill>=100) menu2 += "Form Gargoyle"
			menu2 += "Cancel"
			var/Result2 = input("What Action Will You Choose?", "Choose", null) in menu2
			if (Result2 != "Cancel") ..()
			if (Result2 == "Form Gargoyle") if(M.StoneCraftingSkill>=100)
				var/obj/Items/ores/stone/S
				var/obj/Items/Traps/Cages/C
				var/obj/Items/gems/Diamond/D
				var/obj/Items/gems/Diamond/DD
				var/mob/Monsters/MS
				for(S in M)
					break
				for(D in M)
					break
				for(DD in M)
					if(DD!=D)
						break
					else
						DD=null
				for(C in M)
					for(MS in C)
						break
					if(!MS)
						C=null
					else
						break
				if(S && D && DD && C && MS)
					M.StoneCraftingSkill -= 100
					var/mob/Monsters/Gargoyle/G = new(M.loc)
					G.ChangeOwnership(M.Owner)
					G.PillarPowerup()
					G.name = "{[usr]} Gargoyle"
					MS.loc = M.loc
					G.Strength += MS.Strength / 12
					G.Agility += MS.Agility / 12
					G.weightmax += MS.weightmax
					G.Defence += MS.Strength/12+Agility/12
					G.MagicalAptitude = MS.MagicalAptitude
					view(M) << "<b><font color=red>[M] uses [MS]'s soul to create a gargoyle!"
					C.underlays = null
					C.overlays = null
					C.HasPersonIn = 0
					MS.loc=M.loc
					MS.InHole = 0
					MS.Caged = 0
					MS.GoingToDie = 1
					MS.Killer = M
					MS.Death()
					M.weight -= S.weight + D.weight + DD.weight
					del(S)
					del(D)
					del(DD)
					return
				usr<<"You need 100 Stonecrafting, 1 Stone, 2 Cut Diamonds, and a Caged Prisioner to use the soul of to make a Gargoyle."
			if (Result2 == "Anti-Portal Stone")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						for(var/obj/Items/gems/Diamond/S2 in M)
							for(var/obj/Items/gems/Ruby/S3 in M)
								var/fail
								fail = prob(M.StoneCraftingSkill*3)
								if(fail == 0)
									usr<< "Failed!"
									M.weight -= S.weight
									del(S)
									M.StoneCraftingSkill += 1
									break
									return
								var/obj/Items/Furniture/Pillars/PortalStone/T = new
								T.loc = M.loc
								M.weight -= S.weight
								M.weight -= S2.weight
								M.weight -= S3.weight
								M.StoneCraftingSkill += 1
								del(S)
								del(S2)
								del(S3)
								return
							break
						break
					usr << "You need a cut diamond, a cut ruby, and a stone to make this."
			if (Result2 == "Stone Statue")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						var/fail
						fail = prob(M.StoneCraftingSkill*4)
						if(fail == 0)
							usr<< "Failed!"
							M.weight -= S.weight
							del(S)
							M.StoneCraftingSkill += 1
							break
							return
						var/obj/Items/Furniture/Pillars/Statue/T = new
						T.icon = M.icon
						T.icon_state = M.icon_state
						T.overlays += M.overlays
						T.loc = M.loc
						T.icon += rgb(150,150,150)
						T.dir = M.dir
						M.weight -= S.weight
						M.StoneCraftingSkill += 1
						T.desc = "This is a statue of [M] it is made from [S]."
						T.name = T.desc
						for(var/obj/F in T.overlays) F.icon += rgb(150,150,150)
						del(S)
						break
						return
			if (Result2 == "Stone Fence")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						var/fail
						fail = prob(M.StoneCraftingSkill*4)
						if(fail == 0)
							usr<< "Failed!"
							M.weight -= S.weight
							del(S)
							M.StoneCraftingSkill+=1
							break
							return
						var/obj/Items/Furniture/Fences/StoneFence/LB = new
						if(M.StoneCraftingSkill >= 90)
							LB.CraftRank = "Epic Quality"
						if(M.StoneCraftingSkill >= 100)
							LB.CraftRank = "Legendary Quality"
						if(M.StoneCraftingSkill <= 90)
							LB.CraftRank = "Epic Quality"
						if(M.StoneCraftingSkill <= 75)
							LB.CraftRank = "Masterful Quality"
						if(M.StoneCraftingSkill <= 60)
							LB.CraftRank = "Grand Quality"
						if(M.StoneCraftingSkill <= 50)
							LB.CraftRank = "Impressive Quality"
						if(M.StoneCraftingSkill <= 40)
							LB.CraftRank = "Quality"
						if(M.StoneCraftingSkill <= 30)
							LB.CraftRank = "Average Quality"
						if(M.StoneCraftingSkill <= 20)
							LB.CraftRank = "Poor Quality"
						LB.DoorCraft()
						M.StoneCraftingSkill += 0.5
						M.weight -= S.weight
						LB.loc = M.loc
						del(S)
						break
						return
			if (Result2 == "Stone Door")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						var/fail
						fail = prob(M.StoneCraftingSkill*4)
						if(fail == 0)
							usr<< "Failed!"
							M.weight -= S.weight
							M.StoneCraftingSkill += 1
							del(S)
							break
							return
						var/obj/Items/Furniture/Doors/StoneDoor/LB = new
						if(M.StoneCraftingSkill >= 90)
							LB.CraftRank = "Epic Quality"
						if(M.StoneCraftingSkill >= 100)
							LB.CraftRank = "Legendary Quality"
						if(M.StoneCraftingSkill <= 90)
							LB.CraftRank = "Epic Quality"
						if(M.StoneCraftingSkill <= 75)
							LB.CraftRank = "Masterful Quality"
						if(M.StoneCraftingSkill <= 60)
							LB.CraftRank = "Grand Quality"
						if(M.StoneCraftingSkill <= 50)
							LB.CraftRank = "Impressive Quality"
						if(M.StoneCraftingSkill <= 40)
							LB.CraftRank = "Quality"
						if(M.StoneCraftingSkill <= 30)
							LB.CraftRank = "Average Quality"
						if(M.StoneCraftingSkill <= 20)
							LB.CraftRank = "Poor Quality"
						LB.DoorCraft()
						M.StoneCraftingSkill += 0.5
						M.weight -= S.weight
						LB.loc = M.loc
						del(S)
						break
						return
			if (Result2 == "Tomb Stone")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						var/fail
						fail = prob(M.StoneCraftingSkill*4)
						if(fail == 0)
							usr<< "Failed!"
							M.weight -= S.weight
							del(S)
							M.StoneCraftingSkill += 1
							break
							return
						var/obj/Items/Graves/TombStone/LB = new
						LB.loc = M.loc
						M.weight -= S.weight
						M.StoneCraftingSkill += 1
						del(S)
						break
						return
			if (Result2 == "Stone Pillar")
				if(M in range(1,src))
					for(var/obj/Items/ores/stone/S in M)
						var/fail
						fail = prob(M.StoneCraftingSkill*4)
						if(fail == 0)
							usr<< "Failed!"
							M.weight -= S.weight
							del(S)
							M.StoneCraftingSkill += 1
							break
							return
						if(M)
							var/obj/Items/Furniture/Pillars/DwarfPillar/LB = new
							LB.loc = M.loc
							M.weight -= S.weight
							if(M.StoneCraftingSkill >= 90)
								LB.CraftRank = "Epic Quality"
							if(M.StoneCraftingSkill >= 100)
								LB.CraftRank = "Legendary Quality"
							if(M.StoneCraftingSkill <= 90)
								LB.CraftRank = "Epic Quality"
							if(M.StoneCraftingSkill <= 75)
								LB.CraftRank = "Masterful Quality"
							if(M.StoneCraftingSkill <= 60)
								LB.CraftRank = "Grand Quality"
							if(M.StoneCraftingSkill <= 50)
								LB.CraftRank = "Impressive Quality"
							if(M.StoneCraftingSkill <= 40)
								LB.CraftRank = "Quality"
							if(M.StoneCraftingSkill <= 30)
								LB.CraftRank = "Average Quality"
							if(M.StoneCraftingSkill <= 20)
								LB.CraftRank = "Poor Quality"
							M.StoneCraftingSkill += 1
							LB.FurnitureCraft()
							M.StoneCraftingSkill += 1
							del(S)
							break
							return
