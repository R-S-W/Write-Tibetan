/*
BezierInterpolationND is a class that takes a list of n-dimensional points
and can be used to return the control points of a bezier cubic spline function.

Process:
The input data is split into n lists for each dimension, acting as a function
parametrized by the index of the list.  For each of these functions, a 1D
bezier function can be run to determine the nontrivial control points that can
generate the cubic spline functions.**  The nontrivial control points are then
grouped together into a list of n-dimensional vectors that are the n-dimensional
control points.  This list is returned to generate the bezier splines.

** For every pair of points A and B in any of the n functions, there are 4 scalar
control points.  The first and last are A and B respectively.  There exist two
more control points between A and B that are computed by this class.

As a reminder, the first and last control points are not added into the final
result, as they already are available in the input data.
 */

import 'dart:ui';


class BezierInterpolationND{
  List<List<double>> dataPoints;
  int n;
  int dim;
  List<List<double>> dpTranspose; //Matrix transpose of dataPoints

  BezierInterpolationND(this.dataPoints){
    this.n = this.dataPoints.length-1;
    if (this.n == 0){
      this.dim = 0;
    }else{
      this.dim = this.dataPoints[0].length;
      this.dpTranspose = [];

      for (int i =0; i< this.dim; i++){
        this.dpTranspose.add([]);
        for (int j = 0; j< this.n+1; j++){
          this.dpTranspose[i].add(this.dataPoints[j][i]);
        }
      }
    }
  }



  List<List<Offset>> computeControlPointsND(){
    List<List<Offset>> temparr = [];
    List<List<Offset>> controlPointsByPoint = []; //transpose of temparr
    for (int d =0; d< this.dim; d++){
      temparr.add(computeControlPoints1D(this.dpTranspose[d]));
    }

    for (int i = 0; i< this.n; i++){
      List<Offset> controlPointPairs = [];
      for (int d =0; d<this.dim; d++){
        controlPointPairs.add(temparr[d][i]);
      }
      controlPointsByPoint.add(controlPointPairs);
    }
    return controlPointsByPoint;
  }


  List<Offset> computeControlPoints1D(List<double> varr){
    //Compute the nontrivial control points of the input list.
    //Implementation of Thomas Algorithm for tridiagonal matrices
    List<double> constVec = _generateConstantVector(varr);//length n+1
    //holds a 2 member list, first element is how many a_n-1 there are, second being a constant.
    List<Offset> p1table = [];
    for (int a = 0; a< this.n; a++){
      p1table.add(Offset.zero);
    }
    int i = this.n-1;
    p1table[i] = Offset(1,0);
    i--;
    p1table[i] = Offset(-7,constVec.last)/2;
    i--;

    for (; 0 <= i; i--){
      p1table[i] = Offset(0,constVec[i+1]) - p1table[i+1]*4 - p1table[i+2];
    }
    Offset temp = Offset(0,constVec[0]) - p1table[1] - p1table[0]*2;
    double lastVar = -temp.dy/temp.dx;
    List<double> p1vals = [];
    for (int j = 0; j<this.n;j++){
      p1vals.add(p1table[j].dx*lastVar + p1table[j].dy);
    }


    List<double> p2vals = [];
    for (int j = 0; j< this.n-1; j++){
      p2vals.add(2*varr[j+1] - p1vals[j+1]);
    }
    p2vals.add((p1vals[this.n-1]+varr[this.n])/2);

    List<Offset> ansarr = [];
    for (int j =0; j< this.n; j++){
      ansarr.add(Offset(p1vals[j],p2vals[j]));
    }
    return ansarr;
  }


  List<double> _generateConstantVector(List<double> dpoints){
    List<double> constVec = [dpoints[0]+2*dpoints[1]];
    for (int i=1; i< this.n-1; i++){
      constVec.add(2*(2*dpoints[i]+dpoints[i+1]));
    }
    constVec.add(8*dpoints[this.n-1]+dpoints[this.n]);
    return constVec;
  }



}
