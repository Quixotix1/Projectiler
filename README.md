# Projectiler
Projectiler was a game jam project created in Godot for the GMTK Game Jam 2024. It features a complete top-down shooter system with an inventory system, shop, dynamic bullet drops, and four enemies that appear through a series of waves.

Created by Josh Geelen 100968153

A modification of the game jam project "Projectiler" to include more varied bullet systems. In particular, this mod project created a new singleton, the "Bullet Factory," which allows bullets to be created much more easily and dynamically.

## Essential Design Target:
<img width="898" height="502" alt="image" src="https://github.com/user-attachments/assets/ded14f30-aae6-45c7-b9d2-696b3f5a6831" />

## Old:
<img width="958" height="747" alt="image" src="https://github.com/user-attachments/assets/94ea9e08-5e29-47bd-a0fd-1be95543b7b4" />
<img width="762" height="483" alt="image" src="https://github.com/user-attachments/assets/899f15d3-dbaf-45c5-a628-bfd7ff8dbf8c" />

## New:
<img width="645" height="379" alt="image" src="https://github.com/user-attachments/assets/7cecdb99-bf93-474e-a4d5-45b0bada66ae" />
<img width="906" height="508" alt="image" src="https://github.com/user-attachments/assets/c7b429a9-6ed8-48bb-a0d9-432302c813e8" />
<img width="439" height="154" alt="image" src="https://github.com/user-attachments/assets/751b3393-f371-4f0e-96ed-8ff7d1b1d399" />
<img width="783" height="442" alt="image" src="https://github.com/user-attachments/assets/930b19a7-7cc1-4254-b61f-5d80618d1f4c" />

One of the particular upsides of this method is that bullets can be made much more unique since they are now decoupled from one another and collated individually in the factory script. For demonstration, the fire bullet script was modified to feature a unique movement system, and the project's current state has the player with a 2333 fire bullet and 2 additional bullet levels to demonstrate the changes.
<img width="1011" height="436" alt="image" src="https://github.com/user-attachments/assets/5e6d697f-642b-4a41-a5aa-c3615451e5d4" />
