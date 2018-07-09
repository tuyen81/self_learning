#include <stdio.h>
//#include "points.h"

#define MAX_POINTS 100
#define SPACE_DIMENSION 2

int main()
{
  int number_points, i = 0;
  float points[MAX_POINTS][2], temp;

  printf("The number of points in our space: \n");
  scanf("%d",&number_points);
  for (i = 0; i < number_points; i++) {
    printf("please input the X and Y \n");
    printf("X = \n");
    scanf("%f", &temp);
    points[i][0] = temp;
    printf("Y = \n");
    scanf("%f", &temp);
    points[i][1] = temp;
  }

  printf("the points you have just inputed \n");
  for (i = 0; i < number_points; i++) {
    printf("the point %d has X = %f, Y = %f \n", i, points[i][0], points[i][1]);
  }

}

void input_points(float points[][SPACE_DIMENSION], int number_points){


}
