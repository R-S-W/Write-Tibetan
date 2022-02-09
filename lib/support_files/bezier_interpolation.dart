import 'dart:ui';



class BezierInterpolationND{
  List<List<double>> dataPoints;
  int n;
  int dim;
  List<List<double>> dpTranspose;

  BezierInterpolationND(this.dataPoints){
    this.n = this.dataPoints.length-1;
    // print('Bez   dp n:${this.dataPoints.length}, ${this.n}');
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
    List<double> constVec = _generateConstantVector(varr);//length n+1

    List<Offset> p1table = [];  // holds a 2 member list, first element is how many a_n-1 there are, second being a constant.
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


  // Offset calcVar(int rowIdx, List<Offset> table, List<double> constVector){
  //   return ;
  // }


  List<double> _generateConstantVector(List<double> dpoints){
    List<double> constVec = [dpoints[0]+2*dpoints[1]];
    for (int i=1; i< this.n-1; i++){
      constVec.add(2*(2*dpoints[i]+dpoints[i+1]));
    }
    constVec.add(8*dpoints[this.n-1]+dpoints[this.n]);
    return constVec;
  }



}
