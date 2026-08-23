(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
SetOptions[ContourPlot, Frame->None, Axes->False, ContourShading->None];
SetOptions[VectorPlot, VectorPoints->{20}, Frame->None, VectorAspectRatio->0.3, VectorScaling->"Linear", VectorColorFunctionScaling->True];
p[a_, b_, r_] := Exp[(-(x-a)^2-(y-b)^2) / r]
q[a_, b_, r_] := Exp[-(x-a)(y-b) / r]


f = 1 / ((x + 1.13)^2 + 2(y - 0.03)^2 + 0.1) - 1 / (2(x - 0.72)^2 + (y - 0.87)^2 + 0.1) - 1/((x - 1.14)^2 + (y + 0.45)^2 + 0.1) - x + 3y;
grad = Evaluate[{D[f, x], D[f, y]}];
v = Table[{{i, j}, grad /. {x->i, y->j}}, {i, -2, 2, 4/23}, {j, -2, 2, 4/23}] // Flatten[#, 1]&;
{max, min} = Norm /@ v[[All, 2]] // {Max[#], Min[#]}&;
Show[{ContourPlot[f, {x, -1.8, 2}, {y, -1.4, 1.8}, Contours->Automatic],
  ListVectorPlot[v, VectorSizes->{min/max, 1}, VectorColorFunction->"SolarColors", VectorPoints->All]}]
Export["8-vc-grad.pdf", %]


f = -(9 p[-0.43, 0.53, 0.6] + 5 p[1.23, -1.03, 0.5] - 3 p[-0.43, -1.13, 0.1] + 0.7(x + 0.1y));
ContourPlot[f, {x, -2, 2}, {y, -2, 2}, Contours->Automatic]
v = Table[{{i, j}, grad/.{x->i, y->j}}, {i, -2, 2, 4/23}, {j, -2, 2, 4/23}] // Flatten[#, 1]&;
{max, min} = Norm/@v[[All, 2]] // {Max[#], Min[#]}&;
ListVectorPlot[v, VectorSizes->{min/max, 1}, VectorColorFunction->None, VectorPoints->All]
Export["8-vc-grad-ex1.pdf", %]


PlotVector[vec_] := Module[{vvv, max, min},
  vvv = Table[{{i, j}, vec/.{x->i, y->j}}, {i, -2, 2, 4/10}, {j, -2, 2, 4/10}] // Flatten[#, 1]&;
  {max, min} = Norm/@vvv[[All, 2]] // {Max[#], Min[#]}&;
  Print[{{Div[vec, {x, y}], Curl[{vec[[1]], vec[[2]], 0}, {x, y, z}]}, min, max}];
  ListVectorPlot[vvv, VectorSizes->1.4{min/max, 1}, VectorColorFunction->(Black&), VectorPoints->All, ImageSize->200]]
GraphicsRow[{
  PlotVector[{2, 1}],
  PlotVector[{3, x}],
  PlotVector[{x, y}],
  PlotVector[{-x, -y}]
}]
Export["8-vc-div-curl-1.pdf", %]


GraphicsRow[{
  PlotVector[{-y, x}],
  PlotVector[{y, -x}],
  PlotVector[{x^2+y^2, 2x y}],
  PlotVector[{x^2-y^2, 2 x y}]
}]
Export["8-vc-div-curl-2.pdf", %]



