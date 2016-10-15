# Shape-From-Shading-Photometric-stereo
**Photometric stereo** The input to the algorithm is a set of photographs taken in known lighting directions and the output of the algorithm is the albedo (paint), normal direction, and the height map.

Steps to execute the code
- Download this folder and copy it in your Matlab Folder.
- Execute eval_code.m .This file generates the albedo, Surface normals and Height Map.
- Change the subjectName in eval_code.m  to see output of different subjects listed in comment.
- In eval_code.m modify the integrationMethod to observe the results of various methods. Allowed methods are listed in the comment.

For *Column,Row and Average* Integration methods. I have used two ways to perform the intergration. 
- Cumsum method to perform intergration. This method does not require for loop.
- Using the previous calculated values to determine the heightmap of current pixel. This is basically dynamic programming. 

Both methods gives exactly same results. *2nd Method* is commented in the getSurface.m file. One can uncomment and verify the results using both above mentioned methods.

![Image](./output/yaleB056.jpg?raw=true)
![Image](./output/yaleB014.jpg?raw=true)
![Image](./output/yaleB022.jpg?raw=true)
![Image](./output/yaleB074.jpg?raw=true)
